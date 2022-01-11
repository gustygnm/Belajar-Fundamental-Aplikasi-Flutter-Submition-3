import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDialog extends StatelessWidget {
  final String errorMessage;
  final String errorImage;

  CustomDialog({
    @required this.errorMessage,
    @required this.errorImage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          errorImage,
          width: 200.w,
          height: 200.w,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.w, left: 32.w, right: 32.w),
          child: Text(
            errorMessage,
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 15,
                color: cDarkGrey,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.15),
          ),
        ),
      ],
    );
  }
}
