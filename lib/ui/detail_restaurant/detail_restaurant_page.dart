import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/data/db/database_helper.dart';
import 'package:bobobox_restaurant/data/model/detail_restaurant_model.dart';
import 'package:bobobox_restaurant/data/model/list_restaurant_model.dart'
    as list;
import 'package:bobobox_restaurant/provider/database_provider.dart';
import 'package:bobobox_restaurant/provider/detail_restaurant_provider.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:bobobox_restaurant/widget/custom_empty.dart';
import 'package:bobobox_restaurant/widget/custom_error.dart';
import 'package:bobobox_restaurant/widget/custom_loading.dart';
import 'package:bobobox_restaurant/widget/menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

part 'description_page.dart';

class DetailRestaurantPage extends StatefulWidget {
  final String restaurantId;
  final list.Restaurant restaurant;
  final String restaurantImage;

  const DetailRestaurantPage({
    Key key,
    @required this.restaurantId,
    @required this.restaurant,
    @required this.restaurantImage,
  }) : super(key: key);

  @override
  State<DetailRestaurantPage> createState() => _DetailRestaurantPageState();
}

class _DetailRestaurantPageState extends State<DetailRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              backgroundColor: cPrimary,
              pinned: true,
              actions: [
                ChangeNotifierProvider<DatabaseProvider>(
                  create: (_) =>
                      DatabaseProvider(databaseHelper: DatabaseHelper()),
                  child: Consumer<DatabaseProvider>(
                    builder: (context, provider, child) {
                      return FutureBuilder<bool>(
                        future: provider.isFavorite(widget.restaurantId),
                        builder: (context, snapshot) {
                          var isFavorite = snapshot.data ?? false;
                          return isFavorite
                              ? MenuWidget(
                                  iconImg: Icons.favorite,
                                  iconColor: cWhite,
                                  conBackColor: Colors.transparent,
                                  onBtnTap: () => provider
                                      .removeFavorite(widget.restaurant.id),
                                )
                              : MenuWidget(
                                  iconImg: Icons.favorite_border,
                                  iconColor: cWhite,
                                  conBackColor: Colors.transparent,
                                  onBtnTap: () =>
                                      provider.addFavorite(widget.restaurant),
                                );
                        },
                      );
                    },
                  ),
                ),
              ],
              expandedHeight: 200.w,
              iconTheme: const IconThemeData(color: cWhite),
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(children: [
                  OverflowBox(
                    maxHeight: double.infinity,
                    maxWidth: double.infinity,
                    alignment: Alignment.center,
                    child: Image.network(
                      ApiService.baseUrlPictureMedium + widget.restaurantImage,
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
        body: ChangeNotifierProvider<DetailRestaurantProvider>(
            create: (_) => DetailRestaurantProvider(
                apiService: ApiService(), id: widget.restaurantId),
            child: Consumer<DetailRestaurantProvider>(
                builder: (context, state, _) {
              if (state.state == ResultState.loading) {
                return const Center(
                  child: CustomLoadingProgress(),
                );
              } else if (state.state == ResultState.hasData) {
                return DescriptionPage(
                  detailRestaurantEntity: state.result.restaurant,
                  id: state.result.restaurant.id,
                );
              } else if (state.state == ResultState.noData) {
                return const CustomEmpty();
              } else if (state.state == ResultState.error) {
                return CustomError(errorMessage: state.message.toString());
              } else {
                return CustomError(errorMessage: state.message.toString());
              }
            })),
      ),
    );
  }
}
