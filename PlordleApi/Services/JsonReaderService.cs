
using System.Text.Json;

namespace PlordleApi.Services;

public class JsonReaderService : IFileReaderService
{

    private string _filename;

    public JsonReaderService(IOptions<FileReaderSettings> options)
    {
        _filename = options.Value.FilePath;
    }

    public List<Player> ParsePlayers()
    {

        using FileStream json = File.OpenRead(_filename);
        List<Player>? players = JsonSerializer.Deserialize<List<Player>>(json);

        if (players == null)
        {
           players = new List<Player>();
        }

        return players; 
    }
}
