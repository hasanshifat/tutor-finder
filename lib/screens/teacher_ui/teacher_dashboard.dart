import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/mytext2.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/main.dart';
import 'package:tutor_finder/provider/user_details.dart';

class TeacherDashBoard extends StatefulWidget {
  static String routeName = "/techer_dashboard_page";
  const TeacherDashBoard({Key key}) : super(key: key);

  @override
  _TeacherDashBoardState createState() => _TeacherDashBoardState();
}

class _TeacherDashBoardState extends State<TeacherDashBoard> {
  @override
  void initState() {
    getUserInfo(context);
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  String img;
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

  Widget jobSectionBody(
      String nmber, String text, Color txtclr, Color bgclr, Color imgclr) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            maxRadius: 30,
            backgroundColor: bgclr.withOpacity(0.1),
            child: SizedBox(
              height: 30,
              width: 30,
              child: SvgPicture.asset(
                'assets/images/briefcase.svg', //briefcase
                color: imgclr,
              ),
            ),
          ),
          Mytext(
            text: '$nmber',
            color: txtclr,
            fontsize: 15,
            fontWeight: FontWeight.bold,
          ),
          Mytext2(
            text: '$text',
            color: color2,
            fontsize: 12,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorgreylite[100],
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: colorgreylite[100],
            statusBarIconBrightness: Brightness.dark),
        title: MytextMontserrat(
          text: 'Tutor Finder',
          fontsize: 18,
          color: colorblack87,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SafeArea(
        child: Container(
          height: size.height * 1,
          width: size.width * 1,
          color: colorgreylite[100],
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: size.height * .18,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                        color: colorwhite,
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        jobSectionBody('1230', 'Live Jobs', loginbtn1,
                            loginbtn1.withOpacity(0.1), loginbtn1),
                        VerticalDivider(
                          color: colorblack87,
                        ),
                        jobSectionBody(
                            '1010',
                            'New Jobs',
                            Color(0xff66DE93),
                            Color(0xff66DE93).withOpacity(0.2),
                            Color(0xff66DE93)),
                        VerticalDivider(
                          color: colorblack87,
                        ),
                        jobSectionBody('110', 'Your Jobs', colorblack87,
                            colorgreylite, colorblack),
                      ],
                    ),
                  ),
                  s10,
                  CircleAvatar(
                    maxRadius: 30,
                    backgroundColor: Colors.white,
                    child: ClipOval(
                      child: img == null
                          ? SvgPicture.asset('assets/images/boy.svg')
                          : Image.memory(
                              base64Decode(img),
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  s10,
                  Mytext(
                    text: '${userDetails.userId.toString()}',
                    color: colorblack87,
                  ),
                  Mytext(
                    text: '${userDetails.phoneNumber.toString()}',
                    color: colorblack87,
                  ),
                  Mytext(
                    text: '${userDetails.userName.toString()}',
                    color: colorblack87,
                  ),
                  RoundedButton(
                    text: 'Sign Out',
                    color: Colors.red,
                    press: () {
                      auth.signOut().then((value) {
                        Navigator.pushNamed(context, MyHomePage.routeName);
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
