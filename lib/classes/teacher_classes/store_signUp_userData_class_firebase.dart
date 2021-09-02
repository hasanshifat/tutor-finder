import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/snackbar.dart';
import 'package:tutor_finder/dialogs/allDialogs.dart';
import 'package:tutor_finder/provider/user_details.dart';
import 'package:tutor_finder/screens/teacher_ui/teacher_dashboard.dart';

class UserSignDataAdding {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  String fcmToken;
  storeNewUSerData(context, String gender) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    final uid = userDetails.userId.toString();

    // final email = userDetails.userEmail.toString();

    // final name = userDetails.userName.toString();
    FirebaseFirestore.instance.collection('/usersData').doc(uid).set({
      'uid': userDetails.userId.toString(),
      'name': userDetails.userName.toString(),
      'email': userDetails.userEmail.toString(),
      'number': userDetails.phoneNumber.toString(),
      'profile_pic': '',
      'gender': gender,
      'creation_time': Timestamp.now(),

      // 'fcmToken': userDetails.fcmToken.toString(),
      // 'osToken': userDetails.osToken.toString(),
    }).then((value) {
      Navigator.pop(context);
      auth
          .signInWithEmailAndPassword(
              email: userDetails.userEmail.toString(),
              password: userDetails.userPassword.toString())
          .then((value) {
        userDetails.dataUserID(value.user.uid);

        Navigator.pushNamed(context, TeacherDashBoard.routeName);
        CustomSnakbar.snackbar(
            context,
            'Welcome ${userDetails.userName.toString()}',
            loginbtn1,
            Colors.red[600]);
      });
    }).catchError((onError) {
      print(onError);
      Dialogs().error(context, 'SignUp Failed: $onError');
    });
  }
}
