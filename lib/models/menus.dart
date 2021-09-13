import 'drink.dart';
import 'food.dart';

class Menus {
	late List<Food> foods;
	late List<Drink> drinks;

	Menus({
    required this.foods,
    required this.drinks
  });

  Menus.fromJson(Map<String, dynamic> json) {
    foods = json['foods'];
    drinks = json['drinks'];
  }
}
