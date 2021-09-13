import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/snackbar.dart';
import 'package:tutor_finder/dialogs/allDialogs.dart';
import 'package:tutor_finder/provider/user_details.dart';
class EducationDataAdding {
  final FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference usersData =
      FirebaseFirestore.instance.collection('/usersData');

  storeEducationData(context, String institute, String degree, String fos,
      String cgpa, String startdate, String enddate) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    final uid = userDetails.userId.toString();
    usersData.doc(uid).collection('education').add({
      'degree': degree.toString(),
      'institute': institute.toString(),
      'fos': fos.toString(),
      'cgpa': cgpa == '' ? 'N/A' : cgpa.toString(),
      'startdate': startdate == '' ? 'N/A' : startdate.toString(),
      'enddate': enddate == '' ? 'N/A' : enddate.toString(),
    }).then((value) {
      CustomSnakbar.snackbar(
          context, 'Updated Successfully', Colors.green, colorwhite);
      Navigator.pop(context);
    }).catchError((onError) {
      print(onError);
      Dialogs().error(context, 'Updated Failed: $onError');
    });
  }
}
