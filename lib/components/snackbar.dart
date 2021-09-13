import 'package:flutter/material.dart';
import 'package:tutor_finder/components/mytext2.dart';

class CustomSnakbar {
  final String msg;
  const CustomSnakbar({@required this.msg});

  static snackbar(BuildContext context, String msg,Color bgcolor,Color textColor) async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: bgcolor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      behavior: SnackBarBehavior.floating,
      content: Mytext2(
        text: '$msg',
        color: textColor,
        fontWeight: FontWeight.w500,
        fontsize: 12,
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
