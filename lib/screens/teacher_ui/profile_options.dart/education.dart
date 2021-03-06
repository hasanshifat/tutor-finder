import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor_finder/classes/teacher_classes/profile_details/grad_deatils_class.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/screens/teacher_ui/profile_options.dart/education_add_page.dart';

class Education extends StatefulWidget {
  const Education({Key key}) : super(key: key);

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
  @override
  void initState() {
    super.initState();
    getUserInfo(context);
  }

  var firebaseUser = FirebaseAuth.instance.currentUser;
  CollectionReference usersData =
      FirebaseFirestore.instance.collection('/usersData');

  List<GradClass> gradList = [];
  Future getUserInfo(context) async {
    print('calledd');
    // firestoreInstance.collection("usersData").get().then((querySnapshot) {
    //   querySnapshot.docs.forEach((result) {
    //     print(result.data());
    //   });
    // });
    // final UserDetails userDetails =
    //     Provider.of<UserDetails>(context, listen: false);

    usersData
        .doc(firebaseUser.uid)
        .collection('education')
        .get()
        .then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        setState(() {
          gradList.add(GradClass(
              institute: doc["institute"],
              degree: doc["degree"],
              fos: doc["fos"],
              cgpa: doc["cgpa"],
              startDt: doc["startdate"],
              endDt: doc["enddate"]));
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, AddEducation.routeName);
            },
            child: Container(
              width: size.width * 1,
              height: 40,
              decoration: BoxDecoration(
                color: colorwhite,
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black87.withOpacity(0.5),
                    // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.add),
                  Spacer(),
                  Text(
                    'Add Education',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          s10,
          Container(
            width: size.width * 1,
            height: size.height * 0.4,
            child: ListView.builder(
              itemCount: gradList.length,
              itemBuilder: (context, i) {
                return Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        maxRadius: 25,
                        backgroundColor: loginbtn1.withOpacity(0.1),
                        child: SizedBox(
                          width: 25,
                          height: 25,
                          child: SvgPicture.asset(
                              'assets/images/graduation cap.svg'),
                        ),
                      ),
                      title: Mytext(
                        text: gradList[i].institute,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Mytext(
                            text: '${gradList[i].degree},${gradList[i].fos}',
                            fontsize: 12,
                          ),
                          Mytext(
                            text: 'CGPA: ${gradList[i].cgpa}',
                            fontsize: 12,
                          ),
                          Mytext(
                            text:
                                'Year: ${gradList[i].startDt}-${gradList[i].endDt}',
                            fontsize: 12,
                          ),
                        ],
                      ),
                    ),
                    Divider()
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
