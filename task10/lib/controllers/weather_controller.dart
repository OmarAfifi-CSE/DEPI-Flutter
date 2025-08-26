import 'package:flutter/cupertino.dart';
import 'package:task10/services/weather_service.dart';

import '../models/weather_model.dart';

class WeatherController extends ChangeNotifier {
  WeatherService weatherService = WeatherService();
  Weather? weather;
  late String city;

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void updateCity(String newCity) {
    city = newCity;
    fetchWeather();
  }

  Future<void> fetchWeather() async {
    _isLoading = true;
    notifyListeners();
    try {
      final weatherData = await weatherService.getSevenDayForecast(city);
      weather = Weather.fromJson(weatherData);
      notifyListeners();
    } catch (e) {
      print("Error fetching weather data: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
