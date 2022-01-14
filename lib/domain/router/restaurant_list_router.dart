import 'package:bobobox_restaurant/ui/favorite_page.dart';
import 'package:bobobox_restaurant/ui/search_restaurant_page.dart';
import 'package:bobobox_restaurant/ui/setting_page.dart';
import 'package:flutter/material.dart';

abstract class RestaurantListRouter {
  goToSearchRestaurant(context);

  goToFavoritRestaurant(context);

  goToSettingRestaurant(context);
}

class RestaurantListRouterImpl extends RestaurantListRouter {

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
