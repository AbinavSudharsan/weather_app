import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/aqi_card.dart';
import 'package:weather_app/daily_forecast.dart';
import 'package:weather_app/hourly_forecast.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'current_weather.dart';
import 'package:weather_app/utils/get_weather_icon_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final WeatherInformation weatherInformation = WeatherInformation();
  final TextEditingController searchController = TextEditingController();

  Map<String, dynamic>? weatherData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather("vellore"); // default city
  }

  Future<void> fetchWeather(String city) async {
    setState(() {
      isLoading = true;
    });

    try {
      final data = await weatherInformation.getForecastWeather(city);

      setState(() {
        weatherData = data;
        isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
    }
  }

  List<dynamic> getNext24Hours(Map<String, dynamic> weatherData) {
    final now = DateTime.now();
    final List<dynamic> result = [];

    final forecastDays = weatherData["forecast"]["forecastday"];

    for (var day in forecastDays) {
      for (var hour in day["hour"]) {
        final hourTime = DateTime.parse(hour["time"]);

        if (hourTime.isAfter(now) && result.length < 24) {
          result.add(hour);
        }
      }
    }

    return result;
  }

  String formatHour(String time) {
    final dateTime = DateTime.parse(time);
    return DateFormat('h a').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFF0A0A0A),
      appBar: AppBar(
        toolbarHeight: 80,
        title: SearchBar(
          controller: searchController,
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16),
          ),
          elevation: const WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          ),
          leading: const Icon(Icons.search_rounded),
          backgroundColor: WidgetStatePropertyAll(Color(0xFF242323)),
          hintText: "Search for a location",
          hintStyle: WidgetStatePropertyAll(
            TextStyle(color: Theme.of(context).colorScheme.onPrimaryContainer),
          ),
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              FocusScope.of(context).unfocus();
              fetchWeather(value.trim());
              searchController.clear();
            }
          },
        ),
        backgroundColor: Colors.transparent,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Builder(
              builder: (_) {
                final temp = weatherData!["current"]["temp_c"].toInt();
                final tempFeel = weatherData!["current"]["feelslike_c"].toInt();
                final aqiIndex = weatherData!["current"]["air_quality"]["us-epa-index"];

                final hourlyForecast = getNext24Hours(weatherData!);

                return SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        // Top Section
                        SizedBox(
                          height: screenHeight * 0.4,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "${weatherData!["location"]["name"]}, ${weatherData!["location"]["country"]}",
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.05,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              Text(
                                weatherData!["current"]["condition"]["text"],
                                style: TextStyle(fontSize: screenWidth * 0.05),
                              ),
                              const SizedBox(height: 16),
                              SvgPicture.asset(
                                getWeatherIcon(
                                  weatherData!["current"]["condition"]["text"],
                                  weatherData!["current"]["is_day"],
                                ),
                                width: screenWidth * 0.3,
                              ),
                              const SizedBox(height: 20),
                              Text(
                                "$temp°",
                                style: TextStyle(
                                  fontSize: screenWidth * 0.1,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Feels like $tempFeel°",
                                style: TextStyle(fontSize: screenWidth * 0.05),
                              ),
                            ],
                          ),
                        ),

                        // Hourly Forecast Title
                        const SizedBox(height: 8),
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.access_time),
                                SizedBox(width: 8),
                                Text("Hourly Forecast"),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),

                        // Hourly Forecast List
                        SizedBox(
                          height: 180,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: hourlyForecast.length,
                            itemBuilder: (context, index) {
                              final hour = hourlyForecast[index];

                              return HourlyForecast(
                                temp: hour["temp_c"].round(),
                                time: formatHour(hour["time"]),
                                iconPath: getWeatherIcon(
                                  hour["condition"]["text"],
                                  hour["is_day"],
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 16),

                        // Daily Forecast Title
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                Icon(Icons.calendar_month),
                                SizedBox(width: 8),
                                Text("Daily Forecast"),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 12),

                        DailyForecast(
                          forecastDays: weatherData!["forecast"]["forecastday"],
                        ),

                        const SizedBox(height: 16,),

                        AqiCard(value: aqiIndex * 50, maxAqi: 500,)

                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
