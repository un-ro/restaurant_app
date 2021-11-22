import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/ui/widget/exception_card.dart';

import '../data/model/response_model.dart';
import '../provider/restaurant_provider.dart';
import 'widget/home_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == APIState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == APIState.HasData) {
          return _buildList(context, state.result.restaurants);
        } else if (state.state == APIState.NoData) {
          return ExceptionCard(
            assetPath: 'assets/lottie/empty-box.json',
            message: state.message,
          );
        } else if (state.state == APIState.Error) {
          return ExceptionCard(
            assetPath: 'assets/lottie/error-cone.json',
            message: state.message,
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
