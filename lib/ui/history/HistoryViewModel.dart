import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter_mvvm/data/WeatherRepoImpl.dart';
import 'package:weather_flutter_mvvm/model/Weather.dart';
import 'package:weather_flutter_mvvm/repostory/WeatherRepostory.dart';

class HistoryViewModel extends Model {
  static HistoryViewModel _instance;

  static HistoryViewModel getInstance() {
    if (_instance == null) {
      _instance = HistoryViewModel();
    }
    return _instance;
  }

  WeatherRepostory weatherRepo = WeatherRepoImpl();
  List<Weather> weathers = [];

  HistoryViewModel() {
    updateWeather();
  }

  void updateWeather() async {
    weathers = await weatherRepo.getWeathers();
    notifyListeners();
  }

  void updateFavorite(Weather weather) async {
    weather.favorite = !weather.favorite;
    notifyListeners();
    await weatherRepo.saveWeather(weather);
  }

  void deleteWeather(Weather weather) async {
    await weatherRepo.removeWeather(weather);
    updateWeather();
  }

  static void destroyInstance() {
    _instance = null;
  }
}
