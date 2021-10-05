import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:tutor_finder/classes/div_dis_thana.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/db_helper/db_helper_main_class.dart';
import 'package:tutor_finder/main.dart';
import 'package:http/http.dart' as http;

class SettingsMore extends StatefulWidget {
  const SettingsMore({Key key}) : super(key: key);

  @override
  _SettingsMoreState createState() => _SettingsMoreState();
}

class _SettingsMoreState extends State<SettingsMore> {
  @override
  void initState() {
    getdata();
    getSubPartyName();
    super.initState();
  }

  DBHelper dbHelper;
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('div');
  List<DivDisThClass> list = [];
  List<Object> list2 = [];
  List<TestList> listt = [];
  var url = Uri.parse('https://apex.oracle.com/pls/apex/financial/hr/empinfo/');
  //StreamSubscription streamSubscription;

  getdata() {
    // databaseReference.onValue.listen((event) {
    //   setState(() {
    //     list2 = event.snapshot.value;
    //     for (int i = 0; i < list2.length; i++) {
    //       setState(() {
    //         list.add(DivDisThClass(
    //           id: int.parse(event.snapshot.value[i]['ID']),
    //           division: event.snapshot.value[i]['DIVISION'],
    //           district: event.snapshot.value[i]['DISTRICT'],
    //           thana: event.snapshot.value[i]['THANA'],
    //         ));
    //       });
    //     }
    //   });
    // });
    DBHelper.instance.getDivision().then((value) {
      print(value);
    });
  }

  Future getSubPartyName() async {
    var orderItems;

    final response = await http
        .get(
          url,
        )
        .timeout(Duration(seconds: 25))
        .catchError((error) {
      print(error);
    });
    orderItems = json.decode(response.body);
    List l = orderItems['items'];
    l.forEach((element) {
      setState(() {
        listt.add(TestList(
            empno: element['empno'],
            ename: element['ename'],
            job: element['job'],
            hiredate: element['hiredate'],
            deptno: element['deptno']));
      });
    });
    print(orderItems['items']);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
          width: size.width * 1,
          height: size.height * 1,
          child: Column(
            children: [
              Container(
                width: size.width * 1,
                height: size.height * 0.7,
                child: ListView.builder(
                    itemCount: listt.length,
                    itemBuilder: (context, i) {
                      return ListTile(
                        title: Mytext(
                          text: listt[i].ename,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Mytext(
                              text: '${listt[i].empno}',
                            ),
                            Mytext(
                              text: listt[i].job,
                            ),
                          ],
                        ),
                      );

                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                      //   children: [
                      //     Column(
                      //       children: [
                      //         Mytext(
                      //           text: '${listt[i].deptno}',
                      //         ),
                      //         Mytext(
                      //           text: listt[i].ename,
                      //         ),
                      //         Mytext(
                      //           text: listt[i].empno,
                      //         ),
                      //         Mytext(
                      //           text: listt[i].hiredate,
                      //         ),
                      //       ],
                      //     ),
                      //   ],
                      // );
                    }),
              ),
            ],
          )),
    );
  }
}

class TestList {
  var empno, ename, job, hiredate, deptno;
  TestList({this.deptno, this.empno, this.ename, this.hiredate, this.job});
}
