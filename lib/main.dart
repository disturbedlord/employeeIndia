import 'package:employeeindia_atg/Screens/ApplyJob.dart';
import 'package:employeeindia_atg/Screens/LevelPage.dart';
import 'package:employeeindia_atg/Screens/LoginPage.dart';
import 'package:employeeindia_atg/Screens/MyWorkPage.dart';
import 'package:employeeindia_atg/Screens/NavigationPage.dart';
import 'package:employeeindia_atg/Screens/PaymentSlipPage.dart';
import 'package:employeeindia_atg/Screens/ProfilePage.dart';
import 'package:employeeindia_atg/Screens/SignUpPage.dart';
import 'package:employeeindia_atg/Screens/SubmitWork.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        fontFamily: 'GoogleFonts.poppins()',
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/SignUpPage': (context) => SignUpPage(),
        '/NavigationPage': (context) => NavigationPage(),
        '/MyWorkPage': (context) => MyWorkPage(),
        '/LevelPage': (context) => LevelPage(),
        '/ProfilePage': (context) => ProfilePage(),
        '/SubmitWork': (context) => SubmitWork(),
        '/ApplyJob': (context) => ApplyJob(),
        '/PaymentSlip': (context) => PaymentSlip()
      },
    );
  }
}
