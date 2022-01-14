import 'dart:async';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/data/model/list_restaurant_model.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:flutter/material.dart';

class ListRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  ListRestaurantProvider({this.apiService}) {
    _fetchAllData();
  }

  ListRestaurantModel _listResult;
  ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurantModel get result => _listResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final list = await apiService.listRestaurant();
      if (list.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Gagal memuat data restaurant';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _listResult = list;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Koneksi internet terputus';
    }
  }
}
