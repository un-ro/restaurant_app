class DetailResult {
  bool error;
  String message;
  DetailRestaurant restaurant;

  DetailResult({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory DetailResult.fromJson(Map<String, dynamic> json) => DetailResult(
        error: json['error'],
        message: json['message'],
        restaurant: DetailRestaurant.fromJson(json['restaurant']),
      );
}

class DetailRestaurant {
  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  String rating;
  List<Item> categories;
  Menu menus;
  List<Review> customerReviews;

  DetailRestaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews,
  });

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        city: json['city'],
        address: json['address'],
        pictureId: json['pictureId'],
        rating: json['rating'].toString(),
        categories:
            List<Item>.from(json['categories'].map((c) => Item.fromJson(c))),
        menus: Menu.fromJson(json['menus']),
        customerReviews: List<Review>.from(
            json['customerReviews'].map((r) => Review.fromJson(r))),
      );
}

class Menu {
  List<Item> foods;
  List<Item> drinks;

  Menu({
    required this.foods,
    required this.drinks,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => Menu(
        foods:
            List<Item>.from(json['foods'].map((food) => Item.fromJson(food))),
        drinks: List<Item>.from(
            json['drinks'].map((drink) => Item.fromJson(drink))),
      );
}

class Item {
  late String name;

  Item({required this.name});

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        name: json['name'],
      );
}

class Review {
  String name;
  String review;
  String date;

  Review({
    required this.name,
    required this.review,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json['name'],
        review: json['review'],
        date: json['date'],
      );
}
