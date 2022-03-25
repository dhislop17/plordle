namespace PlordleApi.Repositories;

public class PlayerRepository : IPlayerRepository
{
    private readonly MongoPlordleDBContext _dbContext;
    private readonly IMongoCollection<Player> _playerCollection;

    public PlayerRepository(IOptions<PlordleDatabaseSettings> options, MongoPlordleDBContext context)
    {
        _dbContext = context;
        _playerCollection = _dbContext.GetCollection<Player>(options.Value.PlordleCollectionName);
        var indexDef = Builders<Player>.IndexKeys.Ascending(x => x.Name);
        var collation = new CreateIndexOptions() {
            Collation = new Collation(locale: "en", strength: CollationStrength.Primary)
        };
        _playerCollection.Indexes.CreateOne(new CreateIndexModel<Player>(indexDef, collation));
    }

    public async Task AddPlayersAsync(List<Player> players)
    {
        await _playerCollection.InsertManyAsync(players);
    }

    public async Task<List<Player>> GetAllPlayersAsync()
    {
        return await _playerCollection.Find(_ => true).ToListAsync();
    }

    public async Task<Player> GetPlayerAsync(FilterDefinition<Player> searchCondition)
    {
        var findOption = new FindOptions() { Collation = new Collation(locale: "en", strength: CollationStrength.Primary) };
        return await _playerCollection.Find(searchCondition, findOption).FirstOrDefaultAsync();
    }

    public async Task<int> GetPlayerCountAsync()
    {
        return (int) await _playerCollection.CountDocumentsAsync(_ => true);
    }
}
