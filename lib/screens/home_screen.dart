import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:restaurant_app/screens/detail_screen.dart';

class HomePage extends StatelessWidget {
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text(
              'Go Nakam',
              style: GoogleFonts.pacifico(fontSize: 30),
            ),
          ),
          bottom: PreferredSize(
            child: Text(
              'No worries for tummies',
              style: GoogleFonts.pacifico(color: Colors.white),
            ),
            preferredSize: Size.fromHeight(0),
          ),
        ),
        body: FutureBuilder<String>(
          future: DefaultAssetBundle.of(context)
              .loadString('assets/local_restaurant.json'),
          builder: (context, snapshot) {
            final List<Restaurant> restaurants =
                parseRestaurants(snapshot.data);
            return ListView.builder(
              itemCount: restaurants.length,
              itemBuilder: (context, index) {
                return _buildItem(context, restaurants[index]);
              },
            );
          },
        ));
  }

  Widget _buildItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Image.network(
        restaurant.pictureId,
        width: 100,
      ),
      title: Text(restaurant.name),
      subtitle: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Icon(
                Icons.room,
                size: 16,
                color: Colors.red,
                semanticLabel: 'Location',
              ),
              Text(restaurant.city),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Icon(
                Icons.star_rate_sharp,
                size: 16,
                color: Colors.yellow,
                semanticLabel: 'Rating',
              ),
              Text(restaurant.rating.toString()),
            ],
          )
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, DetailPage.routeName,
            arguments: restaurant);
      },
    );
  }
}
