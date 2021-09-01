import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/email_pass_field.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:tutor_finder/dialogs/allDialogs.dart';
import 'package:tutor_finder/provider/user_details.dart';
import 'package:tutor_finder/screens/teacher_ui/teacher_dashboard.dart';

class TeacherLoginPage extends StatefulWidget {
  static String routeName = "/techer_login_page";
  const TeacherLoginPage({Key key}) : super(key: key);

  @override
  _TeacherLoginPageState createState() => _TeacherLoginPageState();
}

class _TeacherLoginPageState extends State<TeacherLoginPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
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
                        text: 'Log In',
                        textColor: colorwhite,
                        color: loginbtn3,
                        press: () {
                          setState(() {
                            if (!_formkey.currentState.validate()) {
                              return;
                            } else {
                              _formkey.currentState.save();
                              login();
                              // print(email);
                              // print(pass);
                            }
                          });
                        })
                  ],
                ),
              )),
        ),
      ),
    );
  }

  Future login() async {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);
    //loadSnackBAr(context, 'Loading');
    Dialogs().waiting(context, 'Logging in');

    auth.signInWithEmailAndPassword(email: email, password: pass).then((user) {
      // print(user);
      print(user.user.uid);
      print(user.additionalUserInfo.isNewUser);

      if (user.user.uid != null) {
        //  _scaffoldKey.currentState.hideCurrentSnackBar();
        //UserGetData().getUserInfo(context);
        setState(() {
          userDetails.dataUserID(user.user.uid);
        });
        Navigator.pushNamed(context, TeacherDashBoard.routeName)
            .then((value) => Navigator.pop(context))
            .catchError((error) {
          print(error);
          return Dialogs().error(context, error);
        });
      } else if (user.user.uid == null) {
        return Dialogs().error(context, 'Please Sign Up first!');
      } else {
        //return loadSnackBAr(context, 'Loading');
      }
    }).catchError((onError) {
      var a = onError.message;

      Dialogs().error(context, a);
    });
  }
}
