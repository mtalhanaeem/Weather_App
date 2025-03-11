import 'package:flutter/material.dart';
import 'package:weather_app/weather_screen.dart';

void main() {
  runApp(const WeatherAppHome());
}

class WeatherAppHome extends StatelessWidget {
  const WeatherAppHome({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //debug banner will remove
      theme: ThemeData.dark(useMaterial3: true),
      home: const WeatherScreen(),
    );
  }
}

