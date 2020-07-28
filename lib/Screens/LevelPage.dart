import 'dart:convert';

import 'package:employeeindia_atg/Screens/ProfilePage.dart';
import 'package:employeeindia_atg/Screens/SubmitWork.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:employeeindia_atg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class LevelPage extends StatefulWidget {
  final String accessCode;
  LevelPage({this.accessCode});
  @override
  _LevelPageState createState() => _LevelPageState();
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
  // print(response.body);
  if (response.statusCode == 200) {
    return Post.fromJson("profile", json.decode(response.body));
  } else {
    print(response.body);
  }
}

Future<Post> show(String access) async {
  // print(url);
  // print(email);
  print(access);

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
    return Post.fromJson("login", json.decode(response.body));
  } else {
    print(response.body);
  }
}

class _LevelPageState extends State<LevelPage> {
  List<int> cardLevels;
  Post profileData;
  bool showLoading = true;
  String _token;

  Widget listOfLevelCards() {
    bool flag = true;
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) {
        if (flag) {
          flag = false;
          return LevelCardWidget(
            level: cardLevels[index],
          );
        }
        return LevelCardWidgetUnlocked(
          level: cardLevels[index],
        );
      },
      itemCount: cardLevels.length,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _token = token;
    getProfileData();
  }

  getProfileData() async {
    print("calling profile ${_token}");
    profileData = await profile(_token);
    cardLevels = [
      for (int i = profileData.level; i < profileData.level + 10; i++) i
    ];
    setState(() {
      showLoading = false;
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
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: Text(
              "Levels",
              style: GoogleFonts.poppins(color: Colors.black),
            ),
            elevation: 0,
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  FontAwesomeIcons.wallet,
                  color: Colors.black,
                ),
                onPressed: () {},
              )
            ]),
        body: showLoading
            ? Center(
                child: CupertinoActivityIndicator(
                radius: 30.h,
              ))
            : Padding(
                padding: EdgeInsets.only(top: 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // PaddingWidget(
                    //   child: Text(
                    //     "Levels",
                    //     style: GoogleFonts.poppins(
                    //         fontSize: 45.sp, fontWeight: FontWeight.w400),
                    //   ),
                    //   hor: 50.w,
                    //   ver: 0,
                    // ),
                    Expanded(child: listOfLevelCards()),
                  ],
                ),
              ),
      ),
    );
  }
}

class LevelCardWidget extends StatelessWidget {
  const LevelCardWidget({Key key, @required this.level}) : super(key: key);

  final int level;

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Container(
        height: 400.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: colors["blueLevelCard"],
          borderRadius: BorderRadius.circular(20.w),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                height: 400.h,
                child: Center(
                    child: Icon(
                  FontAwesomeIcons.award,
                  size: 200.h,
                )),
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: EdgeInsets.only(left: 20.w),
                height: 400.h,
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                    color: Color(0xffEFEBFA),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60.w),
                        bottomLeft: Radius.circular(60.w),
                        topRight: Radius.circular(20.w),
                        bottomRight: Radius.circular(20.w))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text("LEVEL $level",
                        style: GoogleFonts.poppins(
                            fontSize: 50.sp,
                            fontWeight: FontWeight.bold,
                            color: colors["blueLevelCard"])),
                    Row(
                      children: <Widget>[
                        LevelCardText(
                            text: "Tasks: ", color: colors["blueLevelCard"]),
                        SizedBox(
                          width: 20.w,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              LevelCardText(
                                  text: "Earn atleast 2000 Rupees.",
                                  color: colors["blueLevelCard"]),
                              LevelCardText(
                                  text: "Complete X training.",
                                  color: colors["blueLevelCard"])
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        LevelCardText(
                            text: "Perks: ", color: colors["blueLevelCard"]),
                        SizedBox(
                          width: 20.w,
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              LevelCardText(
                                  text:
                                      "Get 20% hike on your telecalls for a week.",
                                  color: colors["blueLevelCard"]),
                              LevelCardText(
                                text: "Get Rs.100 bonus.",
                                color: colors["blueLevelCard"],
                              )
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      hor: 20.w,
      ver: 30.h,
    );
  }
}

class LevelCardWidgetUnlocked extends StatelessWidget {
  const LevelCardWidgetUnlocked({Key key, @required this.level})
      : super(key: key);

  final int level;

  @override
  Widget build(BuildContext context) {
    return PaddingWidget(
      child: Stack(
        children: <Widget>[
          Container(
            height: 400.h,
            width: double.infinity,
            decoration: BoxDecoration(
              color: colors["blackCardUnlocked"],
              borderRadius: BorderRadius.circular(20.w),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  flex: 3,
                  child: Container(
                    height: 400.h,
                    child: Center(
                        child: Icon(
                      FontAwesomeIcons.award,
                      size: 200.h,
                    )),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    padding: EdgeInsets.only(left: 20.w),
                    height: 400.h,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                        color: Color(0xff363637),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(60.w),
                            bottomLeft: Radius.circular(60.w),
                            topRight: Radius.circular(20.w),
                            bottomRight: Radius.circular(20.w))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("LEVEL $level",
                            style: GoogleFonts.poppins(
                                fontSize: 50.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff4D4D4D))),
                        Row(
                          children: <Widget>[
                            LevelCardText(
                                text: "Tasks: ", color: Color(0xff4D4D4D)),
                            SizedBox(
                              width: 20.w,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  LevelCardText(
                                      text: "Earn atleast 2000 Rupees.",
                                      color: Color(0xff4D4D4D)),
                                  LevelCardText(
                                      text: "Complete X training.",
                                      color: Color(0xff4D4D4D))
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            LevelCardText(
                                text: "Perks: ", color: Color(0xff4D4D4D)),
                            SizedBox(
                              width: 20.w,
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  LevelCardText(
                                      text:
                                          "Get 20% hike on your telecalls for a week.",
                                      color: Color(0xff4D4D4D)),
                                  LevelCardText(
                                      text: "Get Rs.100 bonus.",
                                      color: Color(0xff4D4D4D))
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 400.h,
            width: double.infinity,
            child: Center(
              child: Icon(
                Icons.lock_outline,
                color: Colors.white,
                size: 100.h,
              ),
            ),
          )
        ],
      ),
      hor: 20.w,
      ver: 30.h,
    );
  }
}

class LevelCardText extends StatelessWidget {
  const LevelCardText({Key key, @required this.text, @required this.color})
      : super(key: key);

  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        text,
        style: GoogleFonts.poppins(fontSize: 20.sp, color: color),
      ),
    );
  }
}

class PaddingWidget extends StatelessWidget {
  const PaddingWidget({
    Key key,
    @required this.child,
    this.hor,
    this.ver,
  }) : super(key: key);

  final Widget child;
  final double hor, ver;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: hor, vertical: ver),
      child: child,
    );
  }
}
