import 'dart:convert';

import 'package:http/http.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/utils/const.dart';

class ApiService {
  Future<RestaurantsResult> getRestaurants() async {
    final response = await get(Uri.parse('$BASE_URL/list'));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed connect to Server');
    }
  }

  Future<DetailResult> getRestaurant(String id) async {
    final response = await get(Uri.parse('$BASE_URL/detail/$id'));

    if (response.statusCode == 200) {
      return DetailResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed connect to Server');
    }
  }

  Future<RestaurantsResult> getSearchRestaurants(String query) async {
    final response = await get(Uri.parse('$BASE_URL/search?q=$query'));

    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed connect to Server');
    }
  }
}
