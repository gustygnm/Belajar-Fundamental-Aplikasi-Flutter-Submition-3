import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class CustomError extends StatelessWidget {
  final String errorMessage;

   CustomError({
    @required this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomDialog(
        errorImage: "assets/images/warning.png",
        errorMessage: errorMessage,
      ),
    );
  }
}
