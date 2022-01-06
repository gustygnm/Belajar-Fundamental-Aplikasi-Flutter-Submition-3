import 'package:equatable/equatable.dart';

class RestaurantListModel extends Equatable {
  final List<RestaurantModel> restaurants;

  const RestaurantListModel({
    this.restaurants,
  });

  @override
  List<Object> get props => [
        restaurants,
      ];

  factory RestaurantListModel.fromJson(Map<String, dynamic> json) =>
      RestaurantListModel(
        restaurants: List<RestaurantModel>.from(
          json['restaurants'].map(
            (restaurant) => RestaurantModel.fromJson(
              restaurant,
            ),
          ),
        ),
      );
}

class RestaurantModel extends Equatable {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final String rating;
  final MenusModel menus;

  const RestaurantModel({
    this.id,
    this.name,
    this.description,
    this.pictureId,
    this.city,
    this.address,
    this.rating,
    this.menus,
  });

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

  factory RestaurantModel.fromJson(Map<String, dynamic> json) =>
      RestaurantModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
        pictureId: json['pictureId'],
        city: json['city'],
        address: json['address'],
        rating: json['rating'].toString(),
        menus: MenusModel.fromJson(
          json['menus'],
        ),
      );
}

class MenusModel extends Equatable {
  final List<FoodsModel> foods;
  final List<DrinksModel> drinks;

  const MenusModel({this.foods, this.drinks});

  @override
  List<Object> get props => [foods, drinks];

  factory MenusModel.fromJson(Map<String, dynamic> json) => MenusModel(
        foods: List<FoodsModel>.from(
          json['foods'].map(
            (food) => FoodsModel.fromJson(
              food,
            ),
          ),
        ),
        drinks: List<DrinksModel>.from(
          json['drinks'].map(
            (drink) => DrinksModel.fromJson(
              drink,
            ),
          ),
        ),
      );
}

class FoodsModel extends Equatable {
  final String name;
  final String image;
  final String price;

  const FoodsModel({
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

  factory FoodsModel.fromJson(Map<String, dynamic> json) => FoodsModel(
        name: json['name'],
        image: json['image'],
        price: json['price'],
      );
}

class DrinksModel extends Equatable {
  final String name;
  final String image;
  final String price;

  const DrinksModel({
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

  factory DrinksModel.fromJson(Map<String, dynamic> json) => DrinksModel(
        name: json['name'],
        image: json['image'],
        price: json['price'],
      );
}
