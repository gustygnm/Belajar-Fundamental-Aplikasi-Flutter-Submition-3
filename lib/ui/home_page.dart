import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/domain/router/restaurant_list_router.dart';
import 'package:bobobox_restaurant/widget/custom_empty.dart';
import 'package:bobobox_restaurant/widget/custom_error.dart';
import 'package:bobobox_restaurant/widget/custom_loading.dart';
import 'package:bobobox_restaurant/provider/list_restaurant_provider.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bobobox_restaurant/widget/restaurant_card.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final RestaurantListRouter _restaurantListRouter = RestaurantListRouterImpl();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ListRestaurantProvider>(
      create: (_) => ListRestaurantProvider(apiService: ApiService()),
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
                  _restaurantListRouter.goToFavoritRestaurant(context),
              icon: const Icon(
                Icons.favorite,
                color: cWhite,
              ),
            ),
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
        body: Consumer<ListRestaurantProvider>(
          builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return Container(
                margin: EdgeInsets.only(top: 16.w),
                padding: EdgeInsets.all(16.w),
                decoration: const BoxDecoration(
                  color: cWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: const Center(
                  child: CustomLoadingProgress(),
                ),
              );
            } else if (state.state == ResultState.hasData) {
              return SingleChildScrollView(
                child: Container(
                    margin: EdgeInsets.only(top: 16.w),
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
                        itemCount: state.result.restaurants.length,
                        itemBuilder: (context, index) {
                          return RestaurantCard(
                              restaurantEntity:
                                  state.result.restaurants[index]);
                        })),
              );
            } else if (state.state == ResultState.noData) {
              return Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(16.w),
                  decoration: const BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: const CustomEmpty());
            } else if (state.state == ResultState.error) {
              return Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(16.w),
                  decoration: const BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: CustomError(errorMessage: state.message.toString()));
            } else {
              return Container(
                  margin: const EdgeInsets.only(top: 16),
                  padding: EdgeInsets.all(16.w),
                  decoration: const BoxDecoration(
                    color: cWhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.0),
                      topRight: Radius.circular(32.0),
                    ),
                  ),
                  child: CustomError(errorMessage: state.message.toString()));
            }
          },
        ),
      ),
    );
  }
}
