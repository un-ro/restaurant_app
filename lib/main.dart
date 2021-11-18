import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'provider/restaurant_provider.dart';
import 'ui/ui.dart';
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
        debugShowCheckedModeBanner: true,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (context) => HomePage(),
          DetailPage.routeName: (context) => DetailPage(
              restaurantId:
                  ModalRoute.of(context)?.settings.arguments as String),
        },
      ),
    );
  }
}
