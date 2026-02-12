import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherInformation {
  final String apiKey = "846f271cc5124a14a4b161608260302";
  final String currentUrl = "https://api.weatherapi.com/v1/forecast.json";

  Future<Map<String, dynamic>> getForecastWeather(String city) async {
    final url =
        "https://api.weatherapi.com/v1/forecast.json"
        "?key=846f271cc5124a14a4b161608260302"
        "&q=$city"
        "&days=2"
        "&aqi=no"
        "&alerts=no";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    else {
      throw Exception("Failed to load weather data");
    }
  }
}