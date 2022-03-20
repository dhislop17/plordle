namespace PlordleApi.Configuration;

public class PlordleDatabaseSettings
{
    public string ConnectionString { get; set; } = null!;
    public string DatabaseName { get; set; } = null!;
    public string PlordleCollectionName { get; set; } = null!;
}
