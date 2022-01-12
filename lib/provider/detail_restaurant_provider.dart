import 'dart:async';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/data/model/detail_restaurant_model.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:flutter/material.dart';

class DetailRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;
  String id;

  DetailRestaurantProvider({@required this.apiService,@required this.id}) {
    _fetchAllData();
  }

  DetailRestaurantModel _detailResult;
  ResultState _state;
  String _message = '';

  String get message => _message;

  DetailRestaurantModel get result => _detailResult;

  ResultState get state => _state;

  Future<dynamic> _fetchAllData() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final detail = await apiService.detailRestaurant(id);
      if (detail.error == true) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Gagal memuat data restaurant';
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _detailResult = detail;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Koneksi internet terputus';
    }
  }
}
