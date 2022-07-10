import 'package:flutter/material.dart';
import 'package:paus_2/screens/daily_forecast.dart';
import 'package:paus_2/screens/hourly_forecast.dart';
import 'package:paus_2/screens/weather_card.dart';
import 'package:paus_2/screens/forecast_card.dart';
import 'package:paus_2/screens/uvi_card.dart';
import 'package:paus_2/screens/seach_bar.dart';
import 'package:paus_2/services/open_weather.dart';

class WeatherApp extends StatefulWidget {
  WeatherApp(this.city, this.x, this.y);

  String? city;
  double? x;
  double? y;
  @override
  State<WeatherApp> createState() => _WeatherAppState(city, x, y);
}

class _WeatherAppState extends State<WeatherApp> {
  _WeatherAppState(this.city, this.x, this.y);

  Map weather = {};
  double? uvi;

  String? city = 'Pune';
  double? x;
  double? y;

  late WeatherData weatherData =
      WeatherData(city ?? 'Pune', x ?? 18.5204, y ?? 73.8567);

  void showWeather() async {
    await weatherData.getWeather();
    // print(weatherData.weather);
    setState(() {
      weather = weatherData.weather ?? {};
      uvi = weather['current']['uvi'].toDouble();
      print(uvi);
    });
  }

  @override
  void initState() {
    super.initState();
    showWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(128, 0, 0, 0),
        elevation: 0,
        title: Text("Weather"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(),
              );
            },
          ),
          IconButton(
              onPressed: () {
                print(weatherData.weather);
              },
              icon: Icon(Icons.menu)),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xff60efff),
              Color(0xff0061ff),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: WeatherCard(city ?? 'Pune', weather),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: ForecastTitle(),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: HourlyForecast(weather),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: DailyForecast(weather),
                  ),
                ),
                Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 600),
                    child: Row(
                      children: <Widget>[
                        Flexible(
                          // flex: 4,
                          child: UVICard(uvi),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
