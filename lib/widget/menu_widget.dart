import 'package:flutter/material.dart';

class MenuWidget extends StatelessWidget {
  final IconData iconImg;
  final Color iconColor;
  final Color conBackColor;
  final Key keyText;
  final Function() onBtnTap;

   const MenuWidget(
      {Key key, this.keyText,
      @required this.iconImg,
      @required this.iconColor,
      this.conBackColor,
      @required this.onBtnTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: keyText,
      onTap: () {
        onBtnTap();
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Center(
          child: Icon(
            iconImg,
            color: iconColor,
          ),
        ),
      ),
    );
  }
}
