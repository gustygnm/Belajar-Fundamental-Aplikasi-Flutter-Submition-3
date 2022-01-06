import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/repository/restaurant_repository.dart';

abstract class GetListRestaurantUseCase {
  Future<List<RestaurantEntity>> getListRestaurant();
}

class GetListRestaurantUseCaseImpl extends GetListRestaurantUseCase {
  RestaurantRepository restaurantRepository;

  GetListRestaurantUseCaseImpl({
     this.restaurantRepository,
  });

  @override
  Future<List<RestaurantEntity>> getListRestaurant() =>
      restaurantRepository.getListRestaurant();
}
