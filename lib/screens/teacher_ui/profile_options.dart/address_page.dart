import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/screens/teacher_ui/profile_options.dart/address_add_page.dart';

class TeacherAddress extends StatefulWidget {
  const TeacherAddress({Key key}) : super(key: key);

  @override
  _TeacherAddressState createState() => _TeacherAddressState();
}

class _TeacherAddressState extends State<TeacherAddress> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, TeacheAddressAddPage.routeName);
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
                  Icon(Icons.my_location),
                  Spacer(),
                  Text(
                    'Add Present Address',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
          s10,
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, TeacheAddressAddPage.routeName);
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
                  Icon(Icons.my_location),
                  Spacer(),
                  Text(
                    'Add Permanent Address',
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
