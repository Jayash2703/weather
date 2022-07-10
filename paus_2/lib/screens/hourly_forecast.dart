import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HourlyForecast extends StatelessWidget {
  List hourlyForecast = [];

  HourlyForecast(weather) {
    if (weather.isEmpty) {
      for (int i = 0; i < 16; i++) {
        this.hourlyForecast.add({});
      }
    } else {
      this.hourlyForecast = weather['hourly'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white70,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: hourlyForecast.map((e) => HourForecast(e)).toList(),
          ),
        ),
      ),
    );
  }
}

class HourForecast extends StatelessWidget {
  String weekday(int n) {
    switch (n) {
      case 1:
        {
          return 'Mon';
        }
      case 2:
        {
          return 'Tue';
        }
      case 3:
        {
          return 'Wed';
        }
      case 4:
        {
          return 'Thu';
        }
      case 5:
        {
          return 'Fri';
        }
      case 6:
        {
          return 'Sat';
        }
      case 7:
        {
          return 'Sun';
        }
      default:
        {
          return 'ERR';
        }
    }
  }

  HourForecast(this.hourForecast) {
    if (hourForecast.isEmpty) {
      time = '--';
      temp = '--';
      icon = '01d.svg';
    } else {
      DateTime dateTime =
          DateTime.fromMillisecondsSinceEpoch(hourForecast['dt'] * 1000);
      if (dateTime.hour == 0) {
        time = weekday(dateTime.weekday);
      } else {
        time = dateTime.hour.toString();
      }
      temp = (hourForecast['temp'] - 273).round().toString();
      icon = hourForecast['weather'][0]['icon'] + '.svg';
    }
  }

  Map hourForecast = {};
  String? time;
  String? temp;
  String? icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Text(
                time!,
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 50,
                height: 50,
                child: SvgPicture.asset(
                  'assets/icons/${icon ?? '00x.svg'}',
                  color: Colors.black,
                  fit: BoxFit.scaleDown,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "$temp\u{2103}",
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
