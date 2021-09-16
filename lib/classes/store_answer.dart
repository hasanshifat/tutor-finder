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

class AnswerDataAdding {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;

  String fcmToken;
  storeAnswerData(context, String ans, docid) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    final uid = userDetails.userId.toString();

    // final email = userDetails.userEmail.toString();

    // final name = userDetails.userName.toString();
    FirebaseFirestore.instance
        .collection('/problems')
        .doc(docid)
        .collection('answers')
        .doc()
        .set({
      'replyer_uid': userDetails.userId.toString(),
      'answer': ans,
      'docid': docid,
      'creation_time': Timestamp.now(),
      "upvote": '',
      "downvote": ''

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

        Navigator.pop(context);
        CustomSnakbar.snackbar(
            context, 'Your answer submitted', Colors.green, colorwhite);
      });
    }).catchError((onError) {
      print(onError);
      Dialogs().error(context, 'Your answer submition failed: $onError');
    });
  }
}
