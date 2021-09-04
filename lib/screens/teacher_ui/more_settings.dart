import 'package:flutter/material.dart';
import 'package:tutor_finder/components/mytext.dart';

class SettingsMore extends StatefulWidget {
  const SettingsMore({Key key}) : super(key: key);

  @override
  _SettingsMoreState createState() => _SettingsMoreState();
}

class _SettingsMoreState extends State<SettingsMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Mytext(text: 'Settings More'),
      ),
    );
  }
}
