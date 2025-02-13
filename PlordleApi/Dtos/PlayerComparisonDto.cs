namespace PlordleApi.Dtos;

public class PlayerComparisonDto
{
    public string GuessName { get; set; } = null!;
    public bool? SameTeam { get; set; }
    public bool? SameType { get; set; }
    //public bool? SamePosition { get; set; }
    public int? AgeDiff { get; set; }
    public int? ShirtNumberDifference { get; set; }
    public bool? SameCountry { get; set; }
    public bool? SameContinent { get; set; }
}
