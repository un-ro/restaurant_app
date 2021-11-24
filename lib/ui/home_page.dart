import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widget/exception_card.dart';
import '../data/repository_provider.dart';
import '../data/model/response_model.dart';
import 'widget/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<Repository>(
      builder: (context, provider, _) {
        if (provider.state == APIState.LOADING) {
          return Center(child: CircularProgressIndicator());
        } else if (provider.state == APIState.DONE) {
          return _buildList(context, provider.homeResult.restaurants);
        } else if (provider.state == APIState.EMPTY) {
          return ExceptionCard(
            assetPath: 'assets/lottie/empty-box.json',
            message: provider.message,
          );
        } else if (provider.state == APIState.ERROR) {
          return ExceptionCard(
            assetPath: 'assets/lottie/error-cone.json',
            message: provider.message,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildList(BuildContext context, List<Restaurant> restaurants) =>
      ListView.builder(
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return HomeCard(restaurant: restaurant);
        },
      );
}
