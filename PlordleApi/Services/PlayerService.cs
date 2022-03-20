using PlordleApi.Dtos;
using PlordleApi.Repositories;

namespace PlordleApi.Services;

public class PlayerService
{
    private readonly FileReaderService _readerService;
    private readonly IPlayerRepository _playerRepo;
    private Random _random;
    private Player? _todaysPlayer;

    public PlayerService(IPlayerRepository playerRepo, FileReaderService fileReaderService)
    {
        _readerService = fileReaderService;
        _playerRepo = playerRepo;
        var date = DateTime.UtcNow.Date;
        var seed = date.Year * 1000 + date.Month * 100 + date.DayOfYear;
        _random = new Random(seed);
    }

    public async void InitTodaysPlayer()
    {
        int count = await GetPlayerCount();
        if (count == 0)
        {
            var playersToSeed = _readerService.parsePlayers();
            count = await SeedPlayers(playersToSeed);
        }
        var todaysPlayerId = _random.Next(count);
        _todaysPlayer = await GetPlayerById(todaysPlayerId);
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
        Player guess = await GetPlayerByName(guessName);

        if (_todaysPlayer != null && guess != null)
        {
            return new PlayerComparisonDto
            {
                GuessName = _todaysPlayer.Name.Equals(guess.Name) ? _todaysPlayer.Name : guess.Name,
                SameTeam = _todaysPlayer.Team.Equals(guess.Team),
                SameType = _todaysPlayer.PositionType.Equals(guess.PositionType),
                SamePosition = _todaysPlayer.Position.Equals(guess.Position),
                SameCountry = _todaysPlayer.Country.Equals(guess.Country),
                AgeDiff = Math.Abs(_todaysPlayer.Age - guess.Age),
                ShirtNumberDiffernce = Math.Abs(_todaysPlayer.ShirtNumber - guess.ShirtNumber)
            };
        }
        else
        {
            return new PlayerComparisonDto();
        }

    }


}
