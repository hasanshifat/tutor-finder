import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/main.dart';

class SettingsMore extends StatefulWidget {
  const SettingsMore({Key key}) : super(key: key);

  @override
  _SettingsMoreState createState() => _SettingsMoreState();
}

class _SettingsMoreState extends State<SettingsMore> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RoundedButton(
          text: 'Sign Out',
          color: Colors.red,
          press: () {
            auth.signOut();
            Navigator.pushNamed(context, MyHomePage.routeName);
          },
        ),
      ),
    );
  }
}
