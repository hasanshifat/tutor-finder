import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:tutor_finder/classes/problems.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:intl/intl.dart';
import 'package:tutor_finder/components/mytext2.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';

class Problems extends StatefulWidget {
  const Problems({Key key}) : super(key: key);

  @override
  _ProblemsState createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems> {
  @override
  void initState() {
    super.initState();
    getProblems(context);
  }

  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference problemsData =
      FirebaseFirestore.instance.collection('/problems');
  final firestoreInstance = FirebaseFirestore.instance.collection('/usersData');

  List<ProblemsClass> problemsList = [];
  Future getProblems(context) async {
    print('calledd');
    problemsData
        .orderBy('posted_time', descending: true)
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          Timestamp timestamp;
          timestamp = doc['posted_time']; //'MM/dd/yyyy, hh:mm a'
          var date = DateFormat.yMMMMd().format(timestamp.toDate().toLocal());
          var d12 = DateFormat.jm().format(timestamp.toDate());
          var dateTime = date + d12;
          firestoreInstance.doc(doc['author_uid']).snapshots().listen((event) {
            setState(() {
              problemsList.add(ProblemsClass(
                qstn: doc['question'],
                uid: doc['author_uid'],
                time: d12,
                date: date,
                name: event.data()['name'],
                propic: event.data()['profile_pic'],
              ));
            });
          });

          ///
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, 'Problems'),
      body: SafeArea(
          child: problemsList.length < 1
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  height: size.height * 1,
                  width: size.width * 1,
                  child: ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemCount: problemsList.length,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: Container(
                          decoration: BoxDecoration(
                            color: colorwhite,
                            borderRadius: BorderRadius.circular(8),
                            // boxShadow: [
                            //   BoxShadow(
                            //     color: Colors.black87.withOpacity(0.5),
                            //   ),
                            // ],
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      maxRadius: 25,
                                      child: ClipOval(
                                        child: problemsList[i].propic == 'N/A'
                                            ? SvgPicture.asset(
                                                'assets/images/boy.svg')
                                            : Image.memory(
                                                base64Decode(
                                                    problemsList[i].propic),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MytextMontserrat(
                                          text: problemsList[i].name,
                                          fontsize: 15,
                                          fontWeight: FontWeight.w500,
                                        ),
                                        Mytext(
                                          text:
                                              '${problemsList[i].date} at ${problemsList[i].time}',
                                          fontsize: 10,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 5),
                                child: Mytext(
                                  text: problemsList[i].qstn,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Container(
                                  width: size.width * 1,
                                  height: 0.5,
                                  color: colorgreylite.withOpacity(1),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    sw10,
                                    FaIcon(
                                      FontAwesomeIcons.check,
                                      size: 18,
                                      color: loginbtn1,
                                    ),
                                    sw10,
                                    Mytext2(
                                      text: '102',
                                    ),
                                    Spacer(),
                                    FaIcon(
                                      FontAwesomeIcons.times,
                                      size: 18,
                                      color: Colors.red,
                                    ),
                                    sw10,
                                    Mytext2(
                                      text: '12',
                                    ),
                                    Spacer(),
                                    FaIcon(
                                      FontAwesomeIcons.commentDots,
                                      size: 20,
                                    ),
                                    sw10,
                                    Mytext2(
                                      text: '102',
                                    ),
                                    sw10,
                                  ],
                                ),
                              ),
                              s10,
                              Container(
                                width: size.width * 1,
                                height: 2,
                                color: colorgreylite.withOpacity(1),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )),
    );
  }
}
