import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomErrorWidget extends StatelessWidget {
  final String errorMessage;
  final String errorImage;

  CustomErrorWidget({
    @required this.errorMessage,
    @required this.errorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          errorImage,
          width: 150.w,
          height: 150.w,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.w, left: 32.w, right: 32.w),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
           style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: cDarkGrey,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.15),
          ),
        ),
      ],
    );
  }
}
