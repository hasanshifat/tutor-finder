
import 'package:flutter/widgets.dart';
import 'package:tutor_finder/main.dart';
import 'package:tutor_finder/screens/login_page.dart';
import 'package:tutor_finder/screens/teacher_ui/profile_options.dart/address_add_page.dart';
import 'package:tutor_finder/screens/teacher_ui/profile_options.dart/education_add_page.dart';
import 'package:tutor_finder/screens/teacher_ui/registration_page.dart';
import 'package:tutor_finder/screens/teacher_ui/teacher_dashboard.dart';
import 'package:tutor_finder/screens/problems_page.dart';

final Map<String, WidgetBuilder> routes = {
  TeacherSignRegPage.routeName: (context) => TeacherSignRegPage(),
  TeacherLoginPage.routeName: (context) => TeacherLoginPage(),
  TeacherDashBoard.routeName: (context) => TeacherDashBoard(),
  MyHomePage.routeName: (context) => MyHomePage(),
  AddEducation.routeName: (context) => AddEducation(),
  TeacheAddressAddPage.routeName: (context) => TeacheAddressAddPage(),
  WriteAnswerPage.routeName: (context) => WriteAnswerPage(),
};
