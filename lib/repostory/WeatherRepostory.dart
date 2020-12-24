import 'package:weather_flutter_mvvm/model/Weather.dart';

abstract class WeatherRepostory {
  Future<Weather> getWeatherByLocation(String location);

  Future<List<Weather>> getWeathers();

  Future<void> removeWeather(Weather weather);

  Future<void> saveWeather(Weather weather);

  Future<List<Weather>> getWeathersFavorite();
}
