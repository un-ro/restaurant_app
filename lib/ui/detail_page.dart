import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/data/repository_provider.dart';
import 'package:restaurant_app/ui/widget/detail_section.dart';
import 'package:restaurant_app/ui/widget/exception_card.dart';
import 'package:restaurant_app/ui/widget/menu_grid.dart';
import 'package:restaurant_app/utils/const.dart';
import 'package:restaurant_app/utils/theme.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;

  const DetailPage({required this.restaurantId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isFavorite = false;
  int _selectedIndex = 0;

  initState() {
    super.initState();
  }

  Widget _listWidget(BuildContext context, DetailRestaurant restaurant) {
    final _list = <Widget>[
      DetailSection(restaurant: restaurant),
      MenuGrid(items: restaurant.menus.foods, type: "food"),
      MenuGrid(items: restaurant.menus.drinks, type: "drink"),
      _buildListReview(context, restaurant.customerReviews),
    ];
    return _list.elementAt(_selectedIndex);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME, style: appTitleStyle),
        actions: [
          IconButton(
            icon: Icon(Icons.favorite_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: Consumer<Repository>(
        builder: (context, provider, _) {
          if (provider.state == APIState.LOADING) {
            return Center(child: CircularProgressIndicator());
          } else if (provider.state == APIState.DONE) {
            final restaurant = provider.detailResult.restaurant;
            return _listWidget(context, restaurant);
          } else if (provider.state == APIState.ERROR) {
            return ExceptionCard(
              assetPath: 'assets/lottie/error-cone.json',
              message: provider.message,
            );
          } else {
            return Container();
          }
        },
      ),
      bottomNavigationBar: Container(
        height: 75,
        width: MediaQuery.of(context).size.width,
        child: BottomNavigationBar(
          items: detailBottomNav,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          showUnselectedLabels: false,
          selectedItemColor: Colors.green,
        ),
      ),
    );
  }

  Widget _buildListReview(BuildContext context, List<Review> reviews) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        final review = reviews[index];
        return ListTile(
          leading: CircleAvatar(
            child: Text(review.name[0]),
          ),
          title: Text('${review.name} | ${review.date}'),
          subtitle: Text(review.review),
        );
      },
    );
  }
}
