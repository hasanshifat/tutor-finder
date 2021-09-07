import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  final TextEditingController controlerText;
  final Color color;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final String labelText;
  final String errorText;
  const RoundedInputField(
      {Key key,
      this.hintText,
      this.errorText,
      this.labelText,
      this.keyboardType,
      this.suffixIcon,
      this.icon,
      this.onChanged,
      this.controlerText,
      this.color,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //  Size size = MediaQuery.of(context).size;
    return Container(
      // height: 40,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        //autofocus: false,
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controlerText,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          filled: true,
          fillColor: colorgreylite.withOpacity(0.1),
          hintText: hintText,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: colorgreylite.withOpacity(0.1),
              )),
          // enabledBorder: OutlineInputBorder(
          //     borderRadius: BorderRadius.circular(8),
          //     borderSide: new BorderSide(
          //       color: Colors.transparent,
          //     )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: colorgreylite.withOpacity(0.1),
              )),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(
                color: colorgreylite.withOpacity(0.1),
              )),
        ),
      ),
    );
  }
}
