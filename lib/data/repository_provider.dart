import 'package:flutter/material.dart';
import 'package:restaurant_app/data/database/database_helper.dart';
import 'package:restaurant_app/data/model/favorite.dart';

class Repository with ChangeNotifier {
  List<Favorite> _favorites = [];
  late DatabaseHelper _databaseHelper;

  List<Favorite> get favorites => _favorites;

  Repository() {
    _databaseHelper = DatabaseHelper();
    _getFavorites();
  }

  // Database get Favorites
  void _getFavorites() async {
    _favorites = await _databaseHelper.getFavorites();
    notifyListeners();
  }

  // Database get Favorite by id
  Future<Favorite> getFavoriteById(String id) async =>
      await _databaseHelper.getFavoriteById(id);

  // Database add Favorite
  Future<void> addFavorite(Favorite favorite) async =>
      await _databaseHelper.addFavorite(favorite);

  // Database delete Favorite
  void removeFavorite(String id) async =>
      await _databaseHelper.removeFavorite(id);
}
