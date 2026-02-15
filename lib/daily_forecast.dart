import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:weather_app/daily_forecast_item.dart';
import 'package:weather_app/utils/get_weather_icon_helper.dart';
import 'package:intl/intl.dart';

class DailyForecast extends StatelessWidget {
  final List<dynamic> forecastDays;

  const DailyForecast({
    super.key,
    required this.forecastDays,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: const Color(0xFF242323),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: forecastDays.take(5).map((day) {
            final date = DateTime.parse(day["date"]);
            final weekday = DateFormat('EEE').format(date);

            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: DailyForecastItem(
                day: weekday,
                iconPath: getWeatherIcon(
                  day["day"]["condition"]["text"],
                  1,
                ),
                maxTemp: day["day"]["maxtemp_c"].round(),
                minTemp: day["day"]["mintemp_c"].round(),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
