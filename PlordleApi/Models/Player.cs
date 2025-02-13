using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using System.Text.Json.Serialization;

namespace PlordleApi.Models;

[BsonIgnoreExtraElements]
public class Player
{
    //[BsonElement("playerId")]
    //[JsonIgnore]
    //public int PlayerId { get; set; }

    [BsonElement("name")]
    [JsonPropertyName("name")]
    public string Name { get; set; } = null!;

    [BsonElement("team")]
    [JsonPropertyName("team")]
    public string Team { get; set; } = null!;

    //[BsonElement("position")]
    //[JsonIgnore]
    //public string Position { get; set; }  = null!;

    [BsonElement("positionType")]
    [JsonPropertyName("position_type")]
    public string PositionType { get; set; } = null!;

    [BsonElement("shirtNumber")]
    [JsonPropertyName("shirt_number")]
    public int ShirtNumber { get; set; }

    [BsonElement("age")]
    [JsonPropertyName("age")]
    public int Age { get; set; }

    [BsonElement("country")]
    [JsonPropertyName("country")]
    public string Country { get; set; } = null!;

    [BsonElement("countryCode")]
    [JsonPropertyName("country_code")]
    public string CountryCode { get; set; } = null!;

    [BsonElement("continent")]
    [JsonPropertyName("continent")]
    public string Continent { get; set; } = null!;

    public override string ToString()
    {
        return $"#{ShirtNumber} - {PositionType} - {Name} - {Team}";
    }

}
