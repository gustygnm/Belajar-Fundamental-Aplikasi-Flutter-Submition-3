import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/data/remote/datasource/api_constant.dart';
import 'package:bobobox_restaurant/data/remote/datasource/remote_data_source.dart';
import 'package:bobobox_restaurant/data/remote/repository/restaurant_repository_impl.dart';
import 'package:bobobox_restaurant/presentation/bloc/restaurant_list/get_list_restaurant_bloc.dart';
import 'package:bobobox_restaurant/presentation/widget/custom_loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bobobox_restaurant/domain/router/restaurant_list_router.dart';
import 'package:bobobox_restaurant/domain/usecase/get_list_restaurant_usecase.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bobobox_restaurant/presentation/widget/restaurant_card.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final RestaurantListRouter _restaurantListRouter = RestaurantListRouterImpl();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetListRestaurantBloc(
        getListRestaurantUseCase: GetListRestaurantUseCaseImpl(
          restaurantRepository: RestaurantRepositoryIml(
            remoteDataSource: RemoteDataSourceImpl(
              dio: Dio(
                BaseOptions(
                  baseUrl: ApiConstant.baseUrl,
                ),
              ),
            ),
          ),
        ),
      )..add(GetListRestaurant()),
      child: Scaffold(
        backgroundColor: cPrimary,
        appBar: AppBar(
          backgroundColor: cPrimary,
          elevation: 0.0,
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("Bobobox",
                  style: GoogleFonts.poppins(
                      fontSize: 18,
                      color: cWhite,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.15)),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text("Restaurant",
                    style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: cWhite,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 0.15)),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () =>
                  _restaurantListRouter.goToSearchRestaurant(context),
              icon: const Icon(
                Icons.search,
                color: cWhite,
              ),
            ),
          ],
        ),
        body: BlocBuilder<GetListRestaurantBloc, GetListRestaurantState>(
          builder: (context, state) {
            if (state is GetListRestaurantLoadedState) {
              return SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(top: 16.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: const BoxDecoration(
                      color: cWhite,
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
                        })),
              );
            } else {
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: const BoxDecoration(
                  color: cLightYellow,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40.0),
                    topRight: Radius.circular(40.0),
                  ),
                ),
                child: const Center(
                  child: CustomLoadingProgress(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
