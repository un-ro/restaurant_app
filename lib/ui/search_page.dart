import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response_list.dart';
import 'package:restaurant_app/data/repository_provider.dart';
import 'package:restaurant_app/ui/widget/exception_card.dart';

import 'widget/home_card.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final _searchController = TextEditingController();

  bool _isSearching = false;

  void setSearching(bool value) {
    setState(() {
      _isSearching = value;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _buildSearchBar(context),
          Consumer<Repository>(
            builder: (context, provider, _) {
              if (_isSearching) {
                if (provider.state == APIState.LOADING) {
                  return Center(child: CircularProgressIndicator());
                } else if (provider.state == APIState.DONE) {
                  return Expanded(
                    child:
                        _buildList(context, provider.searchResult.restaurants),
                  );
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
                  return ExceptionCard(
                    assetPath: 'assets/lottie/error-cone.json',
                    message: 'Search',
                  );
                }
              } else {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.asset(
                        'assets/lottie/error-cone.json',
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: MediaQuery.of(context).size.width * 0.8,
                      ),
                      SizedBox(height: 10),
                      Text('Start to search something', style: GoogleFonts.poppins(),)
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
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
              controller: _searchController,
            ),
          ),
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () {
              final query = _searchController.text;
              if (query.isNotEmpty) {
                Provider.of<Repository>(context, listen: false)
                    .fetchSearch(query);
                setSearching(true);
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
