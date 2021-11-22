import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response_list.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/widget/exception_card.dart';

import 'widget/home_card.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _currentQuery = Provider.of<RestaurantProvider>(context).searchQuery;
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildSearchBar(context),
          Consumer<RestaurantProvider>(
            builder: (context, state, _) {
              if (state.searchState == APIState.Loading) {
                return Center(child: CircularProgressIndicator());
              } else if (state.searchState == APIState.HasData) {
                return Expanded(
                  child: _buildList(context, state.searchResult.restaurants),
                );
              } else if (state.searchState == APIState.NoData) {
                return ExceptionCard(
                  assetPath: 'assets/lottie/empty-box.json',
                  message: state.message,
                );
              } else if (state.searchState == APIState.Error) {
                return ExceptionCard(
                  assetPath: 'assets/lottie/error-cone.json',
                  message: state.message,
                );
              } else {
                return ExceptionCard(
                  assetPath: 'assets/lottie/error-cone.json',
                  message: 'Search',
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final _currentQuery = Provider.of<RestaurantProvider>(context).searchQuery;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Search...',
              ),
              onChanged: (query) {
                Provider.of<RestaurantProvider>(context, listen: false)
                    .setQuery(query);
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              if (_currentQuery.isNotEmpty) {
                Provider.of<RestaurantProvider>(context, listen: false)
                    .fetchSearch();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildList(BuildContext context, List<Restaurant> restaurants) =>
      ListView.builder(
        shrinkWrap: true,
        itemCount: restaurants.length,
        itemBuilder: (context, index) {
          final restaurant = restaurants[index];
          return HomeCard(restaurant: restaurant);
        },
      );
}
