import 'package:flutter/material.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/email_pass_field.dart';
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
    return Scaffold(
      body: SafeArea(
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
                    EmailPassField(
                      controlerText: textEmail,
                      textInputAction: TextInputAction.next,
                      onFieldSubmitted: (String val) =>
                          FocusScope.of(context).requestFocus(passNode),
                      labelText: 'Email',
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
                    s10,
                    s10,
                    EmailPassField(
                      controlerText: textPassword,
                      labelText: 'Password',
                      focusNode: passNode,
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
    );
  }
}
