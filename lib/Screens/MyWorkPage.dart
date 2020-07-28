import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:flutter/material.dart';
import 'package:employeeindia_atg/Screens/HomePage.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class MyWorkPage extends StatefulWidget {
  @override
  _MyWorkPageState createState() => _MyWorkPageState();
}

Future<Post> getAllGigs(String token) async {
  String url = "https://employedindia.in/api/mygigs/";

  final http.Response response = await http.get(
    url,
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    },
  );
  print(response.body);
  print(response.statusCode);
  // print(response.body);
  if (response.statusCode == 200) {
    return Post.fromJson("getAllGigs", json.decode(response.body));
  } else {
    print(response);
  }
}

class _MyWorkPageState extends State<MyWorkPage> {
  bool showLoader = true;
  List<dynamic> data;
  Post postData;
  bool showNoGigs = false;

  Widget myGigs() {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext ctxt, int index) {
        return GigsCard(
          data: data[index],
        );
      },
    );
  }

  noGigsMsg() {
    return Center(
      child: Text("You don't have any gigs yet!!"),
    );
  }

  myGigsFetcher(String token) async {
    postData = await getAllGigs(token);

    data = postData.gigs;
    if (data.length == 0) {
      showNoGigs = true;
    }
    setState(() {
      showLoader = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myGigsFetcher(token);
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
          elevation: 0,
          title: Text(
            "My Work",
            style: GoogleFonts.poppins(color: Colors.black),
          ),
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
          ],
        ),
        body: showLoader
            ? Center(child: CupertinoActivityIndicator())
            : Container(
                padding: EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
                child: showNoGigs ? noGigsMsg() : myGigs(),
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
      child: Container(
        width: MediaQuery.of(context).size.width - 80.w,
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
                    "https://employedindia.in${data["profile_image"]}",
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.h),
                      border: Border.all(
                        width: 5,
                        color: Color(0xffFFD645),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 9.0),
                      child: Text(
                        data["total_target"].toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 40.w,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.h),
                      border: Border.all(
                        width: 5,
                        color: Color(0xffFFD645),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30.0, vertical: 9.0),
                      child: Text(
                        data["target_achieved"].toString(),
                        style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp),
                      ),
                    ),
                  )
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
                  "Rs 2600 - Rs 4000",
                  style: GoogleFonts.poppins(
                      color: Color(0xff8C3017), fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
