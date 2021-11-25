import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/provider/providers.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/utils/const.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/utils/theme.dart';

import '../data/model/response_model.dart';
import 'favorite_page.dart';
import 'widget/home_card.dart';

class HomePage extends StatefulWidget {
  static final String routeName = "/home";
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(DetailPage.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME, style: appTitleStyle),
        actions: [
          IconButton(
            icon: Icon(Icons.search_rounded),
            onPressed: () => Navigator.pushNamed(context, SearchPage.routeName),
          ),
          IconButton(
            icon: Icon(Icons.favorite_rounded),
            onPressed: () =>
                Navigator.pushNamed(context, FavoritePage.routeName),
          ),
          IconButton(
            icon: Icon(Icons.settings_rounded),
            onPressed: () =>
                Navigator.pushNamed(context, SettingPage.routeName),
          ),
        ],
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(8.0),
        child: Consumer<Repository>(
          builder: (context, provider, _) {
            switch (provider.homeState) {
              case APIState.LOADING:
                return Center(child: CircularProgressIndicator());
              case APIState.EMPTY:
                return Center(child: Text('Something Wrong'));
              case APIState.ERROR:
                return Center(child: Text('Something Wrong'));
              case APIState.DONE:
                return _buildList(context, provider.homeResult.restaurants);
            }
          },
        ),
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
}
