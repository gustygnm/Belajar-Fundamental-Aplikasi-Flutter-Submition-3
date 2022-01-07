import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/presentation/bloc/search_restaurant/search_restaurant_bloc.dart';
import 'package:bobobox_restaurant/presentation/widget/custom_error.dart';
import 'package:bobobox_restaurant/presentation/widget/custom_loading.dart';
import 'package:bobobox_restaurant/presentation/widget/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bobobox_restaurant/data/remote/datasource/api_constant.dart';
import 'package:bobobox_restaurant/data/remote/datasource/remote_data_source.dart';
import 'package:bobobox_restaurant/data/remote/repository/restaurant_repository_impl.dart';
import 'package:bobobox_restaurant/domain/usecase/serch_restaurant_usecase.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SearchRestaurantScreen extends StatefulWidget {
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
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: cPrimary,
            elevation: 0.0,
            iconTheme: const IconThemeData(color: cWhite),
            title: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
                builder: (context, state) {
              return Center(
                child: Container(
                  decoration: BoxDecoration(
                      color: cWhite,
                      border: Border.all(
                        color: cWhite,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(30))),
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
                          BlocProvider.of<SearchRestaurantBloc>(context).add(
                              SearchRestaurant(searchText: value.toString()));
                        },
                      ))
                    ],
                  ),
                ),
              );
            }),
          ),
          body: BlocBuilder<SearchRestaurantBloc, SearchRestaurantState>(
            builder: (context, state) {
              if (state is SearchRestaurantLoadedState) {
                if (state.listRestaurant.isEmpty) {
                  return Center(
                    child: CustomErrorWidget(
                      errorImage: "assets/images/empty.png",
                      errorMessage: "Restaurant not found",
                    ),
                  );
                } else {
                  return Container(
                    padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                    decoration: const BoxDecoration(
                      color: cLightYellow,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.listRestaurant.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                            restaurantEntity: state.listRestaurant[index]);
                      },
                    ),
                  );
                }
              } else if (state is SearchRestaurantFailedState) {
                return CustomErrorWidget(
                  errorImage: "assets/images/warning.png",
                  errorMessage: "An error occurred please try again later",
                );
              } else {
                return const CustomLoadingProgress();
              }
            },
          ),
        ));
  }
}
