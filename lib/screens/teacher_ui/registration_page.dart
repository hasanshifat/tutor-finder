import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';

class TeacherSignRegPage extends StatefulWidget {
  static String routeName = "/techer_registration_page";
  const TeacherSignRegPage({Key key}) : super(key: key);

  @override
  _TeacherSignRegPageState createState() => _TeacherSignRegPageState();
}

class _TeacherSignRegPageState extends State<TeacherSignRegPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: loginbtn1,
      ),
    );
  }
}
