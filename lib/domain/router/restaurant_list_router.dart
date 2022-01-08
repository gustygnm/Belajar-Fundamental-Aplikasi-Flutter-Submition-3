import 'package:bobobox_restaurant/presentation/pages/detail_restaurant/detail_restaurant_screen.dart';
import 'package:bobobox_restaurant/presentation/pages/search_restaurant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              DetailRestaurantScreen(
            restaurantId: restaurantId,
            restaurantImage: restaurantImage,
            restaurantName: restaurantName,
          ),
        ),
      );

  @override
  goToSearchRestaurant(context) => Navigator.push(context,
      MaterialPageRoute(builder: (context) => SearchRestaurantScreen()));

}
