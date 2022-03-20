namespace PlordleApi.Services;

public interface IFileReaderService
{
    /// <summary>
    /// Parses players from a csv file
    /// </summary>
    /// <returns>List<Player></returns>
    List<Player> ParsePlayers();
}
