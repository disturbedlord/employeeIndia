import 'dart:convert';
import 'package:clipboard/clipboard.dart';
import 'package:employeeindia_atg/Screens/persistenceDataModel.dart';
import 'package:employeeindia_atg/utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';

// enum WhyFarther { harder, smarter, selfStarter, tradingCharter }

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
    print(postData.gigs);
    persMyGigs = postData;
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

    // print(reloadData);
    // if (reloadData || persMyGigs == null) {
    // } else {
    //   data = persMyGigs.gigs;
    //   if (data.length == 0) {
    //     setState(() {
    //       showNoGigs = true;
    //     });
    //   }
    //   setState(() {
    //     showLoader = false;
    //   });
    // }
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
            style: GoogleFonts.poppins(color: Colors.black, fontSize: 35.sp),
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
        decoration: BoxDecoration(
            color: Color(0xffBD5336),
            borderRadius: BorderRadius.circular(40.w)),
        child: Stack(
          children: <Widget>[
            Positioned(
              right: 0,
              top: 250.h - 50.h,
              child: Container(
                width: 200.w,
                height: 100.h,
                padding: EdgeInsets.all(15.h),
                decoration: BoxDecoration(
                  color: Color(0xffFFD645),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      bottomLeft: Radius.circular(20.0)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Rs ${data["earned"].toString()}",
                      style: GoogleFonts.poppins(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: colors["darkBrown"]),
                    ),
                    Text(
                      "Rs ${data["bonus"].toString()} bonus",
                      style: GoogleFonts.poppins(
                          fontSize: 15.sp,
                          color: colors["darkBrown"],
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
            Container(
              height: 500.h,
              width: MediaQuery.of(context).size.width - 80.w,
              decoration: BoxDecoration(
                  color: Colors.transparent,
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
                      PopupMenuButton<String>(
                          color: Colors.white,
                          icon: Icon(
                            FontAwesomeIcons.ellipsisV,
                            color: Colors.white,
                            size: 38.h,
                          ),
                          onSelected: (String result) {
                            // ClipboardManager.copyToClipBoard(result)
                            //     .then((result) {
                            //   final snackBar = SnackBar(
                            //     content: Text('Copied to Clipboard'),
                            //     action: SnackBarAction(
                            //       label: 'Undo',
                            //       onPressed: () {},
                            //     ),
                            //   );
                            //   Scaffold.of(context).showSnackBar(snackBar);
                            // });
                            FlutterClipboard.copy(result).then((value) =>
                                Toast.show("Copied", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM));
                          },
                          itemBuilder: (BuildContext context) =>
                              <PopupMenuEntry<String>>[
                                PopupMenuItem<String>(
                                  value: referralID,
                                  child: Text("Referral ID"),
                                )
                              ])
                    ],
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            TextWidgetWithYellowBorder(
                                dataText: "Total Target",
                                data: data["total_target"]),
                            SizedBox(
                              height: 30.h,
                            ),
                            TextWidgetWithYellowBorder(
                                dataText: "Your Target",
                                data: data["your_target"]),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            TextWidgetWithYellowBorder(
                                dataText: "Target Achieved",
                                data: data["target_achieved"]),
                            SizedBox(
                              height: 30.h,
                            ),
                            TextWidgetWithYellowBorder(
                              dataText: "Your Target Achieved",
                              data: data["your_target_achieved"],
                            )
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Opacity(
                              opacity: 0,
                              child: TextWidgetWithYellowBorder(
                                  dataText: "Weekly Target",
                                  data: data["weekly_target"]),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            TextWidgetWithYellowBorder(
                                dataText: "Weekly Target",
                                data: data["weekly_target"])
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TextWidgetWithYellowBorder extends StatelessWidget {
  const TextWidgetWithYellowBorder({
    Key key,
    @required this.data,
    @required this.dataText,
  }) : super(key: key);
  final String dataText;
  final dynamic data;
  static Color yellowColor = Color(0xffFFD645);
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          width: 180.w,
          height: 120.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.h),
            border: Border.all(
              width: 5,
              color: yellowColor,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: Center(
              child: Text(
                data.toString(),
                style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 30.sp),
              ),
            ),
          ),
        ),
        Positioned(
          left: -10.w,
          top: -10.h,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            // width: 160.w,
            decoration: BoxDecoration(
                color: yellowColor, borderRadius: BorderRadius.circular(20)),
            child: Center(
              child: Text(
                dataText,
                style: GoogleFonts.poppins(
                    fontSize: 15.sp,
                    color: colors["darkBrown"],
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }
}
