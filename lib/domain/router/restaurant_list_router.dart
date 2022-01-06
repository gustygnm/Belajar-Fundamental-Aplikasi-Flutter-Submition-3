import 'package:flutter/material.dart';
import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';
import 'package:bobobox_restaurant/presentation/pages/detail_restaurant_screen/detail_restaurant_screen.dart';
import 'package:bobobox_restaurant/presentation/pages/search_restaurant_screen.dart';

abstract class RestaurantListRouter {
  goToDetailListRestaurant(context, RestaurantEntity restaurantEntity);

  goToSearchRestaurant(context);
}

class RestaurantListRouterImpl extends RestaurantListRouter {
  @override
  goToDetailListRestaurant(context, RestaurantEntity restaurantEntity) =>
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              DetailRestaurantScreen(restaurantEntity: restaurantEntity),
        ),
      );

  @override
  goToSearchRestaurant(context) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const SearchRestaurantScreen(),
        ),
      );
}
