import 'package:http/http.dart';
import 'dart:convert';

class WeatherData {
  String location;
  double lat;
  double lon;
  String weatherUrl = 'https://api.openweathermap.org/data/2.5/onecall?';
  String apiKey = '23ab155d57ccd880d62fa63279b063eb';
  Map? weather;
  WeatherData(this.location, this.lat, this.lon);

  Future<void> getWeather() async {
    String url = weatherUrl +
        'lat=' +
        lat.toString() +
        '&lon=' +
        lon.toString() +
        '&appid=' +
        apiKey;
    print(url);
    Response response = await get(Uri.parse(url));

    this.weather = jsonDecode(response.body);
  }
}
