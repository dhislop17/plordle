namespace PlordleApi.Configuration;

public class PlordleDatabaseSettings
{
    public string ConnectionString { get; set; } = null!;
    public string DatabaseName { get; set; } = null!;
    public string PlordleCollectionName { get; set; } = null!;
    public string Host { get; set; } = null!;
    public int Port { get; set; }
    public string User { get; set; } = null!;
    public string Password { get; set; } = null!;
}
