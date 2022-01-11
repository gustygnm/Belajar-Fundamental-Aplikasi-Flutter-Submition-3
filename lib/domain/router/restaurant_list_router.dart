import 'package:bobobox_restaurant/ui/detail_restaurant/detail_restaurant_page.dart';
import 'package:bobobox_restaurant/ui/search_restaurant_page.dart';
import 'package:flutter/material.dart';
abstract class RestaurantListRouter {
  goToDetailListRestaurant(context, String restaurantId, String restaurantName,
      String restaurantImage);

  goToSearchRestaurant(context);
}

class RestaurantListRouterImpl extends RestaurantListRouter {
  @override
  goToDetailListRestaurant(context, String restaurantId, String restaurantName,
          String restaurantImage) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              DetailRestaurantPage(
            restaurantId: restaurantId,
            restaurantImage: restaurantImage,
            restaurantName: restaurantName,
          ),
        ),
      );

  @override
  goToSearchRestaurant(context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => SearchRestaurantPage()));

}
