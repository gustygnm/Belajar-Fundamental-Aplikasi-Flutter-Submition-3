import 'package:bobobox_restaurant/common/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String> onFieldSubmitted;
  final FocusNode focusNode;

  const CustomTextField({Key key, 
    @required this.controller,
    @required this.hint,
    @required this.keyboardType,
    this.maxLines = 1,
    this.onFieldSubmitted,
    this.focusNode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cWhite,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 0.5),
            blurRadius: 1.0,
          ),
        ],
      ),
      margin: EdgeInsets.fromLTRB(16.w, 16.w, 16.w, 0.w),
      child: TextFormField(
        onFieldSubmitted: onFieldSubmitted,
        controller: controller,
        focusNode: focusNode,
        maxLines: maxLines,
        keyboardType: keyboardType,
        style: const TextStyle(color: cDarkGrey),
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(8.w, 0.w, 8.w, 0.w),
            border: InputBorder.none,
            hintText: hint,
            hintStyle: const TextStyle(color: cGrey)),
      ),
    );
  }
}
