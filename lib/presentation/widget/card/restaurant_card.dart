import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bobobox_restaurant/domain/entity/restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/router/restaurant_list_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RestaurantCard extends StatelessWidget {
  final RestaurantEntity restaurantEntity;
  final RestaurantListRouter _restaurantListRouter = RestaurantListRouterImpl();

  RestaurantCard({ this.restaurantEntity});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(6.w, 6.w, 6.w, 6.w),
      child: InkWell(
        onTap: () => _restaurantListRouter.goToDetailListRestaurant(
            context, restaurantEntity),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                restaurantEntity.pictureId,
                height: 80.w,
                width: 115.w,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.w, 0.w, 16.w, 0.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      restaurantEntity.name,
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: cDarkGrey,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.16),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 0.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on,
                            color: cGrey,
                            size: 14.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Text(restaurantEntity.city,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: cDarkGrey,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.15)),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 8.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.amber,
                            size: 14.w,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 4.w),
                            child: Text(restaurantEntity.rating,
                                style: GoogleFonts.poppins(
                                    fontSize: 12,
                                    color: cDarkGrey,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 0.15)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
