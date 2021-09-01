import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:tutor_finder/components/cons_height_width.dart';
import 'package:tutor_finder/components/mytext.dart';
import 'package:tutor_finder/components/mytext2.dart';
import 'package:tutor_finder/components/mytext_monserrat.dart';
import 'package:tutor_finder/components/rounded_button.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutor_finder/pageRoutes.dart';
import 'package:tutor_finder/screens/teacher_ui/registration_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          appBarTheme: AppBarTheme(
            color: Colors.white,
            elevation: 0,
            brightness: Brightness.light,
            iconTheme: IconThemeData(color: Colors.black87),
          ),
          //primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(),
      routes: routes,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: size.height * 1,
          width: size.width * 1,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              MytextMontserrat(
                text: 'Welcome to Tutor Finder',
                fontsize: 20,
                fontWeight: FontWeight.w500,
              ),
              s10,
              Container(
                height: size.height * 0.2,
                width: size.width * 0.6,
                child: SvgPicture.asset('assets/images/teacher.svg'),
              ),
              s10,
              Container(
                height: size.height * 0.6,
                width: size.width * 0.9,
                decoration: BoxDecoration(
                    color: colorgreylite[100],
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Mytext2(
                        textAlign: TextAlign.center,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontsize: 18,
                        text: 'Looking for a home tutor?',
                      ),
                      Divider(
                        //height: 0.5,
                        color: Colors.black87,
                      ),
                      s10,
                      MytextMontserrat(
                        fontsize: 12,
                        textAlign: TextAlign.justify,
                        text:
                            'You are at the right place. Hire the perfect teacher for your children today. We will provide you experienced and well mannered teacher for your children at your area.',
                      ),
                      s10,
                      RoundedButton(
                        text: 'Hire a Tutor',
                        color: loginbtn3,
                        fontSize: 15,
                        press: () => Navigator.pushNamed(
                            context, TeacherSignRegPage.routeName),
                      ),
                      s10,
                      Mytext2(
                        text: "Or",
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontsize: 18,
                      ),
                      s10,
                      Mytext2(
                        textAlign: TextAlign.center,
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontsize: 18,
                        text: 'You could be a Tutor',
                      ),
                      s10,
                      RoundedButton(
                        text: 'Become a Tutor',
                        color: loginbtn1,
                        fontSize: 15,
                        press: () {
                          FirebaseFirestore.instance
                              .collection('testing')
                              .add({'timestamp': Timestamp.now()});
                        },
                      ),
                      s5,
                      InkWell(
                        child: Mytext(
                          text: 'Click here to Sign In',
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
