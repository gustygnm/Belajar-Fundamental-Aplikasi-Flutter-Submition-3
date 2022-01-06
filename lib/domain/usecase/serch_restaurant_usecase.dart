import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/repository/restaurant_repository.dart';

abstract class SearchRestaurantUseCase {
  Future<List<RestaurantEntity>> getListRestaurantByName(String restaurantName);
}

class SearchRestaurantUseCaseImpl extends SearchRestaurantUseCase {
  RestaurantRepository restaurantRepository;

  SearchRestaurantUseCaseImpl({
     this.restaurantRepository,
  });

  @override
  Future<List<RestaurantEntity>> getListRestaurantByName(
          String restaurantName) =>
      restaurantRepository.getListRestaurantByName(restaurantName);
}
