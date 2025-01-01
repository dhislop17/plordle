from dataclasses import dataclass
from pathlib import Path

import orjson

@dataclass 
class Player:
    name: str
    team: str
    shirt_number: int 
    age: int
    position_type: str 
    #position: str # TODO: Find a way to get this data
    country: str = None
    country_code: str = None
    continent: str = None

    
    @classmethod
    def load_into_player_map(cls, filepath: Path):
        data = orjson.loads(filepath.read_bytes())
        return {player_obj["name"]: cls(**player_obj) for player_obj in data}
    

