import 'package:flutter/material.dart';
import 'package:restaurant_app/models/restaurant.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';

  final Restaurant restaurant;

  const DetailPage({
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(restaurant.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network(restaurant.pictureId),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(restaurant.description),
                  Divider(color: Colors.grey,),
                ],
              )
            )
          ],
        )
      ),
    );
  }
}