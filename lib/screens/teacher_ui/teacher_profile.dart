
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/classes/teacher_classes/user_data_items_catg.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/provider/user_details.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:tutor_finder/screens/teacher_ui/profile_options.dart/education.dart';
import 'package:tutor_finder/screens/teacher_ui/profile_options.dart/personal.dart';

class TeacherProfile extends StatefulWidget {
  const TeacherProfile({Key key}) : super(key: key);

  @override
  _TeacherProfileState createState() => _TeacherProfileState();
}

class _TeacherProfileState extends State<TeacherProfile> {
  @override
  void initState() {
    // final UserDetails userDetails =
    //     Provider.of<UserDetails>(context, listen: false);
    setState(() {
      userDataCatg[0].click = true;
      body = PersonalData();
      //img = userDetails.profilePic.toString();
    });
    super.initState();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  FirebaseDatabase database = FirebaseDatabase.instance;
  DatabaseReference databaseReference = FirebaseDatabase.instance.reference();
  var firebaseUser = FirebaseAuth.instance.currentUser;

  String img;
  var body;
  List<UserDataCatg> userDataCatg = [
    UserDataCatg(name: 'Personal', id: 0, click: false),
    UserDataCatg(name: 'Address', id: 1, click: false),
    UserDataCatg(name: 'Career', id: 2, click: false),
    UserDataCatg(name: 'Education', id: 3, click: false),
    UserDataCatg(name: 'Exp', id: 4, click: false),
    UserDataCatg(name: 'Language', id: 5, click: false),
  ];

  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, 'Profile'),
      body: SafeArea(
          child:
              // img == null
              //     ? Center(
              //         child: CircularProgressIndicator(),
              //       )
              //     :
              Container(
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
                    // CircleAvatar(
                    //   maxRadius: 30,
                    //   backgroundColor: Colors.white,
                    //   child: ClipOval(
                    //     child: img == 'N/A'
                    //         ? SvgPicture.asset(
                    //             'assets/images/boy.svg')
                    //         : Image.memory(
                    //             base64Decode(img),
                    //             width: 60,
                    //             height: 60,
                    //             fit: BoxFit.cover,
                    //           ),
                    //   ),
                    // ),
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
                          fontsize: 13.5,
                        ),
                      ],
                    ),
                    Spacer(),
                    Icon(
                      Icons.edit,
                      color: colorblack87,
                      size: 20,
                    )
                  ],
                ),
              ),
              s10,
              Container(
                height: size.height * 0.05,
                width: size.width * 1,
                child: ListView.builder(
                    itemCount: userDataCatg.length,
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: InkWell(
                          onTap: () {
                            if (i == 0) {
                              setState(() {
                                body = PersonalData();
                                userDataCatg[i].click = true;
                                userDataCatg[1].click = false;
                                userDataCatg[2].click = false;
                                userDataCatg[3].click = false;
                                userDataCatg[4].click = false;
                                userDataCatg[5].click = false;
                              });
                            }
                            if (i == 1) {
                              setState(() {
                                userDataCatg[i].click = true;
                                userDataCatg[0].click = false;
                                userDataCatg[2].click = false;
                                userDataCatg[3].click = false;
                                userDataCatg[4].click = false;
                                userDataCatg[5].click = false;
                              });
                            }
                            if (i == 2) {
                              setState(() {
                                userDataCatg[i].click = true;
                                userDataCatg[0].click = false;
                                userDataCatg[1].click = false;
                                userDataCatg[3].click = false;
                                userDataCatg[4].click = false;
                                userDataCatg[5].click = false;
                              });
                            }
                            if (i == 3) {
                              setState(() {
                                body = Education();
                                userDataCatg[i].click = true;
                                userDataCatg[1].click = false;
                                userDataCatg[2].click = false;
                                userDataCatg[0].click = false;
                                userDataCatg[4].click = false;
                                userDataCatg[5].click = false;
                              });
                            }
                            if (i == 4) {
                              setState(() {
                                userDataCatg[i].click = true;
                                userDataCatg[1].click = false;
                                userDataCatg[2].click = false;
                                userDataCatg[3].click = false;
                                userDataCatg[0].click = false;
                                userDataCatg[5].click = false;
                              });
                            }
                            if (i == 5) {
                              setState(() {
                                userDataCatg[i].click = true;
                                userDataCatg[1].click = false;
                                userDataCatg[2].click = false;
                                userDataCatg[3].click = false;
                                userDataCatg[4].click = false;
                                userDataCatg[0].click = false;
                              });
                            }
                          },
                          child: Container(
                            // height: 100,
                            decoration: BoxDecoration(
                                color: userDataCatg[i].click != true
                                    ? colorgreylite.withOpacity(0.1)
                                    : colorblack87,
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                child: Text(
                                  '${userDataCatg[i].name}',
                                  style: TextStyle(
                                      color: userDataCatg[i].click != true
                                          ? colorblack87
                                          : colorwhite,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              s5,
              Divider(
                color: colorgreylite,
              ),
              s5,
              Container(
                child: body,
              )

              // Mytext(
              //   text: '${userDetails.userId.toString()}',
              //   color: colorblack87,
              // ),
              // RoundedButton(
              //   text: 'Sign Out',
              //   color: Colors.red,
              //   press: () {
              //     auth.signOut().then((value) {
              //       Navigator.pushNamed(
              //           context, MyHomePage.routeName);
              //     });
              //   },
              // ),
              // RoundedButton(
              //   text: 'post',
              //   color: Colors.red,
              //   press: () {
              //     print('object');
              //     // databaseReference
              //     //     .child('Post Id')
              //     //     .update({'Name': 'Post id', 'Id': 1});
              //     // firestoreInstance
              //     //     .collection("usersData")
              //     //     .orderBy('creation_time', descending: false)
              //     //     .limit(1)
              //     //     .snapshots()
              //     //     .listen((value) {
              //     //   value.docs.forEach((element) {
              //     //     print(element.data()['name']);
              //     //   });
              //     // });
              //   },
              // )
            ],
          ),
        ),
      )),
    );
  }
}
