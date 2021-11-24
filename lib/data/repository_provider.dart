import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/database/database_helper.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/data/model/response_model.dart';

enum APIState { LOADING, EMPTY, ERROR, DONE }

class Repository with ChangeNotifier {
  List<Favorite> _favorites = [];
  late DatabaseHelper _databaseHelper;
  late ApiService _apiService;

  List<Favorite> get favorites => _favorites;

  Repository() {
    _databaseHelper = DatabaseHelper();
    _apiService = ApiService();
    fetchRestaurants();
    _getFavorites();
  }

  late RestaurantsResult _homeResult;
  late RestaurantsResult _searchResult;
  late DetailResult _detailResult;
  late APIState _state;
  late String _message;

  String get message => _message;
  RestaurantsResult get homeResult => _homeResult;
  RestaurantsResult get searchResult => _searchResult;
  DetailResult get detailResult => _detailResult;
  APIState get state => _state;

  // API get Restaurant List
  Future<dynamic> fetchRestaurants() async {
    try {
      _state = APIState.LOADING;
      notifyListeners();

      final response = await _apiService.getRestaurants();

      if (response.restaurants.isEmpty) {
        _state = APIState.EMPTY;
        notifyListeners();
        return _message = 'No restaurants found';
      } else {
        _state = APIState.DONE;
        notifyListeners();
        return _homeResult = response;
      }
    } catch (error) {
      _state = APIState.ERROR;
      notifyListeners();
      return _message = 'Something went wrong, check your connection';
    }
  }

  // API get Search Restaurant
  Future<dynamic> fetchSearch(String query) async {
    try {
      _state = APIState.LOADING;
      notifyListeners();

      final response = await _apiService.getSearchRestaurants(query);

      if (response.restaurants.isEmpty) {
        _state = APIState.EMPTY;
        notifyListeners();
        return _message = 'No restaurants found';
      } else {
        _state = APIState.DONE;
        notifyListeners();
        return _searchResult = response;
      }
    } catch (error) {
      _state = APIState.ERROR;
      notifyListeners();
      return _message = 'Something went wrong, check your connection';
    }
  }

  // API get Restaurant Details
  Future<dynamic> fetchRestaurantDetails(String id) async {
    try {
      _state = APIState.LOADING;
      notifyListeners();

      final response = await _apiService.getRestaurant(id);

      if (response.message == 'restaurant not found') {
        _state = APIState.EMPTY;
        notifyListeners();
        return _message = 'No restaurants found';
      } else {
        _state = APIState.DONE;
        notifyListeners();
        return _detailResult = response;
      }
    } catch (error) {
      _state = APIState.ERROR;
      notifyListeners();
      return _message = 'Something went wrong, check your connection';
    }
  }

  // Database get Favorites
  void _getFavorites() async {
    _favorites = await _databaseHelper.getFavorites();
    notifyListeners();
  }

  // Database get Favorite by id
  Future<Favorite?> getFavoriteById(String id) async =>
      await _databaseHelper.getFavoriteById(id);

  // Database add Favorite
  Future<void> addFavorite(DetailRestaurant restaurant) async {
    final favorite = Favorite(
      id: restaurant.id,
      pictureId: restaurant.pictureId,
      name: restaurant.name,
      city: restaurant.city,
      rating: restaurant.rating,
    );
    await _databaseHelper.addFavorite(favorite);
    _getFavorites();
  }

  // Database delete Favorite
  void removeFavorite(String id) async {
    await _databaseHelper.removeFavorite(id);
    _getFavorites();
  }
}
