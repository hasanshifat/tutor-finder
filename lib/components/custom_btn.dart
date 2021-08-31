import 'package:flutter/material.dart';
import 'package:tutor_finder/components/mytext.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textcolor;

  const CustomBtn({
    Key key,
    this.text,
    this.press,
    this.color,
    this.textcolor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: press,
        child: Container(
          width: size.width * 0.5,
          height: size.height * 0.07,
          color: color,
          child: Center(
            child: Mytext(
              text: text,
              color: textcolor,
              fontWeight: FontWeight.w500,
              fontsize: 18,
            ),
          ),
        ));
  }
}
