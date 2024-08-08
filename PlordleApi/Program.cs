using PlordleApi.Repositories;
using PlordleApi.Services;

var builder = WebApplication.CreateBuilder(args);

// Setup service configuration
builder.Services.Configure<FileReaderSettings>(builder.Configuration.GetSection("FileReader"));
builder.Services.Configure<PlordleDatabaseSettings>(builder.Configuration.GetSection("PlordleDatabase"));

// Add services to the container.
builder.Services.AddSingleton<MongoPlordleDBContext>();
builder.Services.AddTransient<IPlayerRepository, PlayerRepository>();
builder.Services.AddTransient<IFileReaderService, FileReaderService>();
builder.Services.AddTransient<IPlayerService, PlayerService>();


builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHealthChecks();


var app = builder.Build();
app.MapHealthChecks("/health");

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

var provider = app.Services.GetRequiredService<IPlayerService>();
await provider.SeedDatabase();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
