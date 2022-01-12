import 'dart:async';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/data/model/search_restaurant_model.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:flutter/material.dart';

class SearchRestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  SearchRestaurantProvider({@required this.apiService});

  SearchRestaurantModel _detailResult;
  ResultState _state;
  String _message = '';

  String get message => _message;

  SearchRestaurantModel get result => _detailResult;

  ResultState get state => _state;

  Future<dynamic> fetchAllData({String query}) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        notifyListeners();
        final detail = await apiService.searchRestaurant(query);
        if (detail.error == true) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Gagal memuat data restaurant';
        } else {
          try {
            if (detail.founded == 0) {
              _state = ResultState.noData;
              notifyListeners();
              return _message = 'Gagal memuat data restaurant';
            } else {
              _state = ResultState.hasData;

              notifyListeners();
              return _detailResult = detail;
            }
          } catch (e) {
            _state = ResultState.noData;
            notifyListeners();
            return _message = 'Gagal memuat data restaurant';
          }
        }
      } else {
        _state = ResultState.error;
        notifyListeners();
        return _message = 'Masukkan kata pencarian';
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Koneksi internet terputus';
    }
  }
}
