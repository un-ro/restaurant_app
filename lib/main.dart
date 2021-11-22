import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/ui/main_page.dart';
import 'package:restaurant_app/utils/theme.dart';

import 'provider/restaurant_provider.dart';
import 'utils/const.dart';

void main() => runApp(GoNakamApp());

class GoNakamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantProvider>(
      create: (_) => RestaurantProvider(),
      child: MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.green,
          splashColor: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: MainPage(),
      ),
    );
  }
}
