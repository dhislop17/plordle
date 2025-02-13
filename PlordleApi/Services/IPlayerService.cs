namespace PlordleApi.Services;

public interface IPlayerService
{
    Task SeedDatabase();
    Task<List<Player>> GetAllPlayers();
    Task<Player> GetRandomPlayer(List<string> excludedTeams);
    Task<Player> GetTodaysPlayer(List<string> excludedTeams);
   //Task<Player> GetPlayerById(int id);
    Task<Player> GetPlayerByName(string name);
    Task<PlayerComparisonDto> ComparePlayers(string guessName, List<String> excludedTeams);
}
