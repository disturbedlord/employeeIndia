import 'dart:convert';

import 'package:employeeindia_atg/Screens/persistenceDataModel.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:employeeindia_atg/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class ApplyJob extends StatefulWidget {
  final Map<String, dynamic> data;
  ApplyJob({this.data});
  @override
  _ApplyJobState createState() => _ApplyJobState();
}

class _ApplyJobState extends State<ApplyJob> {
  bool showAppliedGif = false;
  Post appliedGig;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // print(widget.data);
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

    print(response.body);
    if (response.statusCode == 200) {
      return Post.fromJson("addGig", json.decode(response.body));
    } else {
      print(response.body);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 720,
        height: 1280,
        allowFontScaling: false); //flutter_screenuitl >= 1.2
    return SafeArea(
      child: Scaffold(
        appBar: !showAppliedGif
            ? AppBar(
                backgroundColor: Color(0xffAC3F21),
                leading: Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                elevation: 0,
              )
            : AppBar(
                backgroundColor: Color(0xffAC3F21),
                leading: Container(
                  margin: EdgeInsets.all(5),
                  child: FloatingActionButton(
                    backgroundColor: Colors.black,
                    onPressed: () => {
                      setState(() {
                        showAppliedGif = false;
                      })
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    ),
                  ),
                ),
                elevation: 0,
              ),
        body: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Container(
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
                    Padding(
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
                    GestureDetector(
                      onTap: () async {
                        // print("$referralLink jjj");
                        // print(widget.data["id"]);
                        if (appliedGigs.contains(widget.data["id"])) {
                          Toast.show("Already applied to this job", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        } else {
                          print(widget.data["id"]);
                          reloadData = true;

                          appliedGig =
                              await applyGig(widget.data["id"].toString());
                          print(appliedGig.message);
                          if (appliedGig.addGigMessage != null) {
                            referralLink = appliedGig.referral;
                            appliedGigs.add(widget.data["id"]);
                            setState(() {
                              showAppliedGif = true;
                            });
                          } else {
                            print(appliedGigs);
                            String res = "";
                            if (appliedGig.non_field_errors != null) {
                              res = appliedGig.non_field_errors;
                            } else {
                              res = appliedGig.error;
                            }

                            Toast.show(res, context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                            // setState(() {
                            //   showAppliedGif = true;
                            // });
                          }
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 40.h),
                        color: appliedGigs.contains(widget.data["id"])
                            ? Colors.grey
                            : Color(0xffAC3F21),
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
            ),
            showAppliedGif
                ? Container(
                    decoration: BoxDecoration(color: colors["brown"]),
                    child: Center(
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.checkCircle,
                              color: Colors.white,
                              size: 120.h,
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              "Applied",
                              style: GoogleFonts.poppins(
                                  fontSize: 18, color: Colors.white),
                            ),
                            SizedBox(
                              height: 30.h,
                            ),
                            Text(
                              appliedGig.referral,
                              style: GoogleFonts.poppins(
                                  color: Colors.greenAccent),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
