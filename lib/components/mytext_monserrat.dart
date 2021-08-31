import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MytextMontserrat extends StatelessWidget {
  final String text;
  final double fontsize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextOverflow overflow;
  const MytextMontserrat({
    this.text,
    this.fontsize,
    this.color,
    this.fontWeight,
    this.overflow,
    this.textAlign,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text,
        overflow: overflow,
        textAlign: textAlign,
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              color: color,
              fontSize: fontsize,
              letterSpacing: 1,
              fontWeight: fontWeight,
              height: 1.5,
              decoration: TextDecoration.none),
        ));
  }
}
