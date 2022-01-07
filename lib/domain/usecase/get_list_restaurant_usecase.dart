import 'package:flutter/foundation.dart';
import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/repository/restaurant_repository.dart';

abstract class GetListRestaurantUseCase {
  Future<RestaurantListEntity> getListRestaurant();
}

class GetListRestaurantUseCaseImpl extends GetListRestaurantUseCase {
  RestaurantRepository restaurantRepository;

  GetListRestaurantUseCaseImpl({@required this.restaurantRepository});

  @override
  Future<RestaurantListEntity> getListRestaurant() =>
      restaurantRepository.getListRestaurant();
}
