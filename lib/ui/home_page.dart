import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/ui/widget/exception_card.dart';

import '../data/model/response_model.dart';
import '../provider/restaurant_provider.dart';
import '../utils/const.dart';
import '../utils/theme.dart';
import 'widget/home_card.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final query = Provider.of<RestaurantProvider>(context).searchQuery;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          APP_NAME,
          style: appTitleStyle,
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: Container(
            child: Card(
              elevation: 4,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none, hintText: 'Search'),
                              autofocus: false,
                              textInputAction: TextInputAction.done,
                              onChanged: (value) {
                                Provider.of<RestaurantProvider>(context,
                                        listen: false)
                                    .setQuery(value);
                              },
                              onSubmitted: (value) => _search(context, value),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 6.0),
                    IconButton(
                      icon: const Icon(Icons.search_rounded),
                      onPressed: () => _search(context, query),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<RestaurantProvider>(
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
      ),
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

  void _search(BuildContext context, String value) {
    if (value.isNotEmpty) {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchRestaurants('search');
    }
  }
}
