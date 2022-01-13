import 'package:bobobox_restaurant/data/model/list_restaurant_model.dart'
    as list;
import 'package:bobobox_restaurant/ui/detail_restaurant/detail_restaurant_page.dart';
import 'package:bobobox_restaurant/ui/favorite_page.dart';
import 'package:bobobox_restaurant/ui/search_restaurant_page.dart';
import 'package:bobobox_restaurant/ui/setting_page.dart';
import 'package:flutter/material.dart';

abstract class RestaurantListRouter {
  goToDetailListRestaurant(context, String restaurantId,
      list.Restaurant restaurantName, String restaurantImage);

  goToSearchRestaurant(context);

  goToFavoritRestaurant(context);

  goToSettingRestaurant(context);
}

class RestaurantListRouterImpl extends RestaurantListRouter {
  @override
  goToDetailListRestaurant(context, String restaurantId,
          list.Restaurant restaurantName, String restaurantImage) =>
      Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 1000),
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              DetailRestaurantPage(
            restaurantId: restaurantId,
            restaurantImage: restaurantImage,
            restaurant: restaurantName,
          ),
        ),
      );

  @override
  goToSearchRestaurant(context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => SearchRestaurantPage()));

  @override
  goToFavoritRestaurant(context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => FavoritePage()));

  @override
  goToSettingRestaurant(context) => Navigator.push(
      context, MaterialPageRoute(builder: (context) => SettingPage()));
}
