import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLoadingProgress extends StatelessWidget {
  const CustomLoadingProgress({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Image.asset(
            "assets/images/loading.png",
            width: 120.w,
            height: 100.w,
            fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          height: 24,
        ),
        const CircularProgressIndicator(
          color: cPrimary,
        ),
      ],
    );
  }
}
