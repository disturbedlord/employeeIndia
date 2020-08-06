import 'dart:convert';
import 'package:employeeindia_atg/Screens/SignUpPage.dart';
import 'package:employeeindia_atg/Screens/persistenceDataModel.dart';

import 'tokenClass.dart';
import 'package:employeeindia_atg/Screens/NavigationPage.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:employeeindia_atg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // bring this the common data page
  bool showLoggingSpinner = false;
  // postData()
  Post data;

  bool showPassword = false;

  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();

  showError(String error) {
    Toast.show(error, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  Future<Post> forgotPassword(String url, String email) async {
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
        }));
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Post.fromJson("forgotPassword", json.decode(response.body));
    } else {
      showError(response.body);
    }
  }

  Future<Post> profile(String access) async {
    String url = "https://employedindia.in/api/profile/";
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access'
      },
    );

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Post.fromJson("profile", json.decode(response.body));
    } else {
      print(response.body);
    }
  }

  Future<Post> login(String url, String email, String password) async {
    print(url);
    print(email);
    print(password);
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'password': password,
        }));

    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Post.fromJson("login", json.decode(response.body));
    } else {
      showError(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    WIDTH = MediaQuery.of(context).size.width;
    HEIGHT = MediaQuery.of(context).size.height;

    ScreenUtil.init(
        width: 720,
        height: 1280,
        allowFontScaling: false); //flutter_screenuitl >= 1.2
    return SafeArea(
      child: Scaffold(
        backgroundColor: colors["brown"],
        body: Stack(
          children: <Widget>[
            Container(
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: EdgeInsets.all(40.h),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: Wrap(
                          direction: Axis.vertical,
                          children: <Widget>[
                            Text(
                              "Login ",
                              style: GoogleFonts.poppins(
                                  fontSize: 55.sp, color: Colors.white),
                            ),
                            Text(
                              "to your Account",
                              style: GoogleFonts.poppins(
                                  fontSize: 55.sp, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(80.w),
                              topRight: Radius.circular(80.w))),
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 40.w, right: 40.w, top: 50.h),
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              TextFieldLoginPage(
                                controller: email,
                                text: "Email",
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              // TextFieldLoginPage(
                              //     controller: password,
                              //     text: "Password",
                              //     passwordField: true),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.only(left: 50.w),
                                    child: Text(
                                      "Password",
                                      style: GoogleFonts.poppins(
                                          fontSize: 28.sp,
                                          color: colors["lightGrey"]),
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 30.w),
                                    child: Center(
                                      child: TextField(
                                        // autofocus: true,
                                        onTap: () {
                                          FocusScopeNode currentFocus =
                                              FocusScope.of(context);

                                          currentFocus.focusedChild
                                              .requestFocus();
                                        },
                                        controller: password,
                                        style: TextStyle(fontSize: 32.sp),
                                        obscureText:
                                            showPassword ? false : true,
                                        decoration: InputDecoration(
                                          filled: true,
                                          isDense: true,
                                          contentPadding: EdgeInsets.symmetric(
                                              vertical: 30.h, horizontal: 30.h),
                                          fillColor: colors["lightBlue"],
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(50.w),
                                          ),
                                          suffixIconConstraints: BoxConstraints(
                                              minHeight: 24.h, minWidth: 100.w),
                                          suffixIcon: showPassword
                                              ? IconButton(
                                                  icon: Icon(
                                                    Icons.lock_open,
                                                    size: 40.h,
                                                  ),
                                                  onPressed: () {
                                                    print(showPassword);
                                                    setState(() {
                                                      showPassword =
                                                          !showPassword;
                                                    });
                                                  },
                                                )
                                              : IconButton(
                                                  icon: Icon(
                                                    Icons.lock_outline,
                                                    size: 40.h,
                                                  ),
                                                  onPressed: () {
                                                    // print("clicked");
                                                    setState(() {
                                                      showPassword =
                                                          !showPassword;
                                                    });
                                                  },
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              GestureDetector(
                                onTap: () async {
                                  data = await forgotPassword(
                                      "https://employedindia.in/api/password/reset/",
                                      email.text);

                                  if (data != null) {
                                    Toast.show(data.detail, context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  }
                                },
                                child: Container(
                                  padding:
                                      EdgeInsets.only(right: 30.w, top: 20.h),
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forgot Password?",
                                    style: GoogleFonts.poppins(
                                        fontSize: 25.sp,
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 40.h,
                              ),
                              GestureDetector(
                                onTap: () async {
                                  FocusScope.of(context).unfocus();
                                  setState(() {
                                    showLoggingSpinner = true;
                                  });

                                  print("running...");
                                  data = await login(
                                    "https://employedindia.in/api/token/",
                                    email.text,
                                    password.text,
                                  );
                                  // print("lll");
                                  if (data != null) {
                                    persProfile = await profile(data.access);
                                  }

                                  if (data != null) {
                                    print(data.access);
                                    token = data.access;
                                    print("token $token");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              NavigationPage()),
                                    ).then((value) {
                                      setState(() {
                                        showLoggingSpinner = false;
                                      });
                                    });
                                  } else {
                                    setState(() {
                                      showLoggingSpinner = false;
                                    });
                                  }
                                  // print(data.access);
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 80.h, vertical: 20.h),
                                  decoration: BoxDecoration(
                                      color: colors["brown"],
                                      borderRadius:
                                          BorderRadius.circular(50.h)),
                                  child: Text(
                                    "Login",
                                    style: GoogleFonts.poppins(
                                        color: Colors.white, fontSize: 40.sp),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Center(
                                child: Text(
                                  "Or",
                                  style: GoogleFonts.poppins(fontSize: 25.sp),
                                ),
                              ),
                              SizedBox(
                                height: 30.h,
                              ),
                              Container(
                                width: 350.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    CompanySignUpIcon(
                                        icon: FontAwesomeIcons.google,
                                        color: Colors.black,
                                        backgroundColor: Colors.white,
                                        borderColor: colors["lightGrey"]),
                                    CompanySignUpIcon(
                                        icon: FontAwesomeIcons.facebookF,
                                        color: Colors.white,
                                        backgroundColor: Color(0xff4359AC),
                                        borderColor: Color(0xff4359AC)),
                                    CompanySignUpIcon(
                                        icon: FontAwesomeIcons.twitter,
                                        color: Colors.white,
                                        backgroundColor: Color(0xff1DA1F2),
                                        borderColor: Color(0xff1DA1F2)),
                                  ],
                                ),
                              ),
                              SizedBox(height: 30.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "Don't have an account?",
                                    style: GoogleFonts.poppins(fontSize: 28.sp),
                                  ),
                                  SizedBox(
                                    width: 10.h,
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      final responseFromSignInPage =
                                          await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => SignUpPage()),
                                      );
                                      // final snackbar1 = SnackBar(
                                      //   content: Text("Verify your Account"),
                                      // );
                                      print(responseFromSignInPage);
                                      if (responseFromSignInPage == 1) {
                                        // final snackbar1 = SnackBar(
                                        //   content: Text("Verify your Account"),
                                        // );
                                      } else {}
                                      // Scaffold.of(context)
                                      //     .showSnackBar(snackbar1);
                                    },
                                    child: Text(
                                      "Sign Up",
                                      style: GoogleFonts.poppins(
                                        fontSize: 28.sp,
                                        color: colors["brown"],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            showLoggingSpinner ? ShowLoadingWidget() : Container(),
          ],
        ),
      ),
    );
  }
}

class ShowLoadingWidget extends StatelessWidget {
  const ShowLoadingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Color(0xaaF5F5F7)),
      child: Center(
        child: Container(
          height: HEIGHT / 4,
          width: HEIGHT / 4,
          decoration: BoxDecoration(
              // color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(20.0)),
          child: CupertinoActivityIndicator(),
        ),
      ),
    );
  }
}

class CompanySignUpIcon extends StatelessWidget {
  const CompanySignUpIcon({
    Key key,
    @required this.icon,
    @required this.color,
    @required this.backgroundColor,
    @required this.borderColor,
  }) : super(key: key);

  final IconData icon;
  final Color color, backgroundColor, borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.h,
      width: 100.w,
      decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(20.w),
          border: Border.all(color: borderColor, width: 5.w)),
      child: Icon(
        icon,
        color: color,
      ),
    );
  }
}

class TextFieldLoginPage extends StatelessWidget {
  const TextFieldLoginPage(
      {Key key,
      @required this.text,
      // @required this.passwordField,
      @required this.controller})
      : super(key: key);

  final String text;
  // final bool passwordField;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 50.w),
          child: Text(
            text,
            style: GoogleFonts.poppins(
                fontSize: 28.sp, color: colors["lightGrey"]),
          ),
        ),
        SizedBox(height: 20.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w),
          child: Center(
            child: TextField(
                // autofocus: true,
                onTap: () {
                  FocusScopeNode currentFocus = FocusScope.of(context);

                  currentFocus.focusedChild.requestFocus();
                },
                controller: controller,
                style: TextStyle(fontSize: 32.sp),
                decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.h),
                  fillColor: colors["lightBlue"],
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(50.w),
                  ),
                )),
          ),
        ),
      ],
    );
  }
}
