import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/data/remote/datasource/api_constant.dart';
import 'package:bobobox_restaurant/data/remote/datasource/remote_data_source.dart';
import 'package:bobobox_restaurant/data/remote/repository/restaurant_repository_impl.dart';
import 'package:bobobox_restaurant/presentation/bloc/search_restaurant/search_restaurant_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bobobox_restaurant/domain/usecase/serch_restaurant_usecase.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bobobox_restaurant/presentation/widget/restaurant_card.dart';

class SearchRestaurantScreen extends StatefulWidget {
  const SearchRestaurantScreen({Key key}) : super(key: key);

  @override
  _SearchRestaurantScreenState createState() => _SearchRestaurantScreenState();
}

class _SearchRestaurantScreenState extends State<SearchRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchRestaurantBloc(
        searchRestaurantUseCase: SearchRestaurantUseCaseImpl(
          restaurantRepository: RestaurantRepositoryIml(
            remoteDataSource: RemoteDataSourceImpl(
              dio: Dio(
                BaseOptions(baseUrl: ApiConstant.baseUrl),
              ),
            ),
          ),
        ),
      )..add(
          SearchRestaurant(searchText: ""),
        ),
      child: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
        builder: (context, state) {
          if (state is SearchRestaurantLoadedState) {
            return Scaffold(
              appBar: AppBar(
                  backgroundColor: cPrimary,
                  elevation: 0.0,
                  iconTheme: const IconThemeData(color: cWhite),
                  title: Center(
                    child: Container(
                      decoration: BoxDecoration(
                          color: cWhite,
                          border: Border.all(
                            color: cWhite,
                          ),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(30))),
                      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                      height: 45.0,
                      child: Row(
                        children: <Widget>[
                          const Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.search,
                              color: cGrey,
                              size: 20.0,
                            ),
                          ),
                          Expanded(
                              child: TextField(
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Pencarian',
                                hintStyle: TextStyle(color: cGrey)),
                            onChanged: (value) {
                              BlocProvider.of<SearchRestaurantBloc>(context)
                                  .add(SearchRestaurant(
                                      searchText: value.toString()));
                            },
                          ))
                        ],
                      ),
                    ),
                  )),
              body: Container(
                color: cPrimary,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.only(top: 8),
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32.0),
                        topRight: Radius.circular(32.0),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: state.listRestaurant.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                            restaurantEntity: state.listRestaurant[index]);
                      },
                    ),
                  ),
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
