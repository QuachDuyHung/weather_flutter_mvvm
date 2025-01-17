import 'dart:convert';

import 'package:http/http.dart';
import 'package:weather_flutter_mvvm/model/Weather.dart';
import 'package:weather_flutter_mvvm/model/WeatherFromApi.dart';
import 'package:weather_flutter_mvvm/utils/NetworkUtil.dart'
    show APP_ID, APP_ID_PARAM, BASE_URL, QUERY_PARAM, WEATHER;

class WeatherApi {
  var client = Client();

  Future<Weather> findWeatherByLocation(String location) async {
    String url =
        "$BASE_URL/$WEATHER?$QUERY_PARAM=$location&$APP_ID_PARAM=$APP_ID";
    var response;
    try {
      response = await client.get(url);
    } on Exception {
      print("client exception");
      return null;
    }
    if (response.statusCode == 200) {
      WeatherFromApi weatherFromApi;
      try {
        weatherFromApi = WeatherFromApi.fromJson(json.decode(response.body));
      } on FormatException {
        print("json format exception");
      }
      return weatherFromApi?.toWeather();
    } else {
      print("request error: ${response.body}");
      return null;
    }
  }
}
