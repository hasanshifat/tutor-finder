import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';

class EmailPassField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final Function(String) validator;
  final Function onSaved;
  final Function onFieldSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final ValueChanged<String> onChanged;
  final TextEditingController controlerText;
  final Color color;
  final fillColor;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget suffixIcon;
  final Widget prefixIcon;
  final String labelText;
  final String errorText;
  const EmailPassField(
      {Key key,
      this.hintText,
      this.validator,
      this.onSaved,
      this.errorText,
      this.textInputAction,
      this.onFieldSubmitted,
      this.focusNode,
      this.fillColor,
      this.labelText,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      this.icon,
      this.onChanged,
      this.controlerText,
      this.color,
      this.obscureText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.08,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextFormField(
        //autofocus: false,
        validator: validator,
        keyboardType: keyboardType,
        onChanged: onChanged,
        onSaved: onSaved,
        onFieldSubmitted: onFieldSubmitted,
        controller: controlerText,
        obscureText: obscureText,
        focusNode: focusNode,
        textInputAction: textInputAction,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(left: 20),
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          labelText: labelText,
          filled: true,
          fillColor: fillColor,
          hintText: hintText,
          border: InputBorder.none,
          errorText: errorText,
          disabledBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(color: color3)),
          enabledBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(color: color3)),
          focusedBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(color: color3)),
          errorBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(color: Colors.red)),
          focusedErrorBorder: OutlineInputBorder(
              gapPadding: 10,
              borderRadius: BorderRadius.circular(8),
              borderSide: new BorderSide(color: Colors.red)),
        ),
      ),
    );
  }
}
