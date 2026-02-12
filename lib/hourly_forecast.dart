import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HourlyForecast extends StatelessWidget {
  final int temp;
  final String time;
  final String iconPath;

  const HourlyForecast({
    super.key,
    required this.temp,
    required this.time,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.3,
      child: Card(
        elevation: 1,
        color: Color(0xFF242323),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "$temp°",
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onPrimaryContainer,
                ),
              ),
              const SizedBox(height: 12),
              SvgPicture.asset(
                iconPath,
                width: 40,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 12),
              Text(time, style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}
