import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/provider/user_details.dart';
import 'package:tutor_finder/screens/teacher_ui/more_settings.dart';
import 'package:tutor_finder/screens/teacher_ui/teacher_dashboard_body.dart';
import 'package:tutor_finder/screens/teacher_ui/teacher_profile.dart';

class TeacherDashBoard extends StatefulWidget {
  static String routeName = "/techer_dashboard_page";
  const TeacherDashBoard({Key key}) : super(key: key);

  @override
  _TeacherDashBoardState createState() => _TeacherDashBoardState();
}

class _TeacherDashBoardState extends State<TeacherDashBoard> {
  @override
  void initState() {
    // getUserInfo(context);
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String img;
  int pageInndex = 0;
  List<Widget> pagelist = <Widget>[
    TeacherDashBoardBody(),
    TeacherProfile(),
    SettingsMore(),
    TeacherProfile(),
    SettingsMore(),
  ];
  Future getUserInfo(context) async {
    print('calledd');
    // firestoreInstance.collection("usersData").get().then((querySnapshot) {
    //   querySnapshot.docs.forEach((result) {
    //     print(result.data());
    //   });
    // });
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);

    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance
        .collection("usersData")
        .doc(firebaseUser.uid)
        .snapshots()
        .listen((value) {
      if (value != null) {
        setState(() {
          userDetails.dataUserName(value.data()['name']);
          userDetails.dataUserEmail(value.data()['email']);
          userDetails.dataUserID(value.data()['uid']);
          userDetails.dataPhoneNumber(value.data()['number']);
          img = value.data()['profile_pic'] != null
              ? value.data()['profile_pic'].toString()
              : null;

          print(userDetails.userName.toString());
          print(userDetails.userId.toString());
        });
        // return loadSnackBAr(
        //     context, 'Welcome ' + userDetails.userName.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pagelist[pageInndex],
      bottomNavigationBar: BottomNavigationBar(
          elevation: 2,
          backgroundColor: colorwhite,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: loginbtn1,
          currentIndex: pageInndex,
          onTap: (val) {
            setState(() {
              pageInndex = val;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: SizedBox(
                    height: 18,
                    width: 18,
                    child: SvgPicture.asset(
                      'assets/images/home.svg',
                      color: pageInndex == 0 ? loginbtn1 : colorblack87,
                    )),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite_outline,
                  size: 18,
                ),
                label: 'Favourite'),
            BottomNavigationBarItem(
                icon: SizedBox(
                    height: 18,
                    width: 18,
                    child: SvgPicture.asset('assets/images/briefcase.svg',
                        color: pageInndex == 2 ? loginbtn1 : colorblack87)),
                label: 'Jobs'),
            BottomNavigationBarItem(
                icon: SizedBox(
                    height: 18,
                    width: 18,
                    child: SvgPicture.asset('assets/images/user.svg',
                        color: pageInndex == 3 ? loginbtn1 : colorblack87)),
                label: 'Profile'),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.more_horiz,
                  size: 18,
                ),
                label: 'More'),
          ]),
    );
  }
}
