import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/provider/user_details.dart';

class TeacherDashBoard extends StatefulWidget {
  static String routeName = "/techer_dashboard_page";
  const TeacherDashBoard({Key key}) : super(key: key);

  @override
  _TeacherDashBoardState createState() => _TeacherDashBoardState();
}

class _TeacherDashBoardState extends State<TeacherDashBoard> {
  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    return Scaffold(
      body: Container(
        child: Center(
          child: Mytext(
            text: userDetails.userId,
          ),
        ),
      ),
    );
  }
}
