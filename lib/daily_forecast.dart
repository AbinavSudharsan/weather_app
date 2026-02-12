import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class DailyForecast extends StatelessWidget {
  const DailyForecast({super.key});


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 500,
      child: Card(
        elevation: 0,
        color: Color(0xFF242323),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
        ),
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [

            ],
          ),
        ),
      ),
    );
  }
}
