import 'dart:convert';

import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:employeeindia_atg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController name = new TextEditingController();
  TextEditingController email = new TextEditingController();
  TextEditingController password1 = new TextEditingController();
  TextEditingController password2 = new TextEditingController();

  Post data;

  Future<Post> createPost(String url, String name, String email,
      String password1, String password2) async {
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'email': email,
          'password1': password1,
          'password2': password2,
        }));
    print(response.statusCode);
    if (response.statusCode == 200) {
      print("User Created");
      return Post.fromJson("signUp", json.decode(response.body));
    } else {
      showError(response.body);
    }
  }

  showError(String err) {
    Toast.show(err, context,
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(width: 720, height: 1280); //flutter_screenuitl >= 1.2

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.8,
          title: Text("Create a Account",
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 35.sp)),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back, color: Colors.black),
          ),
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 40.w, right: 40.w, top: 50.h),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        TextFieldLoginPage(
                            controller: name,
                            text: "Name",
                            passwordField: false),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextFieldLoginPage(
                            controller: email,
                            text: "Email",
                            passwordField: false),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextFieldLoginPage(
                            controller: password1,
                            text: "Password",
                            passwordField: true),
                        SizedBox(
                          height: 30.h,
                        ),
                        TextFieldLoginPage(
                          controller: password2,
                          text: "Confirm Password",
                          passwordField: true,
                        ),
                        SizedBox(
                          height: 50.h,
                        ),
                        GestureDetector(
                          onTap: () async {
                            data = await createPost(
                                "https://employedindia.in/api/signup/",
                                name.text,
                                email.text,
                                password1.text,
                                password2.text);

                            if (data != null) {
                              Toast.show(data.message, context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 40.h),
                            padding: EdgeInsets.symmetric(
                                horizontal: 80.h, vertical: 20.h),
                            decoration: BoxDecoration(
                                color: colors["brown"],
                                borderRadius: BorderRadius.circular(50.h)),
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontSize: 35.sp),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
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
      @required this.passwordField,
      @required this.controller})
      : super(key: key);
  final TextEditingController controller;
  final String text;
  final bool passwordField;

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
              controller: controller,
              style: TextStyle(fontSize: 32.sp),
              obscureText: passwordField ? true : false,
              decoration: InputDecoration(
                  filled: true,
                  isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 30.h, horizontal: 30.w),
                  fillColor: colors["lightBlue"],
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(50.w)),
                  suffixIconConstraints:
                      BoxConstraints(minHeight: 24.h, minWidth: 100.w),
                  suffixIcon: passwordField ? Icon(Icons.lock) : null),
            ),
          ),
        ),
      ],
    );
  }
}
