namespace PlordleApi.Repositories;

public class MongoPlordleDBContext
{
    private readonly IMongoDatabase _database;
    private readonly MongoClient _client;

    public MongoPlordleDBContext(IOptions<PlordleDatabaseSettings> options)
    {
        var host = options.Value.Host;
        var port = options.Value.Port;
        var user = options.Value.User;
        var password = options.Value.Password;
        var connString =  $@"mongodb+srv://{user}:{password}@{host}";

        //var connString =  $@"mongodb://{host}:{port}";
        //_client = new MongoClient(options.Value.ConnectionString);
        _client = new MongoClient(connString);
        _database = _client.GetDatabase(options.Value.DatabaseName);
    }

    public IMongoCollection<T> GetCollection<T>(string name)
    {
        return _database.GetCollection<T>(name);
    }
}
