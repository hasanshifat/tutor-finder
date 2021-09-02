import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';

AppBar appBar(context, String title) {
  return AppBar(
    backgroundColor: colorgreylite[100],
    backwardsCompatibility: false,
    systemOverlayStyle:
        SystemUiOverlayStyle(statusBarColor: colorgreylite[100]),
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: MytextMontserrat(
      text: title,
      fontsize: 20,
      color: colorblack87,
      fontWeight: FontWeight.w500,
    ),
    centerTitle: true,
  );
}
