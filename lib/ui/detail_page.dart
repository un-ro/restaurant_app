import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/favorite.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/data/provider/repository_provider.dart';
import 'package:restaurant_app/ui/widget/detail_section.dart';
import 'package:restaurant_app/ui/widget/exception_scaffold.dart';
import 'package:restaurant_app/ui/widget/menu_grid.dart';

import 'widget/component.dart';

class DetailPage extends StatefulWidget {
  static final routeName = '/detail';
  final String restaurantId;

  const DetailPage({required this.restaurantId});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  bool _isFavorite = false;
  int _selectedIndex = 0;

  Widget _listWidget(BuildContext context, DetailRestaurant restaurant) {
    final _list = <Widget>[
      DetailSection(restaurant: restaurant),
      MenuGrid(items: restaurant.menus.foods, type: "food"),
      MenuGrid(items: restaurant.menus.drinks, type: "drink"),
      _buildListReview(context, restaurant.customerReviews),
    ];
    return _list.elementAt(_selectedIndex);
  }

  @override
  void initState() {
    super.initState();
    Provider.of<Repository>(context, listen: false)
        .getFavoriteById(widget.restaurantId)
        .then((value) {
      setState(() {
        _isFavorite = value;
      });
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setFavorite(bool value) {
    setState(() {
      _isFavorite = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => Repository().fetchDetail(widget.restaurantId),
      child: Container(
        child: Consumer<Repository>(
          builder: (context, provider, _) {
            switch (provider.detailState) {
              case APIState.LOADING:
                return ExceptionScaffold(state: provider.detailState);
              case APIState.EMPTY:
                return ExceptionScaffold(state: provider.detailState);
              case APIState.ERROR:
                return ExceptionScaffold(
                  state: provider.detailState,
                  message: provider.message,
                );
              case APIState.DONE:
                final restaurant = provider.detailResult.restaurant;
                return _buildDetailPage(context, provider, restaurant);
            }
          },
        ),
      ),
    );
  }

  Widget _buildDetailPage(
    BuildContext context,
    Repository provider,
    DetailRestaurant restaurant,
  ) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Restaurant Detail'),
      ),
      body: _listWidget(context, restaurant),
      bottomNavigationBar: BottomNavigationBar(
        items: detailBottomNav,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.green,
      ),
      floatingActionButton: FloatingActionButton(
        child: _isFavorite
            ? Icon(
                Icons.favorite_rounded,
                color: Colors.white,
              )
            : Icon(
                Icons.favorite_border_rounded,
                color: Colors.white,
              ),
        onPressed: () {
          if (_isFavorite) {
            provider.removeFavorite(widget.restaurantId);
            setState(() {
              _isFavorite = !_isFavorite;
            });
          } else {
            final favorite = Favorite(
              id: restaurant.id,
              pictureId: restaurant.pictureId,
              name: restaurant.name,
              city: restaurant.city,
            );
            provider.addFavorite(favorite);
            setState(() {
              _isFavorite = !_isFavorite;
            });
          }
        },
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
