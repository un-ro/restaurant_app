import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/response_detail.dart';
import 'package:restaurant_app/utils/const.dart';
import 'package:restaurant_app/utils/theme.dart';

class DetailSection extends StatelessWidget {
  final DetailRestaurant restaurant;
  const DetailSection({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> _listCategory = <String>[];
    restaurant.categories.forEach((element) {
      _listCategory.add(element.name);
    });
    final _categories = _listCategory.join(", ");

    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            CachedNetworkImage(
              imageUrl: MEDIUM_IMAGE + restaurant.pictureId,
              fit: BoxFit.fitWidth,
              height: 200,
              width: MediaQuery.of(context).size.width,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Text(
                restaurant.name,
                style: titleStyle,
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.explore_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4.0),
                      Text(
                        'Location',
                        style: titleStyle,
                      ),
                    ],
                  ),
                  Text(
                    '${restaurant.city}, ${restaurant.address}',
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4.0),
                      Text('Rating', style: titleStyle),
                    ],
                  ),
                  Text(
                    '${restaurant.rating} given from ${restaurant.customerReviews.length} Reviewers',
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.category_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4.0),
                      Text('Categories', style: titleStyle),
                    ],
                  ),
                  Text(_categories),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_rounded,
                        color: Colors.red,
                      ),
                      const SizedBox(width: 4.0),
                      Text('Description', style: titleStyle),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                restaurant.description,
                textAlign: TextAlign.justify,
                maxLines: 5,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
