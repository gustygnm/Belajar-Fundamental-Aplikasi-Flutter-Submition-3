import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'description_screen.dart';

class DetailRestaurantScreen extends StatelessWidget {
  final RestaurantEntity restaurantEntity;

  DetailRestaurantScreen({
     this.restaurantEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: cPrimary,
              pinned: true,
              expandedHeight: 200.w,
              iconTheme: const IconThemeData(color: cWhite),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  OverflowBox(
                    maxHeight: double.infinity,
                    maxWidth: double.infinity,
                    alignment: Alignment.center,
                    child: Image.network(
                      restaurantEntity.pictureId,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    color: cBlackTrans,
                  ),
                ]),
              ),
              centerTitle: false,
              title: Text(
                "Detail",
                style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: cWhite,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.15),
              ),
            ),
          ];
        },
        body: DescriptionScreen(restaurantEntity: restaurantEntity),
      ),
    );
  }
}
