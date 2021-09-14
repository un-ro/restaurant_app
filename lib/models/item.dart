class Item {
  late String name;

  Item({required this.name});

  Item.fromJson(Map<String, dynamic> json) {
    name = json['name'];
  }
}
