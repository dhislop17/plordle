using PlordleApi.Repositories;

namespace PlordleApi.Services;

public class PlayerService : IPlayerService
{
    private readonly IFileReaderService _readerService;
    private readonly IPlayerRepository _playerRepo;

    public PlayerService(IPlayerRepository playerRepo, IFileReaderService fileReaderService)
    {
        _readerService = fileReaderService;
        _playerRepo = playerRepo;
    }

    public async Task SeedDatabase()
    {
         int count = await GetPlayerCount();
        if (count == 0)
        {
            var playersToSeed = _readerService.ParsePlayers();
            await SeedPlayers(playersToSeed);
        }
    }

    public async Task<Player> GetTodaysPlayer()
    {
        var date = DateTime.UtcNow.Date;
        var seed = date.Year * 1000 + date.Month * 100 + date.DayOfYear;
        
        var random = new Random(seed);
        var count = await GetPlayerCount();
        var todaysId = random.Next(count);

        return await GetPlayerById(todaysId);
    }

    public async Task<Player> GetRandomPlayer()
    {
        var random = new Random();
        var count = await GetPlayerCount();
        var id = random.Next(count);

        return await GetPlayerById(id);
    }

    private async Task<int> SeedPlayers(List<Player> playersToSeed)
    {
        await _playerRepo.AddPlayersAsync(playersToSeed);
        return await GetPlayerCount();
    }

    private async Task<int> GetPlayerCount()
    {
        return await _playerRepo.GetPlayerCountAsync();
    }

    public async Task<Player> GetPlayerById(int playerId)
    {
        var builder = Builders<Player>.Filter;
        var filter = builder.Eq(player => player.PlayerId, playerId);
        var player = await _playerRepo.GetPlayerAsync(filter);
        
        return player;      
    }

    public async Task<Player> GetPlayerByName(string name)
    {
        var builder = Builders<Player>.Filter;
        var filter = builder.Eq(player => player.Name, name);

        return await _playerRepo.GetPlayerAsync(filter);
    }
        
    public async Task<List<Player>> GetAllPlayers()
    {
        var players = await _playerRepo.GetAllPlayersAsync();
        return players;
    }   
    
    public async Task<PlayerComparisonDto> ComparePlayers(string guessName)
    {
        Player todaysPlayer = await GetTodaysPlayer();
        Player guess = await GetPlayerByName(guessName);

        if (todaysPlayer != null && guess != null)
        {
            return new PlayerComparisonDto
            {
                GuessName = todaysPlayer.Name.Equals(guess.Name) ? todaysPlayer.Name : guess.Name,
                SameTeam = todaysPlayer.Team.Equals(guess.Team),
                SameType = todaysPlayer.PositionType.Equals(guess.PositionType),
                SamePosition = todaysPlayer.Position.Equals(guess.Position),
                SameCountry = todaysPlayer.Country.Equals(guess.Country),
                AgeDiff = Math.Abs(todaysPlayer.Age - guess.Age),
                ShirtNumberDiffernce = Math.Abs(todaysPlayer.ShirtNumber - guess.ShirtNumber)
            };
        }
        else
        {
            return new PlayerComparisonDto();
        }

    }


}
