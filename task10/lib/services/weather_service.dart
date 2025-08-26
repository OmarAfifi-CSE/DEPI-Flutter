import 'package:dio/dio.dart';

class WeatherService {
  final String apiKey = 'c3a96b9081eb41a983b182019252308';
  final String baseUrl = "http://api.weatherapi.com/v1/forecast.json";
  final dio = Dio();

  Future<Map<String, dynamic>> getSevenDayForecast(String city) async {
    try {
      final response = await dio.get(
        baseUrl,
        queryParameters: {'key': apiKey, 'q': city, 'days': 7, 'aqi': 'no'},
      );
      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw Exception('Failed to load weather data for $city');
      }
    } catch (e) {
      throw Exception('Failed to connect to the weather service: $e');
    }
  }
}
