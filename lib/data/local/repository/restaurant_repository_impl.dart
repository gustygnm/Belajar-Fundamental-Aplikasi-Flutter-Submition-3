import 'package:bobobox_restaurant/data/local/datasource/local_data_source.dart';
import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/repository/restaurant_repository.dart';

class RestaurantRepositoryIml extends RestaurantRepository {
  LocalDataSource localDataSource;

  RestaurantRepositoryIml({this.localDataSource});

  @override
  Future<List<RestaurantEntity>> getListRestaurant() async {
    List<RestaurantEntity> _listRestaurant = [];
    var _restaurantData = await localDataSource.getRestaurantList();
    for (var restaurant in _restaurantData.restaurants) {
      List<FoodsEntity> _foodList = [];
      for (var food in restaurant.menus.foods) {
        var foodEntity =
            FoodsEntity(name: food.name, image: food.image, price: food.price);
        _foodList.add(foodEntity);
      }

      List<DrinksEntity> _drinkList = [];
      for (var drink in restaurant.menus.drinks) {
        var drinkEntity = DrinksEntity(
            name: drink.name, image: drink.image, price: drink.price);
        _drinkList.add(drinkEntity);
      }

      var _restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: restaurant.pictureId,
          city: restaurant.city,
          address: restaurant.address,
          rating: restaurant.rating,
          menus: MenusEntity(
            foods: _foodList,
            drinks: _drinkList,
          ));
      _listRestaurant.add(_restaurantEntity);
    }

    return _listRestaurant;
  }

  @override
  Future<List<RestaurantEntity>> getListRestaurantByName(
      String restaurantName) async {
    List<RestaurantEntity> listRestaurant = [];
    List<RestaurantEntity> filterListRestaurant = [];
    var restaurantData = await localDataSource.getRestaurantList();
    for (var restaurant in restaurantData.restaurants) {
      List<FoodsEntity> foodList = [];
      for (var food in restaurant.menus.foods) {
        var foodEntity =
            FoodsEntity(name: food.name, image: food.image, price: food.price);
        foodList.add(foodEntity);
      }

      List<DrinksEntity> drinkList = [];
      for (var drink in restaurant.menus.drinks) {
        var drinkEntity = DrinksEntity(
            name: drink.name, image: drink.image, price: drink.price);
        drinkList.add(drinkEntity);
      }

      var restaurantEntity = RestaurantEntity(
          id: restaurant.id,
          name: restaurant.name,
          description: restaurant.description,
          pictureId: restaurant.pictureId,
          city: restaurant.city,
          address: restaurant.address,
          rating: restaurant.rating,
          menus: MenusEntity(
            foods: foodList,
            drinks: drinkList,
          ));
      listRestaurant.add(restaurantEntity);
    }
    filterListRestaurant = listRestaurant
        .where((food) =>
            food.name.toLowerCase().contains(restaurantName.toLowerCase()))
        .toList();
    return filterListRestaurant;
  }
}
