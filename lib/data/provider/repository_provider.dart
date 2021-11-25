import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/database/database_helper.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/utils/const.dart';

enum APIState { LOADING, EMPTY, ERROR, DONE }

class Repository extends ChangeNotifier {
  List<Favorite> _favorites = [];
  late DatabaseHelper _databaseHelper;
  late ApiService _apiService;

  List<Favorite> get favorites => _favorites;

  Repository() {
    _databaseHelper = DatabaseHelper();
    _apiService = ApiService();
  }

  Repository fetchRestaurants() {
    _fetchRestaurants();
    return this;
  }

  Repository fetchDetail(String id) {
    fetchRestaurantDetails(id);
    return this;
  }

  Repository listFavorite() {
    _getFavorites();
    return this;
  }

  late RestaurantsResult _homeResult;
  late RestaurantsResult _searchResult;
  late DetailResult _detailResult;

  late APIState _homeState;
  late APIState _searchState;
  late APIState _detailState;

  late String _message;

  RestaurantsResult get homeResult => _homeResult;
  RestaurantsResult get searchResult => _searchResult;
  DetailResult get detailResult => _detailResult;
  APIState get homeState => _homeState;
  APIState get searchState => _searchState;
  APIState get detailState => _detailState;
  String get message => _message;

  // API get Restaurant List
  Future<dynamic> _fetchRestaurants() async {
    try {
      _homeState = APIState.LOADING;
      notifyListeners();

      final response = await _apiService.getRestaurants();

      if (response.restaurants.isEmpty) {
        _homeState = APIState.EMPTY;
        notifyListeners();
        return _message = EMPTY_RESPONSE;
      } else {
        _homeState = APIState.DONE;
        notifyListeners();
        return _homeResult = response;
      }
    } catch (error) {
      _homeState = APIState.ERROR;
      notifyListeners();
      return _message = ERROR_RESPONSE;
    }
  }

  // API get Search Restaurant
  Future<dynamic> fetchSearch(String query) async {
    try {
      _searchState = APIState.LOADING;
      notifyListeners();

      final response = await _apiService.getSearchRestaurants(query);

      if (response.restaurants.isEmpty) {
        _searchState = APIState.EMPTY;
        notifyListeners();
        return _message = EMPTY_RESPONSE;
      } else {
        _searchState = APIState.DONE;
        notifyListeners();
        return _searchResult = response;
      }
    } catch (error) {
      _searchState = APIState.ERROR;
      notifyListeners();
      return _message = ERROR_RESPONSE;
    }
  }

  // API get Restaurant Details
  Future<dynamic> fetchRestaurantDetails(String id) async {
    try {
      _detailState = APIState.LOADING;
      notifyListeners();

      final response = await _apiService.getRestaurant(id);

      if (response.message == 'restaurant not found') {
        _detailState = APIState.EMPTY;
        notifyListeners();
        return _message = EMPTY_RESPONSE;
      } else {
        _detailState = APIState.DONE;
        notifyListeners();
        return _detailResult = response;
      }
    } catch (error) {
      _detailState = APIState.ERROR;
      notifyListeners();
      return _message = ERROR_RESPONSE;
    }
  }

  // Database get Favorites
  void _getFavorites() async {
    _favorites = await _databaseHelper.getFavorites();
    notifyListeners();
  }

  // Database get Favorite by id
  Future<bool> getFavoriteById(String id) async =>
      await _databaseHelper.getFavoriteById(id);

  // Database add Favorite
  void addFavorite(Favorite favorite) async {
    await _databaseHelper.addFavorite(favorite);
    _getFavorites();
  }

  // Database delete Favorite
  void removeFavorite(String id) async {
    await _databaseHelper.removeFavorite(id);
    notifyListeners();
    _getFavorites();
  }
}
