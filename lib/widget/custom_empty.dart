import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class CustomEmpty extends StatelessWidget {
  const CustomEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CustomDialog(
        errorImage: "assets/images/empty.png",
        errorMessage: "Restaurant tidak ditemukan!",
      ),
    );
  }
}
