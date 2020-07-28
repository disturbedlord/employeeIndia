import 'dart:convert';

import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ApplyJob extends StatefulWidget {
  final Map<String, dynamic> data;
  ApplyJob({this.data});
  @override
  _ApplyJobState createState() => _ApplyJobState();
}

class _ApplyJobState extends State<ApplyJob> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.data);
  }

  applyGig(String gigId) async {
    final String url = "https://employedindia.in/api/addgigs/";

    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, String>{
          "gig_id": gigId,
        }));
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
          backgroundColor: Color(0xffAC3F21),
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          elevation: 0,
        ),
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 3,
              child: Container(
                color: Color(0xffAC3F21),
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width / 2,
                        child: Text(
                          widget.data["work_type"],
                          style: GoogleFonts.poppins(
                              color: Colors.white, fontSize: 60.sp),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      child: Text(
                        widget.data["description"],
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ),
                    Container(
                      child: Text(
                        "\nRequirements",
                        style: GoogleFonts.poppins(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: Text(widget.data["requirements"],
                          style: GoogleFonts.poppins(fontSize: 14)),
                    )
                  ],
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                applyGig(widget.data["id"].toString());
              },
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                color: Color(0xffAC3F21),
                width: double.infinity,
                child: Center(
                  child: Text(
                    "Apply Now",
                    style: GoogleFonts.poppins(color: Colors.white),
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
