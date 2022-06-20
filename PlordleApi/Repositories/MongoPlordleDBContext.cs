namespace PlordleApi.Repositories;

public class MongoPlordleDBContext
{
    private readonly IMongoDatabase _database;
    private readonly MongoClient _client;

    public MongoPlordleDBContext(IOptions<PlordleDatabaseSettings> options)
    {
        _client = new MongoClient(options.Value.ConnectionString);
        _database = _client.GetDatabase(options.Value.DatabaseName);
    }

    public IMongoCollection<T> GetCollection<T>(string name)
    {
        return _database.GetCollection<T>(name);
    }
}
