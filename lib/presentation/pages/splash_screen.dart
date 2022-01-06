import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bobobox_restaurant/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()
        ..add(
          LoadSplashScreenEvent(),
        ),
      child: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashLoadedState) {
            Future.delayed(const Duration(seconds: 2)).then(
              (_) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(),
                ),
              ),
            );
          }
        },
        child: BlocBuilder<SplashBloc, SplashState>(builder: (context, state) {
          return Scaffold(
            backgroundColor: cPrimary,
            body: Center(
              child: Image.asset(
                "assets/images/logo.png",
                width: 130.w,
                height: 64.w,
                fit: BoxFit.fill,
              ),
            ),
          );
        }),
      ),
    );
  }
}
