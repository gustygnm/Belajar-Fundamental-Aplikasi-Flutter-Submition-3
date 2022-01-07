import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final double borderRadius;

  CustomButton({
    @required this.text,
    @required this.onTap,
    this.borderRadius = 0.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1.sw,
      height: 40.w,
      decoration: BoxDecoration(
          color: cPrimary, borderRadius: BorderRadius.circular(borderRadius)),
      child: InkWell(
        onTap: onTap,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 20.sp, color: cWhite, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
