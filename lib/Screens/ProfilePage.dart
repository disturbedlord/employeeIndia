import 'dart:convert';

import 'package:employeeindia_atg/Screens/BankdetailsPage.dart';
import 'package:employeeindia_atg/Screens/persistenceDataModel.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud/modal_progress_hud.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
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

class _ProfilePageState extends State<ProfilePage> {
  Post profileData;
  bool gotProfileData = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (persProfile == null) {
      getProfileData();
    } else {
      profileData = persProfile;
      setState(() {
        gotProfileData = true;
      });
    }
  }

  getProfileData() async {
    profileData = await profile(token);
    persProfile = profileData;
    setState(() {
      gotProfileData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 720,
        height: 1280,
        allowFontScaling: false); //flutter_screenuitl >= 1.2
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: Text(
              "Profile",
              style: GoogleFonts.poppins(color: Colors.black, fontSize: 35.sp),
            ),
            actions: <Widget>[
              IconButton(
                onPressed: () {},
                icon: Icon(
                  FontAwesomeIcons.wallet,
                  color: Colors.black,
                ),
              )
            ],
            automaticallyImplyLeading: false,
          ),
          body: Center(
            child: gotProfileData
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        ContainerWidget(
                          height: 300.h,
                          width: double.infinity,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              CircleAvatar(
                                maxRadius: 70.h,
                                child: Icon(FontAwesomeIcons.user),
                              ),
                              ContainersTextBox(text: "Username")
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ContainerWidget(
                                child: ContainersTextBox(text: "About"),
                                width: WIDTH / 2 - 40.w,
                                height: 250.h),
                            ContainerWidget(
                                child: ContainersTextBox(text: "Skills"),
                                width: WIDTH / 2 - 40.w,
                                height: 250.h),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            ContainerWidget(
                                child: ContainersTextBox(text: "Work"),
                                width: WIDTH / 2 - 40.w,
                                height: 250.h),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, '/BankDetailsPage');
                              },
                              child: ContainerWidget(
                                  child: ContainersTextBox(text: "Settings"),
                                  width: WIDTH / 2 - 40.w,
                                  height: 250.h),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                : CupertinoActivityIndicator(),
          )),
    );
  }
}

class ContainerWidget extends StatelessWidget {
  const ContainerWidget(
      {Key key,
      @required this.child,
      @required this.width,
      @required this.height})
      : super(key: key);

  final Widget child;
  final double width, height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: Color(0xffFFB700), borderRadius: BorderRadius.circular(30.h)),
      child: child,
    );
  }
}

class ContainersTextBox extends StatelessWidget {
  const ContainersTextBox({Key key, @required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(color: Color(0xffAC3F21)),
        ),
      ),
    );
  }
}
