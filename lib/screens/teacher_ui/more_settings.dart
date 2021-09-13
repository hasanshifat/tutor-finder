import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/classes/div_dis_thana.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/db_helper/db_helper_main_class.dart';
import 'package:tutor_finder/main.dart';

class SettingsMore extends StatefulWidget {
  const SettingsMore({Key key}) : super(key: key);

  @override
  _SettingsMoreState createState() => _SettingsMoreState();
}

class _SettingsMoreState extends State<SettingsMore> {
  @override
  void initState() {
    getdata();
    super.initState();
  }

  DBHelper dbHelper;
  final FirebaseAuth auth = FirebaseAuth.instance;
  DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child('div');
  List<DivDisThClass> list = [];
  List<Object> list2 = [];
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
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Mytext(
                            text: '${list[i].id}',
                          ),
                          Mytext(
                            text: list[i].division,
                          ),
                          Mytext(
                            text: list[i].district,
                          ),
                          Mytext(
                            text: list[i].thana,
                          ),
                        ],
                      );
                    }),
              ),
              RoundedButton(
                text: 'Sign Out',
                color: Colors.red,
                press: () {
                  auth.signOut();
                  Navigator.pushNamed(context, MyHomePage.routeName);
                },
              ),
            ],
          )),
    );
  }
}
