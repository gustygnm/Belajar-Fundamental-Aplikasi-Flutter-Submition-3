import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/common/navigation.dart';
import 'package:bobobox_restaurant/data/db/database_helper.dart';
import 'package:bobobox_restaurant/provider/database_provider.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:bobobox_restaurant/widget/custom_empty.dart';
import 'package:bobobox_restaurant/widget/custom_error.dart';
import 'package:bobobox_restaurant/widget/custom_loading.dart';
import 'package:bobobox_restaurant/widget/restaurant_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorit-page';
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DatabaseProvider>(
      create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
      child: Scaffold(
          backgroundColor: cPrimary,
          appBar: AppBar(
            backgroundColor: cPrimary,
             leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: cWhite),
                onPressed: () => Navigation.back(),
              ),
            elevation: 0.0,
            iconTheme: const IconThemeData(color: cWhite),
            title: Expanded(
              child: Text(
                "Favorite",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: cWhite,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15),
              ),
            ),
          ),
          body: Container(child: Consumer<DatabaseProvider>(
            builder: (context, state, child) {
              if (state.state == ResultState.loading) {
                return Container(
                  margin: EdgeInsets.only(top: 16.w),
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
                    height: MediaQuery.of(context).size.height,
                    margin: const EdgeInsets.only(top: 16),
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
                      itemCount: state.favorites.length,
                      itemBuilder: (context, index) {
                        return RestaurantCard(
                            restaurantEntity: state.favorites[index]);
                      },
                    ),
                  ),
                );
              } else if (state.state == ResultState.noData) {
                return Container(
                    margin: const EdgeInsets.only(top: 16),
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
                    child: const CustomEmpty());
              }
            },
          ))),
    );
  }
}
