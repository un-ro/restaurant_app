import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/response_list.dart';

void main() {
  group('JSON Parsing Test', () {
    var restaurantsJson = {
      "error": false,
      "message": "success",
      "count": 20,
      "restaurants": [
        {
          "id": "rqdv5juczeskfw1e867",
          "name": "Melting Pot",
          "description":
              "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
          "pictureId": "14",
          "city": "Medan",
          "rating": 4.2
        },
        {
          "id": "s1knt6za9kkfw1e867",
          "name": "Kafe Kita",
          "description":
              "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
          "pictureId": "25",
          "city": "Gorontalo",
          "rating": 4
        }
      ]
    };

    test('should contain 2 restaurant', () {
      var result = RestaurantsResult.fromJson(restaurantsJson);
      expect(result.restaurants.length, 2);
    });

    test('should pass when check restaurant name', () {
      var result = RestaurantsResult.fromJson(restaurantsJson);
      expect(result.restaurants[0].name, "Melting Pot");
    });
  });
}
