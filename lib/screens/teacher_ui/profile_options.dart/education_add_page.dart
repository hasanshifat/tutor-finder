import 'package:flutter/material.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/rounded_textfield.dart';

class AddEducation extends StatefulWidget {
  static String routeName = "/teacher_add_education_page";
  const AddEducation({Key key}) : super(key: key);

  @override
  _AddEducationState createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context, 'Add Education'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Mytext(
                text: 'Institution*',
              ),
              s5,
              RoundedInputField(
                hintText: 'BUET',
                obscureText: false,
              )
            ],
          ),
        ),
      ),
    );
  }
}
