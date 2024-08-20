import 'package:flutter/material.dart';

class Themes {
  //Premier League Colors
  static const Color premPurple = Color(0xFF38003C);
  static const Color premGreen = Color(0xFF00FF85);

  //Game colors
  static const Color guessGreen = Color(0xFF21BC5F);
  static const Color guessYellow = Color(0xFFFE9F10);
  static const Color guessGrey = Color(0xFF9E9E9E);

  static const Map<String, List<Color>> teamThemes = {
    'Premier League': [premPurple, premGreen],
    'Arsenal FC': [
      Color(0xFFEF0107),
      Colors.white,
      Color(0xFF063672),
    ],
    'Aston Villa': [Color(0xFF95BFE5), Color(0xFF670E36)],
    'AFC Bournemouth': [Color(0xFFB50E12), Colors.black], //stripes
    'Brentford FC': [Color(0xFFD20000), Colors.white, Colors.black], //stripes
    'Brighton & Hove Albion': [
      Color(0xFF005DAA),
      Colors.white,
      Color(0xFFFFCD00)
    ], //striped
    'Chelsea FC': [Color(0xFF0000DD), Colors.white, Color(0xFFDBA111)],
    'Crystal Palace': [Color(0xFF1B458F), Color(0xFFC4122E)], //Stripped
    'Everton FC': [Color(0xFF003399), Colors.white],
    'Fulham FC': [Colors.black, Colors.white, Color(0xFFCC0000)],
    'Ipswich Town': [Color(0xFF3A64A3), Colors.white],
    'Leicester City': [Color(0xFF003090), Color(0xFFFDBE11)],
    'Liverpool FC': [Color(0xFFC8102E), Colors.white, Color(0xFF008875)],
    'Manchester City': [Color(0xFF6CABDD), Color(0xFF1C2C5B)],
    'Manchester United': [Color(0xFFDA291C), Colors.white, Colors.black],
    'Newcastle United': [
      Colors.black,
      Colors.white,
      Color(0xFF41B6E6)
    ], //Stripped
    'Nottingham Forest': [Color(0xFFDD0000), Colors.white],
    'Southampton FC': [
      Color(0xFFD71920),
      Colors.white,
      Colors.black
    ], //stripped
    'Tottenham Hotspur': [
      Color(0xFF132257),
      Colors.white,
    ],
    'West Ham United': [Color(0xFF7A263A), Color(0xFF1BB1E7)],
    'Wolverhampton Wanderers': [Color(0xFFFDB913), Colors.black],
  };
}
