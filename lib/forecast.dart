import 'dart:convert';
import 'package:http/http.dart' as http;

class ForeCast {
  final String apiKey = "846f271cc5124a14a4b161608260302";
  final String currentUrl = "https://api.weatherapi.com/v1/forecast.json";
  final int days = 5;

  Future<Map<String, dynamic>> getForecast(String city) async{
    final url = Uri.parse(
        "$currentUrl?key=$apiKey&q=$city&aqi=yes"
    );

    final response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);
      return jsonDecode(response.body);
    }
    else {
      throw Exception("Failed to load weather data");
    }
  }
}