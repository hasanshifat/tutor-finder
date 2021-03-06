import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';

AppBar appBar(context, String title) {
  return AppBar(
    automaticallyImplyLeading: false,
    backgroundColor: colorwhite,
    backwardsCompatibility: false,
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: colorwhite, statusBarIconBrightness: Brightness.dark),
    leading: IconButton(
      icon: Icon(Icons.arrow_back, color: Colors.black),
      onPressed: () => Navigator.of(context).pop(),
    ),
    title: MytextMontserrat(
      text: title,
      fontsize: 15,
      color: colorblack87,
      //fontWeight: FontWeight.w500,
    ),
    //centerTitle: true,
  );
}
