import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor_finder/components/appBar.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/email_pass_field.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/mytext2.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/components/snackbar.dart';

class TeacherSignRegPage extends StatefulWidget {
  static String routeName = "/techer_registration_page";
  const TeacherSignRegPage({Key key}) : super(key: key);

  @override
  _TeacherSignRegPageState createState() => _TeacherSignRegPageState();
}

class _TeacherSignRegPageState extends State<TeacherSignRegPage> {
  final textName = TextEditingController();
  final textEmail = TextEditingController();
  final textPassword = TextEditingController();
  final phoneNumber = TextEditingController();
  final textConfirmPassword = TextEditingController();
  final FocusNode passNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool obscuretexts = true;
  bool obscuretextsPassConf = true;
  bool checkBoxValue = false;
  String email;
  String pass;
  String radioValue;
  @override
  void dispose() {
    textEmail.dispose();
    textPassword.dispose();
    super.dispose();
  }

  validatorMethod() {
    if (_formkey.currentState.validate()) {
      print('ok');
    } else {
      print('not ok');
    }
  }

  void handleRadioValueChange1(String value) {
    setState(() {
      radioValue = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: appBar(context, 'Register as Tutor'),
        body: SafeArea(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Form(
                  key: _formkey,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          // height: size.height * 1,
                          width: size.width * 1,
                          decoration: BoxDecoration(
                              color: colorgreylite[100],
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Mytext2(
                                text: 'First register yourself',
                                fontsize: 15,
                                color: loginbtn1,
                              ),
                              s10,
                              EmailPassField(
                                controlerText: textName,
                                obscureText: false,

                                //fillColor: colorwhite,
                                //hintText: 'Enter Your Full Name',
                                labelText: 'Full Name',
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: color3,
                                ),
                                validator: (String val) {
                                  if (val.isEmpty) {
                                    return "Please enter your full name";
                                  }
                                  return null;
                                },
                                onSaved: (val) {
                                  setState(() {
                                    email = val;
                                    print(val);
                                  });
                                },
                              ),
                              s10,
                              EmailPassField(
                                controlerText: phoneNumber,
                                obscureText: false,
                                //hintText: 'Enter Your Mobile Number',
                                labelText: 'Mobile Number',
                                keyboardType: TextInputType.number,
                                prefixIcon: Icon(
                                  Icons.phone,
                                  color: color3,
                                ),
                                //fillColor: colorwhite,
                                validator: (String val) {
                                  if (val.isEmpty) {
                                    return "Please enter your mobile number";
                                  }
                                  if (val.length != 11) {
                                    return 'Please enter correct mobile number';
                                  }
                                  // if (!RegExp(
                                  //         r"/^[+]?(1\-|1\s|1|\d{3}\-|\d{3}\s|)?((\(\d{3}\))|\d{3})(\-|\s)?(\d{3})(\-|\s)?(\d{4})$/g")
                                  //     .hasMatch(val)) {
                                  //   return 'Please enter correct mobile number!';
                                  // }
                                  return null;
                                },
                                onSaved: (val) {
                                  setState(() {
                                    email = val;
                                    print(val);
                                  });
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Mytext2(
                                      text: 'Gender',
                                      fontsize: 15,
                                      color: color3,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Container(
                                      width: size.width * 0.25,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 'Male',
                                            groupValue: radioValue,
                                            onChanged: handleRadioValueChange1,
                                          ),
                                          Container(
                                            height: 25,
                                            width: 25,
                                            child: SvgPicture.asset(
                                                'assets/images/boy.svg'),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Spacer(),
                                    Container(
                                      width: size.width * 0.25,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(50),
                                      ),
                                      child: Row(
                                        children: [
                                          Radio(
                                            value: 'Female',
                                            groupValue: radioValue,
                                            onChanged: handleRadioValueChange1,
                                          ),
                                          Container(
                                            height: 25,
                                            width: 25,
                                            child: SvgPicture.asset(
                                                'assets/images/girl.svg'),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              EmailPassField(
                                controlerText: textEmail,
                                //hintText: 'Enter Your Email',
                                labelText: 'Email',
                                textInputAction: TextInputAction.next,
                                onFieldSubmitted: (String val) =>
                                    FocusScope.of(context)
                                        .requestFocus(passNode),
                                //fillColor: colorwhite,
                                validator: (String val) {
                                  if (val.isEmpty) {
                                    return "Please enter your email";
                                  }
                                  if (!RegExp(
                                          r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                      .hasMatch(val)) {
                                    return 'Please enter a valid email Address';
                                  }

                                  return null;
                                },
                                onSaved: (val) {
                                  setState(() {
                                    email = val;
                                    print(val);
                                  });
                                },
                                obscureText: false,
                                keyboardType: TextInputType.emailAddress,
                                prefixIcon: Icon(
                                  Icons.email_outlined,
                                  color: color3,
                                ),
                              ),
                              s10,
                              EmailPassField(
                                controlerText: textPassword,
                                focusNode: passNode,
                                //hintText: 'Enter Your Password',
                                labelText: 'Password',
                                //fillColor: colorwhite,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please enter your password";
                                  }
                                  if (val.length < 7) {
                                    return 'Password should contain 8 characters';
                                  }

                                  return null;
                                },
                                onSaved: (String val) {
                                  setState(() {
                                    pass = val;
                                    print(val);
                                  });
                                },
                                obscureText: obscuretexts,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: color3,
                                ),
                                suffixIcon: IconButton(
                                    color: obscuretexts ? color3 : loginbtn1,
                                    icon: Icon(obscuretexts
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        obscuretexts = !obscuretexts;
                                      });
                                    }),
                              ),
                              s10,
                              EmailPassField(
                                controlerText: textConfirmPassword,
                                //focusNode: passNode,
                                //hintText: 'Enter Your Password',
                                labelText: 'Confirm Password',
                                //fillColor: colorwhite,
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "Please re-enter your password";
                                  }
                                  if (textConfirmPassword.text !=
                                      textPassword.text) {
                                    return 'Password Mis-matched';
                                  }

                                  return null;
                                },
                                onSaved: (String val) {
                                  setState(() {
                                    pass = val;
                                    print(val);
                                  });
                                },
                                obscureText: obscuretextsPassConf,
                                keyboardType: TextInputType.visiblePassword,
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: color3,
                                ),
                                suffixIcon: IconButton(
                                    color: obscuretextsPassConf
                                        ? color3
                                        : loginbtn1,
                                    icon: Icon(obscuretextsPassConf
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        obscuretextsPassConf =
                                            !obscuretextsPassConf;
                                      });
                                    }),
                              ),
                              s10,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    Checkbox(
                                        checkColor: colorwhite,
                                        activeColor: loginbtn1,
                                        value: checkBoxValue,
                                        onChanged: (val) {
                                          setState(() {
                                            checkBoxValue = !checkBoxValue;
                                          });
                                        }),
                                    Mytext2(
                                      text: 'I agree to the',
                                      fontsize: 10,
                                      color: colorblack87,
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    InkWell(
                                      //onTap: () => Navigator.pushNamed(
                                      // context, TeacherLoginPage.routeName),
                                      child: Mytext(
                                        text: 'Terms & Conditions',
                                        decoration: TextDecoration.underline,
                                        color: loginbtn1,
                                        fontsize: 10,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
            ),
          ),
        ),
        bottomNavigationBar: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            RoundedButton(
                text: 'Sign Up',
                textColor: colorwhite,
                color: loginbtn1,
                press: () {
                  print('object');
                  setState(() {
                    if (!_formkey.currentState.validate()) {
                      return;
                    }
                    if (radioValue == null) {
                      CustomSnakbar.snackbar(
                          context, 'Please select your gender');
                    }
                    if (checkBoxValue == false) {
                      CustomSnakbar.snackbar(
                          context, 'Please select the agreement');
                    }
                    _formkey.currentState.save();
                    print(email);
                    print(radioValue);
                  });
                })
          ],
        ));
  }
}
