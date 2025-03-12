import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/secrets.dart';

import 'additional_info_item.dart';
import 'hourly_forecast_item.dart';
import 'package:http/http.dart' as http;

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {

  //late double temp;
  //bool isLoading = false;

  @override
  void initState() {
    super.initState();
    try{

    }catch (e){

    }
    getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try{
      /*setState(() {
        isLoading = true;
      });*/
      String cityName = 'Dubai';
      final res = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName,ae&APPID=$openWeatherAPIKey'),
      );

      final data = jsonDecode(res.body);

      if (data['cod'] != '200'){
        throw data['message'];
      }

      return data;

      /*setState(() {
        temp = data['list'][0]['main']['temp'];
        isLoading = false;
      });*/

    }catch (e) {
      throw e.toString();
    }
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
      body: FutureBuilder(
        future: getCurrentWeather(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          /*if(snapshot.hasData){

          }*/

          final data = snapshot.data!;
          final currentTemp = data['list'][0]['main']['temp'];
          final currentSky = data['list'][0]['weather'][0]['main'];

          return Padding(
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
                      child: Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            Text(
                              '$currentTemp K',
                              style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold
                              ),
                            ),
                            SizedBox(height: 16),
                            Icon(
                                currentSky == 'Clouds' || currentSky == 'Rain'
                                    ? Icons.cloud
                                    : Icons.sunny,
                                size: 56,
                              ),
                              SizedBox(height: 16),
                            Text(
                              currentSky,
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
        );
        },
      ),
    );
  }
}

