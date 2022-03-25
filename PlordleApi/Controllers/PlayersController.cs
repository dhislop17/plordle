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
        var players = await _playerService.GetAllPlayers();
        return players;
    }

    //[HttpGet("player/{id:int}")]
    //public async Task<ActionResult<Player>> GetPlayerById(int id)
    //{
    //    var player = await _playerService.GetPlayerById(id);
    //    return player;
    //}

    //[HttpGet("player/{name}")]
    //public async Task<ActionResult<Player>> GetPlayerByName(string name)
    //{
    //    var player = await _playerService.GetPlayerByName(name);
    //    return player;
    //}

    [HttpGet("random")]
    public async Task<ActionResult<Player>> GetRandomPlayer()
    {
        var player = await _playerService.GetRandomPlayer();
        return player;
    }

    [HttpGet("today")]
    public async Task<ActionResult<Player>> GetTodaysPlayer()
    {
        var player = await _playerService.GetTodaysPlayer();
        return player;
    }

    [HttpGet("guess/{name}")]
    public async Task<ActionResult<PlayerComparisonDto>> ComparePlayers(string name)
    {
        return await _playerService.ComparePlayers(name);
    }
}
