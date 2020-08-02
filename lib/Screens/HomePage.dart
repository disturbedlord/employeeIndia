import 'dart:convert';
import 'package:employeeindia_atg/Screens/ApplyJob.dart';
import 'package:employeeindia_atg/Screens/MyWorkPage.dart';
import 'package:employeeindia_atg/Screens/PaymentSlipPage.dart';
import 'package:employeeindia_atg/Screens/persistenceDataModel.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import "package:http/http.dart" as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

Future<Post> getAllGigs(String token) async {
  print("home");
  String url = "https://employedindia.in/api/allgigs/";

  final http.Response response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );

  print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    return Post.fromJson("getAllGigs", json.decode(response.body));
  } else {
    print(response);
  }
}

class _HomePageState extends State<HomePage> {
  Post postData;
  List<dynamic> data;
  bool showLoader = true;
  bool showErrorPage = false;
  List<Widget> trendingGigsList = [];

  List<Widget> trendingGigs() {
    if (trendingGigsList.length != data.length) {
      for (var i = 0; i < data.length; i++) {
        trendingGigsList.add(Container(
          child: GigsCard(
            data: data[i],
          ),
        ));
      }
    }
    return trendingGigsList;
  }

  allGigs(String token) async {
    postData = await getAllGigs(token);
    if (postData == null) {
      setState(() {
        showErrorPage = true;
      });
    }
    persTrendingGigs = postData;
    print(postData.gigs.length);
    data = postData.gigs;
    print(data);
    setState(() {
      showLoader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    referralID = persProfile.referralID;

    if (persTrendingGigs == null) {
      allGigs(token);
    } else {
      setState(() {
        showLoader = false;
      });
      data = persTrendingGigs.gigs;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 720,
        height: 1280,
        allowFontScaling: false); //flutter_screenuitl >= 1.2
    return SafeArea(
      child: showErrorPage
          ? Scaffold(
              body: Center(
                child: Text(
                  "Something went wrong!!!",
                  style:
                      GoogleFonts.poppins(color: Colors.black, fontSize: 30.sp),
                ),
              ),
            )
          : Scaffold(
              backgroundColor: Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {},
                  icon: Icon(FontAwesomeIcons.bars),
                  color: Colors.black,
                  iconSize: 40.h,
                ),
                centerTitle: true,
                title: Text(
                  "Level ${persProfile.level}",
                  style: TextStyle(color: Colors.black, fontSize: 30.sp),
                ),
                actions: <Widget>[
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => PaymentSlip()),
                      );
                    },
                    icon: Icon(FontAwesomeIcons.rupeeSign),
                    color: Colors.black,
                    iconSize: 40.h,
                  )
                ],
              ),
              body: showLoader
                  ? Center(
                      child: CupertinoActivityIndicator(
                      radius: 30.h,
                    ))
                  : Padding(
                      padding: EdgeInsets.only(left: 30.w, right: 30.w),
                      child: ListView(children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                              minHeight: MediaQuery.of(context).size.height +
                                          trendingGigsList.length *
                                              trendingGigsList.length ==
                                      1
                                  ? 0.h
                                  : 180.h),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(top: 10.0),
                                child: Container(
                                    height: 150.h,
                                    decoration: BoxDecoration(
                                      color: Color(0xffE8F1FD),
                                      borderRadius: BorderRadius.circular(30.h),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          "Hello, ",
                                          style: GoogleFonts.poppins(
                                              fontSize: 30.sp),
                                        ),
                                        Text(
                                          "${persProfile.employeeName}!",
                                          style: GoogleFonts.poppins(
                                              fontSize: 30.sp,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    )),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 10.0, bottom: 10.0, left: 5.0),
                                    child: Text(
                                      "Categories",
                                      style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35.sp),
                                    ),
                                  ),
                                  CategoriesWidgetRow(
                                    txt1: "Digital Marketing",
                                    color1: Color(0xffF75266),
                                    txt2: "Brand Marketing",
                                    color2: Color(0xff3FCEDE),
                                  ),
                                  SizedBox(
                                    height: 30.h,
                                  ),
                                  CategoriesWidgetRow(
                                    txt1: "Telecaller Marketing",
                                    color1: Color(0xff704DFA),
                                    txt2: "Field Marketing",
                                    color2: Color(0xffF68A35),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 00.0, bottom: 10.0, left: 5.0),
                                  child: Text(
                                    "Trending Gigs",
                                    style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 35.sp),
                                  ),
                                ),
                              ),
                              Column(
                                children: trendingGigs(),
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
            ),
    );
  }
}

class GigsCard extends StatelessWidget {
  const GigsCard({
    Key key,
    @required this.data,
  }) : super(key: key);

  final Map<String, dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ApplyJob(
                      data: data,
                    )),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 80.w,
          height: 500.h,
          decoration: BoxDecoration(
              color: Color(0xffBD5336),
              borderRadius: BorderRadius.circular(40.w)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Image.network(
                      data["profile_image"],
                      height: 50.h,
                      width: 50.h,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        data["company_name"],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Color(0xffFFD645),
                            fontSize: 30.sp),
                      ),
                      Text(
                        data["work_type"],
                        style: GoogleFonts.poppins(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20.sp),
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      FontAwesomeIcons.ellipsisV,
                      color: Colors.white,
                      size: 40.h,
                    ),
                    onPressed: () {},
                  )
                ],
              ),
              Container(
                height: 200.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    TextWidgetWithYellowBorder(
                      data: data["total_company_target"],
                      dataText: "Total Target",
                    ),
                    TextWidgetWithYellowBorder(
                      data: data["target_left"],
                      dataText: "Target Left",
                    ),
                  ],
                ),
              ),
              Container(
                height: 100.h,
                margin: EdgeInsets.only(bottom: 20.h),
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(20.w),
                  decoration: BoxDecoration(
                      color: Color(0xffFFD645),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.h),
                          bottomLeft: Radius.circular(30.h))),
                  child: Text(
                    "Rs ${data["min_earning"]} - Rs ${data["max_earning"]}",
                    style: GoogleFonts.poppins(
                        color: Color(0xff8C3017), fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesWidgetRow extends StatelessWidget {
  const CategoriesWidgetRow({
    Key key,
    @required this.txt1,
    @required this.txt2,
    @required this.color1,
    @required this.color2,
  }) : super(key: key);

  final String txt1, txt2;
  final Color color1, color2;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Container(
            height: 150.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.h), color: color1),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(txt1,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 28.sp))
              ],
            ),
          ),
        ),
        SizedBox(
          width: 30.w,
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 150.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.h), color: color2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(txt2,
                    style: GoogleFonts.poppins(
                        color: Colors.white, fontSize: 28.sp))
              ],
            ),
          ),
        ),
      ],
    );
  }
}
