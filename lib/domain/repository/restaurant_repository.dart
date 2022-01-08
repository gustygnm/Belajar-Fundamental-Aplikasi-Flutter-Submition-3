import 'package:bobobox_restaurant/domain/entity/detail_restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';

abstract class RestaurantRepository {
  Future<RestaurantListEntity> getListRestaurant();
  Future<DetailRestaurantEntity> getRestaurantDetail(String restaurantId);
  Future<RestaurantListEntity> searchRestaurant(String restaurantName);
}
