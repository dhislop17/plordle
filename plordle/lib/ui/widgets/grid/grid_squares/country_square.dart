import 'package:country_coder/country_coder.dart';
import 'package:flutter/material.dart';
import 'package:plordle/models/guess.dart';
import 'package:plordle/models/player.dart';
import 'package:plordle/ui/utils/app_theme.dart';
import 'package:plordle/ui/utils/constants.dart';

class CountrySquare extends StatelessWidget {
  final Player player;
  final Guess guess;
  final CountryCoder countryCoder;
  final double screenWidth;
  const CountrySquare(
      {super.key,
      required this.player,
      required this.guess,
      required this.countryCoder,
      required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: (screenWidth > Constants.bigScreenCutoffWidth)
            ? Constants.bigScreenGridAspectRatio
            : Constants.smallScreenGridAspectRatio,
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
    if (Constants.albionNationsFlagMap.keys.contains(player.countryCode)) {
      var albionNationFlagData =
          Constants.albionNationsFlagMap[player.countryCode]!;

      columnData = [
        Text(player.country),
        Text(String.fromCharCodes(albionNationFlagData))
      ];
    } else if (player.countryCode == "NIR") {
      //Shamrock for NIR
      var northernIrelandFlagData = Constants.northernIrelandCharSequence;

      columnData = [
        Text(
          textAlign: TextAlign.center,
          player.country,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(northernIrelandFlagData[0]),
          Text(northernIrelandFlagData[1])
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
