using PlordleApi.Repositories;

namespace PlordleApi.Services;

public class PlayerService : IPlayerService
{
    private readonly IFileReaderService _readerService;
    private readonly IPlayerRepository _playerRepo;
    private readonly ILogger<PlayerService> _logger;

    public PlayerService(ILogger<PlayerService> logger, IPlayerRepository playerRepo, IFileReaderService fileReaderService)
    {
        _readerService = fileReaderService;
        _playerRepo = playerRepo;
        _logger = logger;
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

    private async Task<int> SeedPlayers(List<Player> playersToSeed)
    {
        await _playerRepo.AddPlayersAsync(playersToSeed);
        return await GetPlayerCount();
    }

    public async Task<List<Player>> GetAllPlayers()
    {
        var players = await _playerRepo.GetAllPlayersAsync();
        _logger.LogDebug($"Retrieved: {players.Count} players");
        return players;
    }

    public async Task<Player> GetTodaysPlayer(List<String> excludedTeams)
    {
        var date = DateTime.Now.Date;
        var seed = date.Year * 1000 + date.Month * 100 + date.DayOfYear;
        
        var random = new Random(seed);
        Player player;

        if (excludedTeams.Any())
        {
            var filterBuilder = Builders<Player>.Filter;
            var teamFilter = filterBuilder.Nin(player => player.Team, excludedTeams);

            //Filter out players from excluded teams
            List<Player> players = await _playerRepo.GetPlayersUsingFilter(teamFilter);
            _logger.LogDebug($"Retrieved: {players.Count} players");
            player = players.ElementAt(random.Next(players.Count));

        }
        else
        {
            var count = await GetPlayerCount();
            var todaysId = random.Next(count);
            player = await GetPlayerById(todaysId);
        }
        return player;
    }

    public async Task<Player> GetRandomPlayer(List<String> excludedTeams)
    {
        var random = new Random();
        Player player;
        if (excludedTeams.Any())
        {
            //Filter out players from excluded teams
            var filterBuilder = Builders<Player>.Filter;
            var teamFilter = filterBuilder.Nin(player => player.Team, excludedTeams);

            List<Player> players = await _playerRepo.GetPlayersUsingFilter(teamFilter);

            _logger.LogDebug($"Retrieved: {players.Count} players");
            player = players.ElementAt(random.Next(players.Count));
        }
        else
        {
            var count = await GetPlayerCount();
            var id = random.Next(count);
            player = await GetPlayerById(id);
        }

        return player;
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
    
    //For Testing API directly, not used by front end
    public async Task<PlayerComparisonDto> ComparePlayers(string guessName, List<string> excludedTeams)
    {
        Player todaysPlayer = await GetTodaysPlayer(excludedTeams);
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
                SameContinent = todaysPlayer.Continent.Equals(guess.Continent),
                AgeDiff = Math.Abs(todaysPlayer.Age - guess.Age),
                ShirtNumberDifference = Math.Abs(todaysPlayer.ShirtNumber - guess.ShirtNumber)
            };
        }
        else
        {
            return new PlayerComparisonDto();
        }

    }


}
