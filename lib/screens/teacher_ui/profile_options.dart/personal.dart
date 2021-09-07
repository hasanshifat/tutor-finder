import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tutor_finder/classes/teacher_classes/t_profile_class.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/snackbar.dart';

class PersonalData extends StatefulWidget {
  const PersonalData({Key key}) : super(key: key);

  @override
  _PersonalDataState createState() => _PersonalDataState();
}

class _PersonalDataState extends State<PersonalData> {
  @override
  void initState() {
    super.initState();
    getUserInfo(context);
  }

  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference usersData =
      FirebaseFirestore.instance.collection('/usersData');

  List<TeacherProfile> gradList = [];
  Future getUserInfo(context) async {
    print('calledd');
    usersData.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // final UserDetails userDetails =
    //     Provider.of<UserDetails>(context, listen: false);
    return Container(
      child: FutureBuilder<DocumentSnapshot>(
          future: usersData.doc(firebaseUser.uid).get(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return CustomSnakbar.snackbar(
                  context, 'Something error!', Colors.red, colorwhite);
            }

            if (snapshot.hasData && !snapshot.data.exists) {
              return CustomSnakbar.snackbar(
                  context, 'Document does not exist', Colors.red, colorwhite);
            }

            // if (snapshot.connectionState == ConnectionState.done) {
            //   Map<String, dynamic> data = snapshot.data.data() as Map<String, dynamic>;
            //   // return Text("Full Name: ${data['full_name']} ${data['last_name']}");
            // }
            return Table(
              columnWidths: {
                0: FlexColumnWidth(3),
                1: FlexColumnWidth(0.5),
                2: FlexColumnWidth(3),
              },
              children: [
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      text: 'Email',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      text: '|',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      color: Colors.black87,
                      text: '${snapshot.data['email']}',
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      text: 'Date of Birth',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      text: '|',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      color: Colors.black87,
                      text: '${snapshot.data['dob']}',
                    ),
                  ),
                ]),
                TableRow(children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      text: 'Gender',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      text: '|',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Mytext(
                      color: Colors.black87,
                      text: '${snapshot.data['gender']}',
                    ),
                  ),
                ]),
              ],
            );
          }),
    );
  }
}
