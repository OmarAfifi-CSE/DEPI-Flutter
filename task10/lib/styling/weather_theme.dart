import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'app_assets.dart';

class WeatherTheme {
  final String backgroundImage;
  final IconData? weatherIcon;
  final Color primaryTextColor;
  final Color secondaryTextColor;
  final Color containerColor;
  final Color? accentColor;

  const WeatherTheme({
    required this.backgroundImage,
    required this.weatherIcon,
    required this.primaryTextColor,
    required this.secondaryTextColor,
    required this.containerColor,
    this.accentColor,
  });

  static final WeatherTheme sunnyTheme = WeatherTheme(
    backgroundImage: AppAssets.sunnyBackground,
    weatherIcon: FontAwesomeIcons.sun,
    primaryTextColor: const Color(0xffEFAA82),
    secondaryTextColor: Colors.black54,
    containerColor: const Color(0xffFAE2BD),
  );

  static final WeatherTheme cloudyTheme = WeatherTheme(
    backgroundImage: AppAssets.cloudyBackground,
    weatherIcon: FontAwesomeIcons.cloud,
    primaryTextColor: Color(0xffAED5E4),
    secondaryTextColor: Colors.white,
    containerColor: Color(0xff5A8BAB),
  );

  static final WeatherTheme rainyTheme = WeatherTheme(
    backgroundImage: AppAssets.rainyBackground,
    weatherIcon: FontAwesomeIcons.cloudRain,
    primaryTextColor: Color(0xffC9E8E0),
    secondaryTextColor: Colors.white70,
    containerColor: Color(0xff7FC3AE),
  );

  static final WeatherTheme snowyTheme = WeatherTheme(
    backgroundImage: AppAssets.snowyBackground,
    weatherIcon: FontAwesomeIcons.snowflake,
    primaryTextColor: Color(0xffE2E2E3),
    secondaryTextColor: Colors.white70,
    containerColor: Color(0xffA7ACC4),
  );

  static WeatherTheme getThemeForWeather(int? code) {
    switch (code) {
      case 1000:
        return sunnyTheme;
      case 1003:
      case 1006:
      case 1009:
        return cloudyTheme;
      case 1050:
      case 1053:
      case 1063:
      case 1180:
      case 1183:
      case 1189:
      case 1192:
      case 1195:
      case 1198:
      case 1201:
      case 1207:
      case 1204:
      case 1240:
      case 1243:
      case 1246:
      case 1273:
      case 1276:
        return rainyTheme;
      case 1066:
      case 1068:
      case 1069:
      case 1071:
      case 1072:
      case 1114:
      case 1117:
      case 1135:
      case 1147:
      case 1210:
      case 1213:
      case 1216:
      case 1219:
      case 1222:
      case 1225:
      case 1237:
      case 1249:
      case 1252:
      case 1255:
      case 1258:
      case 1261:
      case 1264:
      case 1279:
      case 1282:
        return snowyTheme;
      default:
        return sunnyTheme;
    }
  }
}
