import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/common/navigation.dart';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/provider/search_restaurant_provider.dart';
import 'package:bobobox_restaurant/utils/result_state.dart';
import 'package:bobobox_restaurant/widget/custom_empty.dart';
import 'package:bobobox_restaurant/widget/custom_error.dart';
import 'package:bobobox_restaurant/widget/custom_loading.dart';
import 'package:bobobox_restaurant/widget/restaurant_card_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class SearchRestaurantPage extends StatefulWidget {
  static const routeName = '/search-page';
  @override
  _SearchRestaurantPageState createState() => _SearchRestaurantPageState();
}

class _SearchRestaurantPageState extends State<SearchRestaurantPage> {
  @override
  Widget build(BuildContext context) {
    String queries = ' ';
    final TextEditingController _controller = TextEditingController();

    return ChangeNotifierProvider<SearchRestaurantProvider>(
      create: (_) => SearchRestaurantProvider(apiService: ApiService()),
      child: Scaffold(
        backgroundColor: cPrimary,
        appBar: AppBar(
          backgroundColor: cPrimary,
          elevation: 0.0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: cWhite),
            onPressed: () => Navigation.back(),
          ),
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
                Consumer<SearchRestaurantProvider>(
                    builder: (context, state, _) {
                  return Expanded(
                      child: TextField(
                    controller: _controller,
                    onChanged: (String value) {
                      state.fetchAllData(query: value);
                    },
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Pencarian',
                        hintStyle: TextStyle(color: cGrey)),
                  ));
                }),
              ],
            ),
          )),
        ),
        body: Consumer<SearchRestaurantProvider>(
          builder: (context, state, _) {
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
              state.apiService.searchRestaurant(queries);
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
                    itemCount: state.result.restaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantCardSearch(
                          restaurantEntity: state.result.restaurants[index]);
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
                  child: const CustomError(
                      errorMessage: 'Masukkan kata pencarian'));
            }
          },
        ),
      ),
    );
  }
}
