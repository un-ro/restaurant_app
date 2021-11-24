import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/data/repository_provider.dart';
import 'package:restaurant_app/utils/const.dart';

import 'detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Repository>(
      builder: (context, provider, _) {
        final List<Favorite> favorites = provider.favorites;
        if (favorites.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Lottie.asset(
                  'assets/lottie/empty-box.json',
                  width: 200,
                  height: 200,
                ),
                SizedBox(height: 8),
                Text('No Favorite Restaurant',
                    style: GoogleFonts.poppins(fontSize: 18)),
              ],
            ),
          );
        } else {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final favorite = favorites[index];
                return Dismissible(
                  key: Key(favorite.id),
                  background: Container(
                    padding: const EdgeInsets.only(right: 16),
                    color: Colors.red,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
                  onDismissed: (direction) {
                    provider.removeFavorite(favorite.id);
                  },
                  child: Card(
                    child: ListTile(
                      leading: CachedNetworkImage(
                        imageUrl: SMALL_IMAGE + favorite.pictureId,
                        height: 80,
                        width: 100,
                      ),
                      title: Text(favorite.name),
                      subtitle: Text(favorite.city),
                      onTap: () {
                        Provider.of<Repository>(context, listen: false)
                            .fetchRestaurantDetails(favorite.id);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DetailPage(restaurantId: favorite.id),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
