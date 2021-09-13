import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:restaurant_app/models/restaurant.dart';
import 'package:share_plus/share_plus.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';

  final Restaurant restaurant;

  const DetailPage({
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  restaurant.pictureId,
                  fit: BoxFit.fitWidth,
                ),
                title: Text(
                  restaurant.name,
                  style: GoogleFonts.merienda(fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(
                        'Let\'s go to ${restaurant.name} at ${restaurant.city} City they provide many menus');
                  },
                ),
              ],
            ),
          ];
        },
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.room,
                          color: Colors.red,
                        ),
                        Text(
                          restaurant.city,
                          style: GoogleFonts.montserrat(),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Icon(Icons.star_rate, color: Colors.yellow),
                        Text(
                          restaurant.rating.toString(),
                          style: GoogleFonts.montserrat(),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  restaurant.description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.montserrat(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.dining, color: Colors.green),
                    Text(
                      'Foods Menu',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.merienda(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: restaurant.menus.foods.map((food) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('images/food.jpg'),
                          ),
                          Center(
                            child: Text(
                              food.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.coffee, color: Colors.green),
                    Text(
                      'Drinks Menu',
                      style: GoogleFonts.merienda(fontSize: 20),
                    ),
                  ],
                ),
              ),
              Container(
                height: 150,
                child: ListView(
                  reverse: true,
                  scrollDirection: Axis.horizontal,
                  children: restaurant.menus.drinks.map((drink) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8.0,
                        horizontal: 16.0,
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.asset('images/drink.jpg'),
                          ),
                          Center(
                            child: Text(
                              drink.name,
                              textAlign: TextAlign.center,
                              style: GoogleFonts.montserrat(
                                color: Colors.white,
                                backgroundColor: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
