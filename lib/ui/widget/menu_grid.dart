import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/utils/theme.dart';

class MenuGrid extends StatelessWidget {
  final List<Item> items;
  final String type;
  const MenuGrid({Key? key, required this.items, required this.type})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _assetString = "";
    if (type == 'food') {
      _assetString = 'assets/menu.jpg';
    } else {
      _assetString = 'assets/drink.jpg';
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 4.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(_assetString),
                Text(
                  item.name,
                  style: titleStyle,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
