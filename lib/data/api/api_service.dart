import 'dart:convert';
import 'package:bobobox_restaurant/data/model/detail_restaurant_model.dart';
import 'package:bobobox_restaurant/data/model/list_restaurant_model.dart';
import 'package:bobobox_restaurant/data/model/search_restaurant_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';
  static const String listRestaurantUrl = '/list';
  static const String _detailRestaurant = '/detail/';
  static const String _searchRestaurant = '/search?q=';
  static const String baseUrlPictureMedium = 'https://restaurant-api.dicoding.dev/images/medium/';

  Future<ListRestaurantModel> listRestaurant() async {
    final response = await http.get(Uri.parse(baseUrl + listRestaurantUrl));
    if (response.statusCode == 200) {
      return ListRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<DetailRestaurantModel> detailRestaurant(String id) async {
    final response =
        await http.get(Uri.parse(baseUrl + _detailRestaurant + id));
    if (response.statusCode == 200) {
      return DetailRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<SearchRestaurantModel> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse(baseUrl + _searchRestaurant + query));
    if (response.statusCode == 200) {
      return SearchRestaurantModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load data');
    }
  }
}
