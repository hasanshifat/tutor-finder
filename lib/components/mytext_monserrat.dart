import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mytext extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;
  const Mytext({
    this.text,
    this.fontsize,
    this.color,
    this.fontWeight,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: TextOverflow.ellipsis,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              color: color,
              fontSize: fontsize,
              letterSpacing: 1,
              fontWeight: fontWeight,
              height: 1,
              decoration: TextDecoration.none),
        ));
  }
}
