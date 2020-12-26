import 'package:scoped_model/scoped_model.dart';
import 'package:weather_flutter_mvvm/data/WeatherRepoImpl.dart';
import 'package:weather_flutter_mvvm/model/Weather.dart';
import 'package:weather_flutter_mvvm/repostory/WeatherRepostory.dart';

class SearchViewModel extends Model {
  static SearchViewModel _instance;

  static SearchViewModel getInstance() {
    if (_instance == null) {
      _instance = SearchViewModel();
    }
    return _instance;
  }

  WeatherRepostory weatherRepo = WeatherRepoImpl.getInstance();
  Weather weatherSearched;
  bool isLoadingLocation = false;

  void getWeatherByLocation(String location) async {
    isLoadingLocation = true;
    notifyListeners();
    weatherSearched = await weatherRepo.getWeatherByLocation(location);
    isLoadingLocation = false;
    notifyListeners();
  }

  void favorite() async {
    weatherSearched.favorite = !weatherSearched.favorite;
    notifyListeners();
    await weatherRepo.saveWeather(weatherSearched);
  }

  static void destroyInstance() {
    _instance = null;
  }
}
