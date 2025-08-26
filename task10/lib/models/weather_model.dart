class HourlyForecast {
  final String time;
  final String iconUrl;
  final double temp;

  HourlyForecast({
    required this.time,
    required this.iconUrl,
    required this.temp,
  });

  factory HourlyForecast.fromJson(Map<String, dynamic> json) {
    return HourlyForecast(
      time: (json['time'] as String).substring(11),
      iconUrl: json['condition']['icon'],
      temp: (json['temp_c'] as num).toDouble(),
    );
  }
}

class DailyForecast {
  final String day;
  final String iconUrl;
  final String condition;
  final double maxTemp;
  final double minTemp;

  DailyForecast({
    required this.day,
    required this.iconUrl,
    required this.condition,
    required this.maxTemp,
    required this.minTemp,
  });

  factory DailyForecast.fromJson(Map<String, dynamic> json) {
    return DailyForecast(
      day: json['date'],
      iconUrl: json['day']['condition']['icon'],
      condition: json['day']['condition']['text'],
      maxTemp: (json['day']['maxtemp_c'] as num).toDouble(),
      minTemp: (json['day']['mintemp_c'] as num).toDouble(),
    );
  }
}

class Weather {
  final String lastUpdated;
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final String condition;
  final String iconCode;
  final double windSpeed;
  final double humidity;
  final double pressure;
  final List<HourlyForecast> hourlyForecasts;
  final List<DailyForecast> dailyForecasts;

  Weather({
    required this.lastUpdated,
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.condition,
    required this.iconCode,
    required this.windSpeed,
    required this.humidity,
    required this.pressure,
    required this.hourlyForecasts,
    required this.dailyForecasts,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    // Daily forecasts
    final forecastDaysJson = json['forecast']['forecastday'] as List;
    final List<DailyForecast> daily = forecastDaysJson
        .map((dayJson) => DailyForecast.fromJson(dayJson))
        .toList();

    // Hourly forecasts
    final todayHourlyJson = forecastDaysJson[0]['hour'] as List;
    final List<HourlyForecast> hourly = todayHourlyJson
        .map((hourJson) => HourlyForecast.fromJson(hourJson))
        .toList();

    return Weather(
      lastUpdated: json['current']['last_updated'],
      cityName: json['location']['name'],
      country: json['location']['country'],
      temperature: (json['current']['temp_c'] as num).toDouble(),
      feelsLike: (json['current']['feelslike_c'] as num).toDouble(),
      condition: json['current']['condition']['text'],
      iconCode: json['current']['condition']['icon'].toString(),
      windSpeed: (json['current']['wind_kph'] as num).toDouble(),
      humidity: (json['current']['humidity'] as num).toDouble(),
      pressure: (json['current']['pressure_mb'] as num).toDouble(),
      dailyForecasts: daily,
      hourlyForecasts: hourly,
    );
  }
}
