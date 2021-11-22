import 'package:flutter/material.dart';

import '../utils/const.dart';
import '../utils/theme.dart';
import 'ui.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  static const List<Widget> _list = <Widget>[
    HomePage(),
    SearchPage(),
    FavoritePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          APP_NAME,
          style: appTitleStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_rounded),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingPage()),
              );
            },
          ),
        ],
      ),
      body: _list.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_rounded),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_rounded),
            label: 'Favorite',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        showUnselectedLabels: false,
      ),
    );
  }
}
