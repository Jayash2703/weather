import 'package:flutter/material.dart';
import 'package:paus_2/screens/forecast_card.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';

class DailyForecast extends StatelessWidget {
  DailyForecast(this.weather);

  Map weather = {};

  List<Widget> getDailyForecasts() {
    List<Widget> dailyForecasts = [];
    List<int> maxList = [];
    List<int> minList = [];
    int maxmax = 29;
    int minmin = 23;
    if (weather.isEmpty) {
      for (int i = 0; i < 8; i++) {
        dailyForecasts.add(DaysForecast({}, 29, 23));
        dailyForecasts.add(Divider());
      }
      dailyForecasts.removeLast();
    } else {
      for (int i = 0; i < 8; i++) {
        maxList.add(weather['daily'][i]['temp']['max'].round() - 273);
        minList.add(weather['daily'][i]['temp']['min'].round() - 273);
      }
      maxmax = maxList.reduce(max);
      minmin = minList.reduce(min);
      for (int i = 0; i < 8; i++) {
        dailyForecasts.add(DaysForecast(weather['daily'][i], maxmax, minmin));
        dailyForecasts.add(Divider());
      }
      dailyForecasts.removeLast();
    }
    return dailyForecasts;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: getDailyForecasts(),
        ),
      ),
    );
  }
}

class DaysForecast extends StatelessWidget {
  DaysForecast(this.forecast, maxmax, minmin) {
    if (forecast.isEmpty) {
      day = '-----';
      min = 23;
      max = 29;
      icon = '00x.svg';
    } else {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(forecast['dt'] * 1000);
      day = dateTime.day.toString() + '-' + dateTime.month.toString();
      min = (forecast['temp']['min'] - 273).round();
      max = (forecast['temp']['max'] - 273).round();
      rangeMax = maxmax;
      rangeMin = minmin;
      icon = forecast['weather'][0]['icon'] + '.svg';
    }
  }

  Map forecast = {};

  String day = 'Today';
  int min = 23;
  int max = 29;
  int rangeMin = 22;
  int rangeMax = 30;
  String icon = '00x.svg';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            day,
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Container(
            width: 50,
            height: 40,
            child: SvgPicture.asset(
              'assets/icons/${icon}',
              color: Colors.black,
              fit: BoxFit.scaleDown,
            ),
          ),
          Row(
            children: [
              Text(
                '$min',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(4),
                    child: Container(
                      width: 300,
                      height: 8,
                      color: Colors.black26,
                    ),
                  ),
                  Row(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 8,
                        width: 300 * (min - rangeMin) / (rangeMax - rangeMin),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Container(
                          height: 8,
                          width: 300 * (max - min) / (rangeMax - rangeMin),
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Color(0xff45CAFF),
                              Color(0xffFFF95B),
                              Color(0xffFF930F),
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              // Stack(
              //   alignment: AlignmentDirectional.bottomStart,
              //   children: [
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(10),
              //       child: Container(
              //         width: 300,
              //         height: 8,
              //         color: Color.fromARGB(255, 222, 222, 222),
              //       ),
              //     ),
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(10),
              //       child: Container(
              //         width: 300*(max-rangeMin)/(rangeMax-rangeMin),
              //         height: 8,
              //         decoration: BoxDecoration(
              //           gradient: LinearGradient(
              //             colors: [
              //               Color(0xff45CAFF),
              //               Color(0xffFFF95B),
              //               Color(0xffFF930F),
              //             ]
              //           ),
              //         ),
              //       ),
              //     ),
              //     ClipRRect(
              //       borderRadius: BorderRadius.circular(10),
              //       child: Container(
              //         width: 300*(min-rangeMin)/(rangeMax-rangeMin),
              //         height: 8,
              //         color: Color.fromARGB(255, 222, 222, 222),
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(
                width: 10,
              ),
              Text(
                '$max',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
