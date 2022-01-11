import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/data/model/detail_restaurant_model.dart';
import 'package:bobobox_restaurant/provider/detail_restaurant_provider.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:bobobox_restaurant/widget/custom_empty.dart';
import 'package:bobobox_restaurant/widget/custom_error.dart';
import 'package:bobobox_restaurant/widget/custom_loading.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

part 'description_page.dart';

class DetailRestaurantPage extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;

  DetailRestaurantPage({
    @required this.restaurantId,
    @required this.restaurantName,
    @required this.restaurantImage,
  });

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(
          apiService: ApiService(), id: widget.restaurantId),
      child: Scaffold(
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
                        ApiService.baseUrlPictureMedium +
                            widget.restaurantImage,
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
          body:
              Consumer<DetailRestaurantProvider>(builder: (context, state, _) {
            if (state.state == ResultState.Loading) {
              return const Center(
                child: CustomLoadingProgress(),
              );
            } else if (state.state == ResultState.HasData) {
              return DescriptionPage(
                detailRestaurantEntity: state.result.restaurant,
                id: state.result.restaurant.id,
              );
            } else if (state.state == ResultState.NoData) {
              return const CustomEmpty();
            } else if (state.state == ResultState.Error) {
              return  CustomError(errorMessage: state.message.toString());
            } else {
              return  CustomError(errorMessage: state.message.toString());
            }
          }),
        ),
      ),
    );
  }
}
