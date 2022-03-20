namespace PlordleApi.Repositories;

public class PlayerRepository : IPlayerRepository
{
    private readonly MongoPlordleDBContext _dbContext;
    private readonly IMongoCollection<Player> _playerCollection;

    public PlayerRepository(IOptions<PlordleDatabaseSettings> options, MongoPlordleDBContext context)
    {
        _dbContext = context;
        _playerCollection = _dbContext.GetCollection<Player>(options.Value.PlordleCollectionName);
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
        return await _playerCollection.Find(searchCondition).FirstOrDefaultAsync();
    }

    public async Task<int> GetPlayerCountAsync()
    {
        return (int) await _playerCollection.CountDocumentsAsync(_ => true);
    }
}
