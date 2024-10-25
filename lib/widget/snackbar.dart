import 'package:flutter/material.dart';
import 'package:sims_ppob_andre/utils/text_roboto.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message, Color backgroundColor,
      Color textColor) {
    final snackBar = SnackBar(
      content: Roboto.regular(text: message, fontSize: 14, color: textColor),
      backgroundColor: backgroundColor,
      behavior: SnackBarBehavior.floating,
      action: SnackBarAction(
        label: 'x',
        textColor: textColor,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
