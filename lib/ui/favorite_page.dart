import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/provider/repository_provider.dart';
import 'package:restaurant_app/utils/const.dart';

import 'detail_page.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite';
  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourite Restaurant'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8.0),
        child: ChangeNotifierProvider<Repository>(
          lazy: true,
          create: (context) => Repository().listFavorite(),
          child: _buildFavorites(context),
        ),
      ),
    );
  }

  Widget _buildFavorites(BuildContext context) {
    return Consumer<Repository>(
      builder: (context, provider, _) {
        if (provider.favorites.isEmpty) {
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
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              final favorite = provider.favorites[index];
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
                      Navigation.intentWithData(
                          DetailPage.routeName, favorite.id);
                    },
                  ),
                ),
              );
            },
          );
        }
      },
    );
  }
}
