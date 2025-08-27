import 'package:task10/services/weather_service.dart';

void main() {
  WeatherService weatherService = WeatherService();
  weatherService.getWeatherByCity("kanazawa");
}
