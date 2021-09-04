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
import 'package:tutor_finder/provider/user_details.dart';

class TeacherDashBoardBody extends StatefulWidget {
  static String routeName = "/techer_dashboard_page";
  const TeacherDashBoardBody({Key key}) : super(key: key);

  @override
  _TeacherDashBoardBodyState createState() => _TeacherDashBoardBodyState();
}

class _TeacherDashBoardBodyState extends State<TeacherDashBoardBody> {
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

  Widget categoryBody(String img) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: size.height * .1,
        width: size.width * 0.6,
        decoration: BoxDecoration(
            color: loginbtn1.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          children: [
            SizedBox(width: 10),
            Container(
              //color: loginbtn3,
              height: 35,
              width: 35,
              child: SvgPicture.asset(
                'assets/images/$img.svg', //briefcase
                color: colorblack87,
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mytext(
                  text: 'Chemistry',
                  color: colorblack87,
                  fontsize: 15,
                  fontWeight: FontWeight.bold,
                ),
                Mytext2(
                  text: '50 active jobs',
                  color: colorblack87,
                  fontsize: 12,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget recommendedJobsBody(String img) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        height: size.height * .1,
        width: size.width * 0.6,
        decoration: BoxDecoration(
            color: color5.withOpacity(0.25),
            borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.transparent,
              child: SizedBox(
                height: 25,
                width: 25,
                child: SvgPicture.asset(
                  'assets/images/$img.svg', //briefcase
                  color: colorblack87,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mytext(
                  text: 'Chemistry',
                  color: colorblack87,
                  fontsize: 15,
                  fontWeight: FontWeight.bold,
                ),
                Mytext2(
                  text: '50 active jobs',
                  color: colorblack87,
                  fontsize: 12,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  // Widget joblist() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: colorwhite,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: colorwhite,
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
          color: Colors.white70,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //Job section
                  s5,
                  Container(
                    height: size.height * .18,
                    width: size.width * 1,
                    decoration: BoxDecoration(
                      color: colorwhite,
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black87.withOpacity(0.5),

                          // changes position of shadow
                        ),
                      ],
                    ),
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
                  //Top Categories
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Mytext2(
                        text: 'Top Categories',
                        fontsize: 15,
                        color: colorblack87,
                        fontWeight: FontWeight.bold,
                      ),
                      Mytext2(
                        text: 'See All',
                        fontsize: 12,
                        color: colorblack87,
                      ),
                    ],
                  ),
                  s10,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        categoryBody('test tube'),
                        categoryBody('briefcase'),
                        categoryBody('briefcase'),
                      ],
                    ),
                  ),
                  s10,
                  //Recommended for you
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Mytext2(
                        text: 'Recommended for you',
                        fontsize: 15,
                        color: colorblack87,
                        fontWeight: FontWeight.bold,
                      ),
                      Mytext2(
                        text: 'See All',
                        fontsize: 12,
                        color: colorblack87,
                      ),
                    ],
                  ),
                  s10,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        recommendedJobsBody('test tube'),
                        recommendedJobsBody('briefcase'),
                        recommendedJobsBody('briefcase'),
                      ],
                    ),
                  ),
                  s10,
                  //Recent jobs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Mytext2(
                        text: 'Top Categories',
                        fontsize: 15,
                        color: colorblack87,
                        fontWeight: FontWeight.bold,
                      ),
                      Mytext2(
                        text: 'See All',
                        fontsize: 12,
                        color: colorblack87,
                      ),
                    ],
                  ),
                  s10,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
