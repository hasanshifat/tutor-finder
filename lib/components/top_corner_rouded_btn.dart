import 'package:flutter/material.dart';
import 'package:tutor_finder/components/mytext2.dart';

class CustomBtnRound extends StatelessWidget {
  final String text;
  final Function press;
  final Color color;

  const CustomBtnRound({
    Key key,
    this.text,
    this.press,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
        onTap: press,
        child: Container(
          width: size.width * 0.5,
          height: size.height * 0.07,
          decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.only(topRight: Radius.circular(10))),
          child: Center(
            child: Mytext2(
              text: text,
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontsize: 18,
            ),
          ),
        ));
  }
}
