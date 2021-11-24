import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/data/repository_provider.dart';
import 'package:restaurant_app/ui/widget/detail_section.dart';
import 'package:restaurant_app/ui/widget/exception_scaffold.dart';
import 'package:restaurant_app/ui/widget/menu_grid.dart';
import 'package:restaurant_app/utils/const.dart';
import 'package:restaurant_app/utils/theme.dart';

import 'widget/component.dart';

class DetailPage extends StatefulWidget {
  final String restaurantId;

  const DetailPage({required this.restaurantId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isFavorite = false;
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    Provider.of<Repository>(context, listen: false)
        .getFavoriteById(widget.restaurantId)
        .then((value) {
      if (value != null) {
        setState(() {
          _isFavorite = true;
        });
      }
    });
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
    return Consumer<Repository>(
      builder: (context, provider, _) {
        if (provider.state == APIState.LOADING) {
          return ExceptionScaffold(state: provider.state);
        } else if (provider.state == APIState.DONE) {
          final restaurant = provider.detailResult.restaurant;
          return _buildDetailPage(context, restaurant);
        } else if (provider.state == APIState.ERROR) {
          return ExceptionScaffold(
            state: provider.state,
            message: provider.message,
          );
        } else {
          return Container();
        }
      },
    );
  }

  Widget _buildDetailPage(BuildContext context, DetailRestaurant restaurant) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME, style: appTitleStyle),
        actions: [
          IconButton(
            icon: _isFavorite
                ? Icon(Icons.favorite_rounded, color: Colors.red)
                : Icon(Icons.favorite_border_rounded),
            onPressed: () => _onFavorite(context, restaurant),
          ),
        ],
      ),
      body: _listWidget(context, restaurant),
      bottomNavigationBar: BottomNavigationBar(
        items: detailBottomNav,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
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

  void _onFavorite(BuildContext context, DetailRestaurant restaurant) {
    if (_isFavorite) {
      // If true -> remove
      Provider.of<Repository>(context, listen: false)
          .removeFavorite(widget.restaurantId);
    } else {
      // If false -> add
      Provider.of<Repository>(context, listen: false).addFavorite(restaurant);
    }
    // Draw again page.
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }
}
