using MongoDB.Bson;

namespace PlordleApi.Repositories;

public interface IPlayerRepository
{
    Task<int> GetPlayerCountAsync();
    Task<List<Player>> GetAllPlayersAsync();
    Task<List<Player>> GetPlayersUsingFilter(FilterDefinition<Player> filterCondition);
    Task<Player> GetPlayerAsync(FilterDefinition<Player> searchCondition);
    Task AddPlayersAsync(List<Player> players);
}
