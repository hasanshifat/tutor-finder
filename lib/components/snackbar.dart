import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/mytext2.dart';

class CustomSnakbar {
  final String msg;
  const CustomSnakbar({@required this.msg});

  static snackbar(BuildContext context, String msg) async {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      elevation: 0,
      backgroundColor: Colors.red[600],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      behavior: SnackBarBehavior.floating,
      content: Mytext2(
        text: '$msg',
        color: colorwhite,
        fontWeight: FontWeight.w500,
        fontsize: 12,
      ),
      duration: Duration(seconds: 3),
    ));
  }
}
