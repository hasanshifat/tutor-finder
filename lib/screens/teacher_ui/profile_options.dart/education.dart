import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/screens/teacher_ui/profile_options.dart/education_add_page.dart';

class Education extends StatefulWidget {
  const Education({Key key}) : super(key: key);

  @override
  _EducationState createState() => _EducationState();
}

class _EducationState extends State<Education> {
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
          )
        ],
      ),
    );
  }
}
