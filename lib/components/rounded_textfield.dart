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
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        //autofocus: false,
        keyboardType: keyboardType,
        onChanged: onChanged,
        controller: controlerText,
        obscureText: obscureText,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          suffixIcon: suffixIcon,
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          hintText: hintText,
          border: InputBorder.none,
          errorText: errorText,
          enabledBorder:
              OutlineInputBorder(borderSide: new BorderSide(color: loginbtn1)),
        ),
      ),
    );
  }
}
