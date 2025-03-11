import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/secrets.dart';

import 'additional_info_item.dart';
import 'hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  Future getCurrentWeather() async {
    String cityName = "Dubai";
    final res = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName,ae&APPID=$openWeatherAPIKey'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      ///AppBar
      appBar: AppBar(
        title: const Text(
          "Weather App",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          //this is click detector
          /*GestureDetector(
            onTap: () {
              debugPrint("Refresh");
            },
            child: const Icon(Icons.refresh),
          ),*/
          //this is click detector with an effect
          /*InkWell(
            onTap: () {
              debugPrint("Refresh");
            },
            child: const Icon(Icons.refresh),
          ),*/
          //but we can use IconButton
          IconButton(onPressed: () {}, icon: const Icon(Icons.refresh))
        ],
      ),

      ///Body
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //main card
            SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 10,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                //Three items in the card: Temp, Icon, Weather Condition
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            "300K",
                            style: TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                          SizedBox(height: 16),
                          Icon(
                            Icons.cloud,
                            size: 56,
                          ),
                          SizedBox(height: 16),
                          Text(
                            "Rain",
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            //weather forecast cards
            const SizedBox(height: 20),
            const Text(
              "Weather Forecast",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  HourlyForecastItem(
                    time: "00:00",
                    icon: Icons.cloud,
                    temperature: "301.22",
                  ),
                  HourlyForecastItem(
                    time: "03:00",
                    icon: Icons.sunny,
                    temperature: "301.22",
                  ),
                  HourlyForecastItem(
                    time: "06:00",
                    icon: Icons.sunny,
                    temperature: "301.22",
                  ),
                  HourlyForecastItem(
                    time: "09:00",
                    icon: Icons.cloud,
                    temperature: "301.22",
                  ),
                  HourlyForecastItem(
                    time: "12:00",
                    icon: Icons.sunny,
                    temperature: "301.22",
                  ),
                ],
              ),
            ),
            //additional information
            const SizedBox(height: 20),
            const Text(
              "Additional Information",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                AdditionalInfoItem(
                  icon: Icons.water_drop,
                  label: "Humidity",
                  value: "91",
                ),
                AdditionalInfoItem(
                  icon: Icons.air,
                  label: "Wind Speed",
                  value: "7.5",
                ),
                AdditionalInfoItem(
                  icon: Icons.beach_access,
                  label: "Pressure",
                  value: "1000",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

