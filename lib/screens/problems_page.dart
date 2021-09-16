import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/classes/get_answer_class.dart';
import 'package:tutor_finder/classes/problems.dart';
import 'package:tutor_finder/classes/store_answer.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:intl/intl.dart';
import 'package:tutor_finder/components/mytext2.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/provider/user_details.dart';

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
  var docid;

  List<ProblemsClass> problemsList = [];
  List<GetANSClass> getAllANSList = [];
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

          firestoreInstance.doc(doc['author_uid']).snapshots().listen((event) {
            setState(() {
              problemsList.add(ProblemsClass(
                qstn: doc['question'],
                uid: doc['author_uid'],
                time: d12,
                date: date,
                name: event.data()['name'],
                propic: event.data()['profile_pic'],
                docID: doc.id,
              ));
            });
          });

          ///
        });
      });
    });
  }

  Future getAllAnswers(context, docid, ques) async {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);

    print('Doc id: $docid');
    FirebaseFirestore.instance
        .collection('/problems')
        .doc(docid)
        .collection('answers')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        print('r uid :${doc['replyer_uid']}');
        print('answer :${doc['answer']}');

        setState(() {
          Timestamp timestamp;
          timestamp = doc['creation_time']; //'MM/dd/yyyy, hh:mm a'
          var date = DateFormat.yMMMMd().format(timestamp.toDate().toLocal());
          var d12 = DateFormat.jm().format(timestamp.toDate());
          var ruid = doc['replyer_uid'];
          var ansrDocId = doc.id;
          int upvote = 0;
          int downvote = 0;

          List uv = doc['upvote'];
          List dv = doc['downvote'];
          print(uv.length);
          print(dv.length);

          if (doc['upvote'].toString().contains(userDetails.userId)) {
            setState(() {
              upvote += 1;
            });
          } else {
            setState(() {
              upvote = 0;
            });
          }
          if (doc['downvote'].toString().contains(userDetails.userId)) {
            setState(() {
              downvote += 1;
            });
          } else {
            setState(() {
              downvote = 0;
            });
          }

          firestoreInstance.doc(ruid).snapshots().listen((event) {
            setState(() {
              getAllANSList.add(GetANSClass(
                  time: d12,
                  date: date,
                  ans: doc['answer'],
                  name: event.data()['name'],
                  upvote: upvote,
                  downvote: downvote,
                  totalupvote: uv.length,
                  totaldownvote: dv.length,
                  propic: event.data()['profile_pic'],
                  docID: ansrDocId));
              print(getAllANSList[0].upvote);
            });
          });
        });
      });
    }).then((value) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AnswerDetails(
              getANSList: getAllANSList,
              docID: docid,
              ques: ques,
            ),
          ));
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
                                    InkWell(
                                      onTap: () {
                                        var q;
                                        //answerBottomSheet(problemsList[i].qstn);
                                        print(problemsList[i].qstn);
                                        setState(() {
                                          q = problemsList[i].qstn;
                                          docid = problemsList[i].docID;
                                          print(docid);
                                        });
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  WriteAnswerPage(
                                                ques: q,
                                                docID: problemsList[i].docID,
                                              ),
                                            ));
                                        print(
                                          problemsList[i].docID,
                                        );
                                      },
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.edit,
                                            size: 18,
                                            color: loginbtn1,
                                          ),
                                          sw10,
                                          Mytext2(
                                            text: 'Write Answer',
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          docid = problemsList[i].docID;
                                          getAllANSList.clear();
                                        });
                                        print(docid);

                                        getAllAnswers(context, docid,
                                            problemsList[i].qstn);
                                      },
                                      child: Row(
                                        children: [
                                          FaIcon(
                                            FontAwesomeIcons.commentDots,
                                            size: 20,
                                          ),
                                          sw10,
                                          Mytext2(
                                            text: 'Answres',
                                          ),
                                        ],
                                      ),
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

class WriteAnswerPage extends StatefulWidget {
  static String routeName = "/answer_page";
  final String ques, docID;
  const WriteAnswerPage({Key key, this.ques, this.docID}) : super(key: key);

  @override
  _WriteAnswerPageState createState() => _WriteAnswerPageState();
}

class _WriteAnswerPageState extends State<WriteAnswerPage> {
  @override
  void initState() {
    setState(() {
      ques = widget.ques;
      print(widget.ques);
      print(ques);
    });
    super.initState();
  }

  final ansCntlr = TextEditingController();
  var ques;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
              height: size.height * 1,
              width: size.width * 1,
              decoration: BoxDecoration(
                  //color: colorgreylite.withOpacity(0.05),
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(9),
                      topLeft: Radius.circular(9))),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  children: [
                    s10,
                    Row(
                      children: [
                        IconButton(
                            icon: FaIcon(
                              FontAwesomeIcons.times,
                              size: 18,
                            ),
                            onPressed: () => Navigator.pop(context)),
                        Spacer(),
                        SizedBox(
                          width: size.width * 0.2,
                          child: RoundedButton(
                            color: loginbtn1,
                            text: 'Post',
                            press: () {
                              AnswerDataAdding().storeAnswerData(
                                  context, ansCntlr.text, widget.docID);
                            },
                          ),
                        ),
                      ],
                    ),
                    s10,
                    Mytext2(
                      text: '$ques',
                      fontWeight: FontWeight.bold,
                    ),
                    s5,
                    TextField(
                      controller: ansCntlr,
                      decoration: InputDecoration(
                          hintText: 'Write your answer',
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
}

class AnswerDetails extends StatefulWidget {
  final List<GetANSClass> getANSList;
  final docID, ques;
  const AnswerDetails({Key key, this.getANSList, this.docID, this.ques})
      : super(key: key);

  @override
  _AnswerDetailsState createState() => _AnswerDetailsState();
}

class _AnswerDetailsState extends State<AnswerDetails> {
  @override
  void initState() {
    setList();
    super.initState();
  }

  setList() {
    setState(() {
      getANSList.clear();
      getANSList = widget.getANSList;
      isLoading = true;
      print(widget.docID);
    });
  }

  final db = FirebaseFirestore.instance;
  CollectionReference problemsData =
      FirebaseFirestore.instance.collection('/problems');

  List<GetANSClass> getANSList = [];
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, 'Answers'),
      body: SafeArea(
          child: Container(
              height: size.height * 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: isLoading == false
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : getANSList.length < 1
                        ? Center(
                            child: Mytext2(
                              text: 'No answer found',
                            ),
                          )
                        : SingleChildScrollView(
                            child: Container(
                              height: size.height * 1,
                              width: size.width * 1,
                              child: Column(
                                children: [
                                  s10,
                                  Mytext2(
                                      text: widget.ques,
                                      fontWeight: FontWeight.bold,
                                      fontsize: 15),
                                  Expanded(
                                    child: ListView.builder(
                                      physics: BouncingScrollPhysics(),
                                      itemCount: getANSList.length,
                                      itemBuilder: (context, i) {
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            s10,
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 10),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  CircleAvatar(
                                                    maxRadius: 15,
                                                    child: ClipOval(
                                                      child: getANSList[i]
                                                                  .propic ==
                                                              'N/A'
                                                          ? SvgPicture.asset(
                                                              'assets/images/boy.svg')
                                                          : Image.memory(
                                                              base64Decode(
                                                                  getANSList[i]
                                                                      .propic),
                                                              width: 50,
                                                              height: 50,
                                                              fit: BoxFit.cover,
                                                            ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      MytextMontserrat(
                                                        text:
                                                            getANSList[i].name,
                                                        fontsize: 12,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                      Mytext(
                                                        text:
                                                            '${getANSList[i].date} at ${getANSList[i].time}',
                                                        fontsize: 8,
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Mytext(
                                              text: '${getANSList[i].ans}',
                                              fontsize: 15,
                                            ),
                                            s10,
                                            Row(
                                              children: [
                                                SizedBox(
                                                  width: 50,
                                                ),
                                                getANSList[i].upvote == 0
                                                    ? IconButton(
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .check,
                                                          size: 20,
                                                          color: colorblack87,
                                                        ),
                                                        onPressed: () {})
                                                    : IconButton(
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .check,
                                                          size: 20,
                                                          color: loginbtn1,
                                                        ),
                                                        onPressed: () {}),
                                                Mytext(
                                                  text:
                                                      '${getANSList[i].totalupvote}',
                                                ),
                                                Spacer(),
                                                getANSList[i].downvote == 0
                                                    ? IconButton(
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .times,
                                                          size: 20,
                                                          color: colorblack87,
                                                        ),
                                                        onPressed: () {})
                                                    : IconButton(
                                                        icon: FaIcon(
                                                          FontAwesomeIcons
                                                              .times,
                                                          size: 20,
                                                          color: Colors.red,
                                                        ),
                                                        onPressed: () {}),
                                                Mytext(
                                                  text:
                                                      '${getANSList[i].totaldownvote}',
                                                ),
                                                SizedBox(
                                                  width: 50,
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: size.width * 1,
                                              height: 0.5,
                                              color:
                                                  colorgreylite.withOpacity(1),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
              ))),
    );
  }
}
