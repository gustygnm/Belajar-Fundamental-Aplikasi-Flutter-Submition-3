import 'package:bobobox_restaurant/common/constants.dart';
import 'package:bobobox_restaurant/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 3, //mengatur waktu
      navigateAfterSeconds: HomePage(),
      title: Text('Mohon Menunggu...',
          style: GoogleFonts.poppins(
              fontSize: 15,
              color: cWhite,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.15)),
      image: Image.asset(
        'assets/images/logo.png',
        height: 80,
        width: 165,
      ),
      backgroundColor: cPrimary,
      photoSize: MediaQuery.of(context).size.width / 2,
      loaderColor: cWhite,
    );
  }
}
