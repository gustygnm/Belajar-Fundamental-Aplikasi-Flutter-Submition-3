import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/data/remote/datasource/api_constant.dart';
import 'package:bobobox_restaurant/data/remote/datasource/remote_data_source.dart';
import 'package:bobobox_restaurant/data/remote/repository/restaurant_repository_impl.dart';
import 'package:bobobox_restaurant/domain/entity/detail_restaurant_entity.dart';
import 'package:bobobox_restaurant/domain/usecase/get_restaurant_detail_usecase.dart';
import 'package:bobobox_restaurant/presentation/bloc/detail_restaurant_bloc/get_detail_restaurant_bloc.dart';
import 'package:bobobox_restaurant/presentation/widget/custom_error.dart';
import 'package:bobobox_restaurant/presentation/widget/custom_loading.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'description_screen.dart';

class DetailRestaurantScreen extends StatefulWidget {
  final String restaurantId;
  final String restaurantName;
  final String restaurantImage;

  DetailRestaurantScreen({
    @required this.restaurantId,
    @required this.restaurantName,
    @required this.restaurantImage,
  });

  @override
  State<DetailRestaurantScreen> createState() => _DetailRestaurantScreenState();
}

class _DetailRestaurantScreenState extends State<DetailRestaurantScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetDetailRestaurantBloc(
          getRestaurantDetailUseCase: GetRestaurantDetailUseCaseImpl(
              restaurantRepository: RestaurantRepositoryIml(
                  remoteDataSource: RemoteDataSourceImpl(
                      dio: Dio(BaseOptions(baseUrl: ApiConstant.baseUrl))))))
        ..add(GetDetailRestaurant(restaurantId: widget.restaurantId)),
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
          body: BlocBuilder<GetDetailRestaurantBloc, GetDetailRestaurantState>(
              builder: (context, state) {
            if (state is GetDetailRestaurantLoadedState) {
              return DescriptionScreen(
                detailRestaurantEntity: state.detailRestaurant,
              );
            } else if (state is GetDetailRestaurantFailedState) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: cPrimary,
                  iconTheme: const IconThemeData(color: cWhite),
                ),
                body: CustomErrorWidget(
                  errorImage: 'assets/images/warning.png',
                  errorMessage: "Terjadi kesalahan. Silahkan coba lagi!",
                ),
              );
            } else {
              return const CustomLoadingProgress();
            }
          }),
        ),
      ),
    );
  }
}
