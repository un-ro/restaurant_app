import 'package:restaurant_app/models/item.dart';

class Menus {
  late List<Item> foods;
  late List<Item> drinks;

  Menus({required this.foods, required this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    foods = List<Item>.from(json['foods'].map((food) => Item.fromJson(food)));
    drinks =
        List<Item>.from(json['drinks'].map((drink) => Item.fromJson(drink)));
  }
}
