import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/utils/const.dart';

enum APIState { Loading, NoData, HasData, Error, NoQuery }

class RestaurantProvider with ChangeNotifier {
  final _apiService = ApiService();

  RestaurantProvider() {
    fetchRestaurants('list');
  }

  late RestaurantsResult _restaurantsResult;
  late DetailResult _restaurantResult;
  late APIState _state;
  late String _message;

  String get message => _message;
  RestaurantsResult get result => _restaurantsResult;
  DetailResult get restaurantDetail => _restaurantResult;
  APIState get state => _state;

  // Fetch for List and Search
  Future<dynamic> fetchRestaurants(String request) async {
    try {
      _state = APIState.Loading;
      notifyListeners();

      late RestaurantsResult response;
      if (request == 'list') {
        response = await _apiService.getRestaurants();
      } else {
        response = await _apiService.getSearchRestaurants(_searchQuery);
      }

      if (response.restaurants.isEmpty) {
        _state = APIState.NoData;
        notifyListeners();
        return _message = EMPTY_RESPONSE;
      } else {
        _state = APIState.HasData;
        notifyListeners();
        return _restaurantsResult = response;
      }
    } catch (e) {
      _state = APIState.Error;
      notifyListeners();
      return _message = ERROR_RESPONSE;
    }
  }

  // Fetch for Detail
  Future<dynamic> fetchRestaurant(String id) async {
    try {
      _state = APIState.Loading;
      notifyListeners();

      final response = await _apiService.getRestaurant(id);

      if (response.message == 'restaurant not found') {
        _state = APIState.NoData;
        notifyListeners();
        return _message = EMPTY_RESPONSE;
      } else {
        _state = APIState.HasData;
        notifyListeners();
        return _restaurantResult = response;
      }
    } catch (e) {
      _state = APIState.Error;
      notifyListeners();
      return _message = ERROR_RESPONSE;
    }
  }

  // Search Feature
  String _searchQuery = '';
  String get searchQuery => _searchQuery;
  void setQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  // Detail Page
  int _currentIndex = 0;
  void setIndex(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  List<String> _detailTitle = [
    APP_NAME,
    "Foods Menu",
    "Drinks Menu",
    "Reviews"
  ];

  String getTitle() {
    return _detailTitle[_currentIndex];
  }
}
