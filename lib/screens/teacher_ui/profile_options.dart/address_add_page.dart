import 'package:flutter/material.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/components/rounded_textfield.dart';
import 'package:tutor_finder/db_helper/db_helper_main_class.dart';
import 'package:intl/intl.dart';

class TeacheAddressAddPage extends StatefulWidget {
  static String routeName = "/teacher_add_address_page";
  const TeacheAddressAddPage({Key key}) : super(key: key);

  @override
  _TeacheAddressAddPageState createState() => _TeacheAddressAddPageState();
}

class _TeacheAddressAddPageState extends State<TeacheAddressAddPage> {
  @override
  void initState() {
    DBHelper.instance.getDivision().then((value) {
      value.forEach((element) {
        setState(() {
          divisionList.add(element['DIVISION']);
        });
      });
    });
      super.initState();
  }

  List divisionList = [];
  List districtList = [];
  List thanaList = [];
  var divisionValue;
  var districtValue;
  var thanaValue;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: appBar(context, 'Address'),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            height: size.height * 1,
            width: size.width * 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                s10,
                Mytext(
                  text: 'Division',
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
                      text: '\tSelect Division',
                      color: colorblack87,
                    ),
                    underline: SizedBox(),
                    icon: Icon(Icons.arrow_drop_down),
                    // iconSize: 35,
                    iconEnabledColor: Colors.black87,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    value: divisionValue,
                    onChanged: (value) {
                      setState(() {
                        divisionValue = value;
                        districtValue = null;
                        districtList.clear();
                        thanaValue = null;
                        thanaList.clear();
                        DBHelper.instance
                            .getDistrict(divisionValue)
                            .then((value) {
                          value.forEach((element) {
                            setState(() {
                              districtList.add(toBeginningOfSentenceCase(
                                  element['DISTRICT'].toString()));
                            });
                          });
                        });
                      });
                    },
                    items: divisionList.map((value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Mytext(
                            text: '\t\t $value',
                            fontsize: 15,
                            color: Colors.black,
                          ));
                    }).toList(),
                  ),
                ),
                s10,
                Mytext(
                  text: 'District',
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
                      text: '\tSelect District',
                      color: colorblack87,
                    ),
                    underline: SizedBox(),
                    icon: Icon(Icons.arrow_drop_down),
                    // iconSize: 35,
                    iconEnabledColor: Colors.black87,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    value: districtValue,
                    onChanged: (value) {
                      setState(() {
                        districtValue = value;
                        thanaValue = null;
                        thanaList.clear();
                        DBHelper.instance
                            .getThana(districtValue.toString().toLowerCase())
                            .then((value) {
                          value.forEach((element) {
                            setState(() {
                              thanaList.add(toBeginningOfSentenceCase(
                                  element['THANA'].toString()));
                            });
                          });
                        });
                      });
                    },
                    items: districtList.map((value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Mytext(
                            text: '\t\t $value',
                            fontsize: 15,
                            color: Colors.black,
                          ));
                    }).toList(),
                  ),
                ),
                s10,
                Mytext(
                  text: 'Thana',
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
                      text: '\tSelect Thana',
                      color: colorblack87,
                    ),
                    underline: SizedBox(),
                    icon: Icon(Icons.arrow_drop_down),
                    // iconSize: 35,
                    iconEnabledColor: Colors.black87,
                    isExpanded: true,
                    dropdownColor: Colors.white,
                    value: thanaValue,
                    onChanged: (value) {
                      setState(() {
                        thanaValue = value;
                      });
                    },
                    items: thanaList.map((value) {
                      return DropdownMenuItem(
                          value: value,
                          child: Mytext(
                            text: '\t\t $value',
                            fontsize: 15,
                            color: Colors.black,
                          ));
                    }).toList(),
                  ),
                ),
                Mytext(
                  text: 'House & Road no',
                ),
                s5,
                RoundedInputField(
                    // controlerText: fos,
                    hintText: 'House 101,Road 1',
                    obscureText: false,
                    color: colorgreylite.withOpacity(0.1)),
                s10,
                SizedBox(
                  width: size.width * 1,
                  child: RoundedButton(
                    color: loginbtn1,
                    text: 'Save',
                    press: () {
                      // if (institute.text.isEmpty) {
                      //   CustomSnakbar.snackbar(
                      //       context,
                      //       'Please add institution name',
                      //       Colors.red,
                      //       colorwhite);
                      // }
                      // if (degreeValue == null) {
                      //   CustomSnakbar.snackbar(context,
                      //       'Please select the degree', Colors.red, colorwhite);
                      // }
                      // if (fos.text.isEmpty) {
                      //   CustomSnakbar.snackbar(
                      //       context,
                      //       'Please the field of study',
                      //       Colors.red,
                      //       colorwhite);
                      // } else {
                      //   EducationDataAdding().storeEducationData(
                      //       context,
                      //       institute.text,
                      //       degreeValue,
                      //       fos.text,
                      //       cgpa.text,
                      //       startdate,
                      //       enddate);
                      // }
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
