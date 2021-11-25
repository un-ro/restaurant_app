class RestaurantsResult {
  List<Restaurant> restaurants;

  RestaurantsResult({required this.restaurants});

  factory RestaurantsResult.fromJson(Map<String, dynamic> json) =>
      RestaurantsResult(
        restaurants: List<Restaurant>.from(
            (json['restaurants'] as List).map((e) => Restaurant.fromJson(e))),
      );
}

class Restaurant {
  String id;
  String name;
  String description;
  String city;
  String pictureId;
  String rating;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.pictureId,
    required this.rating,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        pictureId: json['pictureId'],
        rating: json['rating'].toString(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'pictureId': pictureId,
        'city': city,
        'rating': rating
      };
}
