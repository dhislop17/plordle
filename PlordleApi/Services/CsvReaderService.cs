using CsvHelper;
using System.Globalization;

namespace PlordleApi.Services;

public class CsvReaderService : IFileReaderService
{
    private string _fileName;
    public CsvReaderService(IOptions<FileReaderSettings> options)
    {
        _fileName = options.Value.FilePath;
    }

    public List<Player> ParsePlayers()
    {
        var result = new List<Player>();
        using (var reader = new StreamReader(_fileName))
        using (var csvReader = new CsvReader(reader, CultureInfo.InvariantCulture))
        {
            csvReader.Read();
            csvReader.ReadHeader();
            result = csvReader.GetRecords<Player>().ToList();
        }


        return result;
    }

}
