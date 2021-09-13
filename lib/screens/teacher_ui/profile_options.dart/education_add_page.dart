import 'package:flutter/material.dart';
import 'package:tutor_finder/classes/teacher_classes/profile_details/education_store.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/components/rounded_textfield.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tutor_finder/components/snackbar.dart';

class AddEducation extends StatefulWidget {
  static String routeName = "/teacher_add_education_page";
  const AddEducation({Key key}) : super(key: key);

  @override
  _AddEducationState createState() => _AddEducationState();
}

class _AddEducationState extends State<AddEducation> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  DateTime dateTimeTo = DateTime.now();
  DateTime dateTimeTo2 = DateTime.now();
  DateFormat format = DateFormat.yMMMMd('en_US');
  final institute = TextEditingController();
  final fos = TextEditingController();
  final cgpa = TextEditingController();
  String startdate;
  String enddate;
  List<String> degree = [
    'Primary School Certificate(PSC)',
    'Junior School Certificate(JSC)',
    'Secondary School Certificate(SSC)',
    'Higher Secondary School Certificate(HSC)',
    'O Level',
    'A Level',
    'Bachelor',
    'Masters',
    'Doctor of Philosophy(PhD)',
    'Postgraduate Diploma(PGD)',
    'Diploma',
  ];

  Future startDate(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTimeTo,
        firstDate: DateTime(1950),
        lastDate: DateTime(3000),
        builder: (BuildContext context, Widget child) {
          return SizedBox(
            height: size.height * 0.7,
            width: size.width * 0.8,
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: colorblack87),
              ),
              child: child,
            ),
          );
        });
    if (picked != null) {
      setState(() {
        dateTimeTo = picked;

        startdate = DateFormat.yMMMMd().format(dateTimeTo);

        print('toDate $startdate');
      });
    }
  }

  Future endDate(BuildContext context) async {
    Size size = MediaQuery.of(context).size;
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: dateTimeTo2,
        firstDate: DateTime(1950),
        lastDate: DateTime(3000),
        builder: (BuildContext context, Widget child) {
          return SizedBox(
            height: size.height * 0.7,
            width: size.width * 0.8,
            child: Theme(
              data: ThemeData.light().copyWith(
                colorScheme: ColorScheme.light(primary: colorblack87),
              ),
              child: child,
            ),
          );
        });
    if (picked != null) {
      setState(() {
        dateTimeTo2 = picked;
        enddate = DateFormat.yMMMMd().format(dateTimeTo2);

        print('toDate $dateTimeTo');
      });
    }
  }

  String degreeValue;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, 'Add Education'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mytext(
                  text: 'Institution *',
                ),
                s5,
                RoundedInputField(
                    controlerText: institute,
                    hintText: 'Dhaka University',
                    obscureText: false,
                    color: colorgreylite.withOpacity(0.1)),
                s10,
                Mytext(
                  text: 'Degree *',
                ),
                s5,
                Container(
                  width: size.width * 1,
                  decoration: BoxDecoration(
                    color: colorgreylite.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButton(
                    hint: Mytext(
                      fontWeight: FontWeight.w500,
                      text: '\tSelect Degree',
                      color: colorblack87,
                    ),
                    underline: SizedBox(),
                    icon: Icon(Icons.arrow_drop_down),
                    // iconSize: 35,
                    iconEnabledColor: Colors.black87,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    value: degreeValue,
                    onChanged: (value) {
                      setState(() {
                        degreeValue = value;
                      });
                    },
                    items: degree.map((value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Mytext(
                            text: '\t\t' + value,
                            fontsize: 15,
                            color: Colors.black,
                          ));
                    }).toList(),
                  ),
                ),
                s10,
                Mytext(
                  text: 'Field of Study *',
                ),
                s5,
                RoundedInputField(
                    controlerText: fos,
                    hintText: 'Computer Science',
                    obscureText: false,
                    color: colorgreylite.withOpacity(0.1)),
                s10,
                Mytext(
                  text: 'CGPA/GPA',
                ),
                s5,
                RoundedInputField(
                    controlerText: cgpa,
                    hintText: 'Computer Science',
                    obscureText: false,
                    color: colorgreylite.withOpacity(0.1)),
                s10,
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Mytext(
                          text: 'Start Date',
                        ),
                        s5,
                        InkWell(
                          onTap: () => startDate(context),
                          child: Container(
                            width: size.width * 0.45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: colorgreylite.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                startdate == null ? '' : '$startdate',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Mytext(
                          text: 'End Date',
                        ),
                        s5,
                        InkWell(
                          onTap: () => endDate(context),
                          child: Container(
                            width: size.width * 0.45,
                            height: 50,
                            decoration: BoxDecoration(
                              color: colorgreylite.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                enddate == null ? '' : '$enddate',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                s10,
                SizedBox(
                  width: size.width * 1,
                  child: RoundedButton(
                    color: loginbtn1,
                    text: 'Save',
                    press: () {
                      if (institute.text.isEmpty) {
                        CustomSnakbar.snackbar(
                            context,
                            'Please add institution name',
                            Colors.red,
                            colorwhite);
                      } else if (degreeValue == null) {
                        CustomSnakbar.snackbar(context,
                            'Please select the degree', Colors.red, colorwhite);
                      } else if (fos.text.isEmpty) {
                        CustomSnakbar.snackbar(
                            context,
                            'Please the field of study',
                            Colors.red,
                            colorwhite);
                      } else {
                        EducationDataAdding().storeEducationData(
                            context,
                            institute.text,
                            degreeValue,
                            fos.text,
                            cgpa.text,
                            startdate,
                            enddate);
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
