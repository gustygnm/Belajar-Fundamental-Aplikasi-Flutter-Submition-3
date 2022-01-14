part of 'detail_restaurant_page.dart';

class DescriptionPage extends StatelessWidget {
  final Restaurant detailRestaurantEntity;
  String id;

  DescriptionPage({Key key, 
    this.detailRestaurantEntity, this.id
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<DetailRestaurantProvider>(
      create: (_) => DetailRestaurantProvider(apiService: ApiService(),id: id),
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: ListView(
          children: [
            Text(
              detailRestaurantEntity.name,
              style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.15),
            ),
            SizedBox(
              height: 8.w,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.amber,
                  size: 16.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(detailRestaurantEntity.rating.toString(),
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: cDarkGrey,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.15)),
                ),
                SizedBox(
                  width: 16.w,
                ),
                Icon(
                  Icons.location_on,
                  color: cGrey,
                  size: 16.w,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 4.w),
                  child: Text(
                      detailRestaurantEntity.address +
                          ", " +
                          detailRestaurantEntity.city,
                      style: GoogleFonts.poppins(
                          fontSize: 13,
                          color: cDarkGrey,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.15)),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 16.w),
              child: Text(
                "Description",
                style: GoogleFonts.poppins(
                    fontSize: 19,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.15),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.w),
              child: Text(
                detailRestaurantEntity.description,
                style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: cGrey,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 0.15),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Foods',
              style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
            ),
            SizedBox(height: 8.w),
            SizedBox(
              height: 70.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: detailRestaurantEntity.menus.foods.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: Container(
                        color: cPrimary,
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Center(
                              child: Text(
                                detailRestaurantEntity.menus.foods[index].name,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: cWhite,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),

                    // Text(
                    //   restaurantEntity.menus.drinks[index].name,
                    //   style: TextStyle(
                    //       fontSize: 20.sp, color: CustomColors.darkGrey),
                    // ),
                  );
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Drinks',
              style: GoogleFonts.poppins(
                  fontSize: 19,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
            ),
            SizedBox(height: 8.w),
            SizedBox(
              height: 70.w,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: detailRestaurantEntity.menus.drinks.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 16.w),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.all(
                        Radius.circular(8),
                      ),
                      child: Container(
                        color: cPrimary,
                        child: Stack(children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: Center(
                              child: Text(
                                detailRestaurantEntity.menus.drinks[index].name,
                                style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: cWhite,
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.15),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
