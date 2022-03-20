namespace PlordleApi.Services;

public interface IPlayerService
{
    Task InitTodaysPlayer();
    Task<Player> GetPlayerById(int id);
    Task<Player> GetPlayerByName(string name);
    Task<List<Player>> GetAllPlayers();
    Task<PlayerComparisonDto> ComparePlayers(string guessName);
}
