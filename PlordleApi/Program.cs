using PlordleApi.Repositories;
using PlordleApi.Services;

var builder = WebApplication.CreateBuilder(args);

//TODO: Consider how this will work when deployed
builder.Services.AddCors(options => {
    options.AddDefaultPolicy(policy => { 
        policy.AllowAnyOrigin(); 
    });
});

// Setup service configuration
builder.Services.Configure<FileReaderSettings>(builder.Configuration.GetSection("FileReader"));
builder.Services.Configure<PlordleDatabaseSettings>(builder.Configuration.GetSection("PlordleDatabase"));

// Add services to the container.
builder.Services.AddSingleton<MongoPlordleDBContext>();
builder.Services.AddTransient<IPlayerRepository, PlayerRepository>();
//builder.Services.AddTransient<IFileReaderService, CsvReaderService>();
builder.Services.AddTransient<IFileReaderService, JsonReaderService>();
builder.Services.AddTransient<IPlayerService, PlayerService>();


builder.Services.AddControllers();
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
builder.Services.AddHealthChecks();


var app = builder.Build();
app.MapHealthChecks("/health");


if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();

    app.UseCors();
}

var provider = app.Services.GetRequiredService<IPlayerService>();
await provider.SeedDatabase();

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
