import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/widget/detail_section.dart';
import 'package:restaurant_app/ui/widget/menu_grid.dart';
import 'package:restaurant_app/utils/const.dart';
import 'package:restaurant_app/utils/theme.dart';

import 'widget/exception_card.dart';

class DetailPage extends StatelessWidget {
  static const routeName = '/detail';
  final String restaurantId;

  const DetailPage({
    required this.restaurantId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<RestaurantProvider>(
        builder: (context, provider, _) {
          if (provider.state == APIState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == APIState.NoData) {
            return ExceptionCard(
              assetPath: 'assets/lottie/empty-box.json',
              message: provider.message,
            );
          } else if (provider.state == APIState.Error) {
            return ExceptionCard(
              assetPath: 'assets/lottie/error-cone.json',
              message: provider.message,
            );
          } else {
            return _buildDetailPage(
              context,
              provider.restaurantDetail.restaurant,
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailPage(BuildContext context, DetailRestaurant restaurant) {
    return DefaultTabController(
      length: 4,
      child: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: FlexibleSpaceBar(
                background: CachedNetworkImage(
                  imageUrl: MEDIUM_IMAGE + restaurant.pictureId,
                  fit: BoxFit.fitWidth,
                ),
              ),
              title: Text(
                Provider.of<RestaurantProvider>(context).getTitle(),
                style: titleStyle,
              ),
              centerTitle: true,
              actions: [
                IconButton(
                    onPressed: () => _showNextSubDialog(context),
                    icon: Icon(Icons.favorite_rounded))
              ],
              bottom: TabBar(
                onTap: (index) {
                  Provider.of<RestaurantProvider>(context, listen: false)
                      .setIndex(index);
                },
                tabs: [
                  Tab(icon: Icon(Icons.storefront_rounded)),
                  Tab(icon: Icon(Icons.restaurant_menu_rounded)),
                  Tab(icon: Icon(Icons.local_bar_rounded)),
                  Tab(icon: Icon(Icons.reviews_rounded)),
                ],
              ),
            )
          ];
        },
        body: TabBarView(
          children: [
            DetailSection(restaurant: restaurant),
            MenuGrid(
              items: restaurant.menus.foods,
              type: "food",
            ),
            MenuGrid(items: restaurant.menus.drinks, type: "drink"),
            _buildListReview(context, restaurant.customerReviews),
          ],
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

  Future<void> _showNextSubDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => AlertDialog(
        title: const Text('WIP Feature'),
        content: Text('This feature still in work'),
        actions: [
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
