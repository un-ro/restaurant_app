import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/const.dart';
import 'package:restaurant_app/utils/theme.dart';

List<BottomNavigationBarItem> detailBottomNav = [
  BottomNavigationBarItem(
    icon: Icon(
      Icons.storefront_rounded,
      color: Colors.green,
    ),
    label: 'Restaurant',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.restaurant_menu_rounded,
      color: Colors.green,
    ),
    label: 'Foods Menu',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.local_bar_rounded,
      color: Colors.green,
    ),
    label: 'Drinks Menu',
  ),
  BottomNavigationBarItem(
    icon: Icon(
      Icons.reviews_rounded,
      color: Colors.green,
    ),
    label: 'Review',
  ),
];

AppBar defaultAppBar = AppBar(
  title: Text(
    APP_NAME,
    style: appTitleStyle,
  ),
);
