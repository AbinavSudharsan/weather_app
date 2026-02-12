import 'package:flutter/material.dart';
import 'package:weather_app/home_screen.dart';
import 'app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: AppTheme.lightScheme, useMaterial3: true),
      darkTheme: ThemeData(
        colorScheme: AppTheme.darkScheme,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.dark,
      home: HomeScreen(),
    );
  }
}