import 'package:flutter/widgets.dart';
import 'package:tutor_finder/main.dart';
import 'package:tutor_finder/screens/login_page.dart';
import 'package:tutor_finder/screens/teacher_ui/registration_page.dart';
import 'package:tutor_finder/screens/teacher_ui/teacher_dashboard.dart';

final Map<String, WidgetBuilder> routes = {
  TeacherSignRegPage.routeName: (context) => TeacherSignRegPage(),
  TeacherLoginPage.routeName: (context) => TeacherLoginPage(),
  TeacherDashBoard.routeName: (context) => TeacherDashBoard(),
  MyHomePage.routeName: (context) => MyHomePage(),
};
