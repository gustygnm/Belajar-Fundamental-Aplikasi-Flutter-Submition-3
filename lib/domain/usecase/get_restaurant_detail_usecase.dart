import 'package:flutter/foundation.dart';
import 'package:bobobox_restaurant/domain/entity/detail_restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/repository/restaurant_repository.dart';

abstract class GetRestaurantDetailUseCase {
  Future<DetailRestaurantEntity> getRestaurantDetail(String restaurantId);
}

class GetRestaurantDetailUseCaseImpl extends GetRestaurantDetailUseCase {
  RestaurantRepository restaurantRepository;

  GetRestaurantDetailUseCaseImpl({@required this.restaurantRepository});

  @override
  Future<DetailRestaurantEntity> getRestaurantDetail(String restaurantId) =>
      restaurantRepository.getRestaurantDetail(restaurantId);
}
