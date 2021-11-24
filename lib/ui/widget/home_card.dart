import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/response_model.dart';
import 'package:restaurant_app/data/repository_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/utils/const.dart';
import 'package:restaurant_app/utils/theme.dart';

class HomeCard extends StatelessWidget {
  final Restaurant restaurant;
  const HomeCard({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        margin: const EdgeInsets.all(8),
        elevation: 8.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: InkWell(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  Image.network(
                    MEDIUM_IMAGE + restaurant.pictureId,
                    fit: BoxFit.fill,
                    loadingBuilder: (context, child, progress) {
                      if (progress == null) return child;
                      return Center(
                        child: CircularProgressIndicator(
                          value: progress.expectedTotalBytes != null
                              ? progress.cumulativeBytesLoaded /
                                  progress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16.0),
                        topRight: Radius.circular(16.0),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.red,
                        ),
                        Text(
                          restaurant.rating,
                          style: ratingStyle,
                        )
                      ],
                    ),
                  )
                ],
              ),
              ListTile(
                leading: Container(
                  height: double.infinity,
                  child: Icon(
                    Icons.place,
                    color: Colors.red,
                  ),
                ),
                title: Text(
                  restaurant.name,
                  style: titleStyle,
                ),
                subtitle: Text(restaurant.city),
              ),
            ],
          ),
          onTap: () {
            Provider.of<Repository>(context, listen: false)
                .fetchRestaurantDetails(restaurant.id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailPage(restaurantId: restaurant.id),
              ),
            );
          },
        ),
      );
}
