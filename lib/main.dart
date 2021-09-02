import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:tutor_finder/components/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tutor_finder/pageRoutes.dart';
import 'package:tutor_finder/provider/user_details.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:tutor_finder/screens/teacher_ui/teacher_dashboard.dart';
import 'package:tutor_finder/welcome_page.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserDetails>.value(
          value: UserDetails(),
        ),
      ],
      child: MaterialApp(
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
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  static String routeName = "/main_page";
  MyHomePage({
    Key key,
  }) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails =
        Provider.of<UserDetails>(context, listen: false);

    return Scaffold(
      backgroundColor: colorgreylite[100],
      body: SafeArea(
        child: StreamBuilder<auth.User>(
          stream: auth.FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.none) {
              Navigator.pushNamed(context, '/nonet');
            } else if (snapshot.connectionState == ConnectionState.active) {
              auth.User user = snapshot.data;
              //get the user status once the connection is established
              if (user == null) {
                //print("User is NULL::: " + user.toString());
                return WelcomePage(); //
              }
              print("User is NOT NULL::: " + user.toString());
              //home screen
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: color1,
                  ), //called in case all fails while waiting for connection status
                ),
              );
            } else if (snapshot.hasData) {
              setState(() {
                auth.User user = snapshot.data;
                userDetails.dataUserID(user.uid);
                print(userDetails.userId.toString());
              });
            }
            return TeacherDashBoard();
          },
        ),
      ),
    );
  }
}
