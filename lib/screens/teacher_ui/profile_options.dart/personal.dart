import 'package:flutter/material.dart';
import 'package:tutor_finder/components/mytext.dart';

class PersonalData extends StatelessWidget {
  const PersonalData({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final UserDetails userDetails =
    //     Provider.of<UserDetails>(context, listen: false);
    return Container(
      child: Table(
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
                text: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Mytext(
                color: Colors.black87,
                text: 'userDetails.userEmail',
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
                text: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Mytext(
                color: Colors.black87,
                text: '01 Jan, 1996',
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
                text: '',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Mytext(
                color: Colors.black87,
                text: 'Male',
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
