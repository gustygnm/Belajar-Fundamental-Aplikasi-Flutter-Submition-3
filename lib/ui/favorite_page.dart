import 'package:bobobox_restaurant/common/constants.dart';
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
  static const routeName = '/favorite-page';

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
                borderRadius: const BorderRadius.all(Radius.circular(30))),
            height: 45.0,
            child: Row(
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(right: 8.0, left: 12.0),
                  child: Icon(
                    Icons.search,
                    color: cGrey,
                    size: 20.0,
                  ),
                ),
                Expanded(
                  child: Text(
                    "Favorite",
                    style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: cWhite,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.15),
                  ),
                )
              ],
            ),
          )),
        ),
        body: Expanded(
          child: _buildList(context),
        ));
  }

  Widget _buildList(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        if (provider.state == ResultState.hasData) {
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
                itemCount: provider.favorites.length,
                itemBuilder: (context, index) {
                  return RestaurantCard(
                      restaurantEntity: provider.favorites[index]);
                },
              ),
            ),
          );
        }
        if (provider.state == ResultState.loading) {
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
        } else if (provider.state == ResultState.noData) {
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
        } else if (provider.state == ResultState.error) {
          return Container(
              margin: const EdgeInsets.only(top: 16),
              decoration: const BoxDecoration(
                color: cWhite,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(32.0),
                  topRight: Radius.circular(32.0),
                ),
              ),
              child: CustomError(errorMessage: provider.message.toString()));
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
    );
  }
}
