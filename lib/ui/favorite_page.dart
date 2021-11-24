import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/data/repository_provider.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Repository>(builder: (context, provider, _) {
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
        return Center(
          child: Text(favorites.length.toString()),
        );
      }
    });
  }
}
