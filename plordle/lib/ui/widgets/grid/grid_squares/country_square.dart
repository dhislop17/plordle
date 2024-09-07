import 'package:country_coder/country_coder.dart';
import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/text_constants.dart';

class CountrySquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  final CountryCoder countryCoder;
  const CountrySquare(
      {super.key,
      required this.player,
      required this.guess,
      required this.countryCoder});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _colorCountrySquare(player, guess),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _createCountryColumn(),
            )),
      ),
    );
  }

  Color? _colorCountrySquare(Player player, Guess guess) {
    if (guess.sameCountry) {
      return Themes.guessGreen;
    } else if (guess.sameContinent) {
      return Themes.guessYellow;
    } else {
      return Themes.guessGrey;
    }
  }

  List<Widget> _createCountryColumn() {
    List<Widget> columnData;

    //Represent (ENG, SCT, and WLS as their flag emoji from unicode)
    if (TextConstants.albionNationsFlagMap.keys.contains(player.countryCode)) {
      var homeNationFlagData =
          TextConstants.albionNationsFlagMap[player.countryCode]!;

      columnData = [
        Text(player.country, maxLines: 1, overflow: TextOverflow.ellipsis),
        Text(String.fromCharCodes(homeNationFlagData))
      ];
    } else if (player.countryCode == "NIR") {
      //Shamrock for NIR
      var homeNationFlagData = TextConstants.northernIrelandCharSequence;

      columnData = [
        Text(
          textAlign: TextAlign.center,
          player.country,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(homeNationFlagData[0]),
          Text(homeNationFlagData[1])
        ])
      ];
    } else {
      //Everyone else gets their flag emoji
      columnData = [
        Text(player.country, maxLines: 1, overflow: TextOverflow.ellipsis),
        Text(countryCoder.emojiFlag(query: player.countryCode)!)
      ];
    }

    return columnData;
  }
}
