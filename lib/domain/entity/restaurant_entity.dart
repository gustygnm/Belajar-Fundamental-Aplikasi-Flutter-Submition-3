import 'package:equatable/equatable.dart';

class RestaurantListEntity extends Equatable {
  final List<RestaurantEntity> restaurants;

  const RestaurantListEntity({
    this.restaurants,
  });

  @override
  List<Object> get props => [
        restaurants,
      ];
}

class RestaurantEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final String rating;
  final MenusEntity menus;

  const RestaurantEntity(
      {this.id,
      this.name,
      this.description,
      this.pictureId,
      this.city,
      this.address,
      this.rating,
      this.menus});

  @override
  List<Object> get props => [
        id,
        name,
        description,
        pictureId,
        city,
        address,
        rating,
        menus,
      ];
}

class MenusEntity extends Equatable {
  final List<FoodsEntity> foods;
  final List<DrinksEntity> drinks;

  const MenusEntity({
    this.foods,
    this.drinks,
  });

  @override
  List<Object> get props => [
        foods,
        drinks,
      ];
}

class FoodsEntity extends Equatable {
  final String name;
  final String image;
  final String price;

  const FoodsEntity({
    this.name,
    this.image,
    this.price,
  });

  @override
  List<Object> get props => [
        name,
        image,
        price,
      ];
}

class DrinksEntity extends Equatable {
  final String name;
  final String image;
  final String price;

  const DrinksEntity({
    this.name,
    this.image,
    this.price,
  });

  @override
  List<Object> get props => [
        name,
        image,
        price,
      ];
}