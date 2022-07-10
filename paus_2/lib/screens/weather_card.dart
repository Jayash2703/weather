import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WeatherCard extends StatelessWidget {
  WeatherCard(this.location, this.weather) {
    if (weather.isEmpty) {
      time = '------';
      temperature = '--';
      weatherMain = 'Conjuring Weather...';
      maxTemp = '--';
      minTemp = '--';
      icon = '00x.svg';
      image = '00x.jpg';
    } else {
      time =
          DateTime.fromMillisecondsSinceEpoch(weather['current']['dt'] * 1000)
              .toString()
              .replaceAll('.000', '');
      temperature = (weather['current']['temp'] - 273).round().toString();
      weatherMain = weather['current']['weather'][0]['main'];
      maxTemp = (weather['daily'][0]['temp']['max'] - 273).round().toString();
      minTemp = (weather['daily'][0]['temp']['min'] - 273).round().toString();
      icon = weather['current']['weather'][0]['icon'] + '.svg';
      image = weather['current']['weather'][0]['icon'] + '.jpg';
    }
  }

  final String location;
  Map weather = {};

  String? time;
  String? temperature;
  String? weatherMain;
  String? maxTemp;
  String? minTemp;
  String? icon;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/${image ?? '00x.jpg'}',
              width: double.infinity,
              // height: double.infinity,
              fit: BoxFit.cover,
            ),
            Column(
              children: <Widget>[
                Container(
                  color: Colors.black38,
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        location,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "As of $time",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '$temperature\u{2103}',
                            style: TextStyle(
                                fontSize: 72,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black38,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            weatherMain!,
                            style: TextStyle(
                                fontSize: 28,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black38,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ]),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Max $maxTemp\u{2103} \u{2022} Min $minTemp\u{2103}',
                            style: TextStyle(
                                fontSize: 22,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    blurRadius: 10.0,
                                    color: Colors.black38,
                                    offset: Offset(2.0, 2.0),
                                  ),
                                ]),
                          ),
                        ],
                      ),
                      Container(
                        width: 200,
                        height: 200,
                        child: SvgPicture.asset(
                          'assets/icons/${icon ?? '00x.svg'}',
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
