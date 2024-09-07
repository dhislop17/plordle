using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;

namespace PlordleApi.Models;

[BsonIgnoreExtraElements]
public class Player
{
    [BsonElement("playerId")]
    public int PlayerId { get; set; }
    [BsonElement("name")]
    public string Name { get; set; } = null!;
    [BsonElement("team")]
    public string Team { get; set; } = null!;
    [BsonElement("position")]
    public string Position { get; set; }  = null!;
    [BsonElement("positionType")]
    public string PositionType { get; set; } = null!;
    [BsonElement("shirtNumber")]
    public int ShirtNumber { get; set; }
    [BsonElement("age")]
    public int Age { get; set; }
    [BsonElement("country")]
    public string Country { get; set; } = null!;
    [BsonElement("countryCode")]
    public string CountryCode { get; set; } = null!;
    [BsonElement("continent")]
    public string Continent { get; set; } = null!;

}
