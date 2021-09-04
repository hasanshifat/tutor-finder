import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/main.dart';
import 'package:tutor_finder/provider/user_details.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key key}) : super(key: key);

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
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

  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, 'Profile'),
      body: SafeArea(
          child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              s10,
              Container(
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(8)),
                height: size.height * .1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Mytext(
                          text: '${userDetails.userName.toString()}',
                          color: colorblack87,
                          fontWeight: FontWeight.bold,
                          fontsize: 15,
                        ),
                        Mytext(
                          text: '${userDetails.phoneNumber.toString()}',
                          color: colorgreylite,
                          fontsize: 12,
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      color: colorblack87,
                    )
                  ],
                ),
              ),
              s10,
              Mytext(
                text: '${userDetails.userId.toString()}',
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
      )),
    );
  }
}
