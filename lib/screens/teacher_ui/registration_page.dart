import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/email_pass_field.dart';
import 'package:tutor_finder/components/mytext2.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';
import 'package:tutor_finder/components/rounded_button.dart';

class TeacherSignRegPage extends StatefulWidget {
  static String routeName = "/techer_registration_page";
  const TeacherSignRegPage({Key key}) : super(key: key);

  @override
  _TeacherSignRegPageState createState() => _TeacherSignRegPageState();
}

class _TeacherSignRegPageState extends State<TeacherSignRegPage> {
  final textEmail = TextEditingController();
  final textPassword = TextEditingController();
  final FocusNode passNode = FocusNode();
  final _formkey = GlobalKey<FormState>();
  final List<String> errors = [];
  bool obscuretexts = true;
  String email;
  String pass;
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            color: Colors.white,
            child: Form(
                key: _formkey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      s10,
                      MytextMontserrat(
                        text: 'Register as Tutor',
                        fontsize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      Mytext2(
                        text: 'First register yourself',
                        fontsize: 12,
                      ),
                      s10,
                      Container(
                        // height: size.height * 1,
                        width: size.width * 1,
                        decoration: BoxDecoration(
                            color: colorgreylite[100],
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            s10,
                            EmailPassField(
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
                              obscureText: false,
                              //hintText: 'Enter Your Mobile Number',
                              labelText: 'Mobile Number',
                              prefixIcon: Icon(
                                Icons.phone,
                                color: color3,
                              ),
                              //fillColor: colorwhite,
                              validator: (String val) {
                                if (val.isEmpty) {
                                  return "Please enter your mobile number";
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
                              controlerText: textEmail,
                              //hintText: 'Enter Your Email',
                              labelText: 'Email',
                              textInputAction: TextInputAction.next,
                              onFieldSubmitted: (String val) =>
                                  FocusScope.of(context).requestFocus(passNode),
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
                          ],
                        ),
                      ),
                      s10,
                      RoundedButton(
                          text: 'Sign Up',
                          textColor: colorwhite,
                          color: loginbtn3,
                          press: () {
                            print('object');
                            setState(() {
                              if (!_formkey.currentState.validate()) {
                                return;
                              }
                              _formkey.currentState.save();
                              print(email);
                            });
                          })
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
