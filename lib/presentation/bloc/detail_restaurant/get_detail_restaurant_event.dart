part of 'get_detail_restaurant_bloc.dart';

abstract class GetDetailRestaurantEvent extends Equatable {
  const GetDetailRestaurantEvent();
}

class GetDetailRestaurant extends GetDetailRestaurantEvent {
  final String restaurantId;

  const GetDetailRestaurant({@required this.restaurantId});

  @override
  List<Object> get props => [restaurantId];
}
