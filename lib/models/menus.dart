import 'drink.dart';
import 'food.dart';

class Menus {
  late List<Food> foods;
  late List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  Menus.fromJson(Map<String, dynamic> json) {
    foods = List<Food>.from(json['foods'].map((food) => Food.fromJson(food)));
    drinks =
        List<Drink>.from(json['drinks'].map((drink) => Drink.fromJson(drink)));
  }
}
