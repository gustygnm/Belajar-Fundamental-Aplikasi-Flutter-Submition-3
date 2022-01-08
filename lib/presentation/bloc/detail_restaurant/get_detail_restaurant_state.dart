part of 'get_detail_restaurant_bloc.dart';

abstract class GetDetailRestaurantState extends Equatable {
  const GetDetailRestaurantState();
}

class GetDetailRestaurantInitialState extends GetDetailRestaurantState {
  @override
  List<Object> get props => [];
}

class GetDetailRestaurantLoadingState extends GetDetailRestaurantState {
  @override
  List<Object> get props => [];
}

class GetDetailRestaurantLoadedState extends GetDetailRestaurantState {
  final DetailRestaurantEntity detailRestaurant;

  const GetDetailRestaurantLoadedState({this.detailRestaurant});

  @override
  List<Object> get props => [detailRestaurant];
}

class GetDetailRestaurantFailedState extends GetDetailRestaurantState {
  final String message;

  const GetDetailRestaurantFailedState({this.message});

  @override
  List<Object> get props => [message];
}
