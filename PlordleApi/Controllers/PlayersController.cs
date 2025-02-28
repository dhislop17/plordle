using Microsoft.AspNetCore.Mvc;
using PlordleApi.Services;

namespace PlordleApi.Controllers;

[ApiController]
[Route("api/[controller]")]
public class PlayersController : ControllerBase
{
    private readonly ILogger<PlayersController> _logger;
    private readonly IPlayerService _playerService;

    public PlayersController(ILogger<PlayersController> logger, IPlayerService playerService)
    {
        _logger = logger;
        _playerService = playerService;
    }


    [HttpGet]
    public async Task<List<Player>> GetPlayers()
    {
        _logger.LogDebug($"{DateTime.Now} -  Received request to pull all players");
        var players = await _playerService.GetAllPlayers();
        _logger.LogDebug($"{DateTime.Now} - Prepared to return {players.Count} players");
        return players;
    }

    //For Testing API directly, not used by front end
    //[HttpGet("player/{id:int}")]
    //public async Task<ActionResult<Player>> GetPlayerById(int id)
    //{
    //    var player = await _playerService.GetPlayerById(id);
    //    return player;
    //}

    //For Testing API directly, not used by front end
    //[HttpGet("player/{name}")]
    //public async Task<ActionResult<Player>> GetPlayerByName(string name)
    //{
    //    var player = await _playerService.GetPlayerByName(name);
    //    return player;
    //}

    [HttpGet("random")]
    public async Task<ActionResult<Player>> GetRandomPlayer([FromQuery] List<String> excludedTeams)
    {
        _logger.LogDebug($"{DateTime.Now} -  Received request to get a random player");

        foreach (var team in excludedTeams)
        {
            _logger.LogDebug($"Excluded: {team}");
        }
        var player = await _playerService.GetRandomPlayer(excludedTeams);
        _logger.LogDebug($"{DateTime.Now} - Returning random player: {player}");
        return player;
    }

    [HttpGet("today")]
    public async Task<ActionResult<Player>> GetTodaysPlayer([FromQuery] List<String> excludedTeams)
    {
        _logger.LogDebug($"{DateTime.Now} -  Received request to get today's player");

        foreach (var team in excludedTeams)
        {
            _logger.LogDebug($"Excluded: {team}");
        }

        var player = await _playerService.GetTodaysPlayer(excludedTeams);
        _logger.LogDebug($"{DateTime.Now} - Returning daily player: {player}");
        return player;
    }

    //For Testing API directly, not used by front end
    [HttpGet("guess/{name}")]
    public async Task<ActionResult<PlayerComparisonDto>> ComparePlayers(string name, [FromQuery] List<String> excludedTeams)
    {
        foreach (var team in excludedTeams)
        {
            _logger.LogDebug($"Excluded: {team}");
        }
        return await _playerService.ComparePlayers(name, excludedTeams);
    }
}
