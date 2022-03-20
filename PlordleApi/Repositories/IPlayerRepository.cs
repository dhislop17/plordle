namespace PlordleApi.Repositories;

public interface IPlayerRepository
{
    Task<int> GetPlayerCountAsync();
    Task<List<Player>> GetAllPlayersAsync();
    Task<Player> GetPlayerAsync(FilterDefinition<Player> searchCondition);
    Task AddPlayersAsync(List<Player> players);
}
