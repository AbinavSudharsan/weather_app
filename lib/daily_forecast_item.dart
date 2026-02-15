import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DailyForecastItem extends StatelessWidget {
  final String day;
  final String iconPath;
  final int maxTemp;
  final int minTemp;

  const DailyForecastItem({
    super.key,
    required this.day,
    required this.iconPath,
    required this.maxTemp,
    required this.minTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 10,
        ),
        decoration: BoxDecoration(
          color: Color(0xFF171717),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Icon
            Flexible(
              flex: 2,
              child: SvgPicture.asset(
                iconPath,
                width: 30,
              ),
            ),

            // Day
            Flexible(
              flex: 3,
              child: SizedBox(
                child: Text(
                  day,
                  style: const TextStyle(fontSize: 20),
                ),
              ),
            ),

            // Temps
            Flexible(
              flex: 2,
              child: Text(
                "$maxTemp° / $minTemp°",
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}