import 'dart:convert';

import 'package:employeeindia_atg/Screens/BankdetailsPage.dart';
import 'package:employeeindia_atg/Screens/tokenClass.dart';
import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
    getProfileData();
  }

  getProfileData() async {
    profileData = await profile(token);
    setState(() {
      gotProfileData = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey[50],
            elevation: 0,
            title: Text(
              "Profile",
              style: GoogleFonts.poppins(color: Colors.black),
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
                ? SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                          maxHeight: MediaQuery.of(context).size.height),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 3,
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    color: Color(0xffFFB700),
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    CircleAvatar(
                                      child: Icon(
                                        FontAwesomeIcons.user,
                                        size: 50.0,
                                      ),
                                      radius: 50.0,
                                    ),
                                    Text(
                                      "UserName",
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        color: Color(0xffAC3F21),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Expanded(
                              flex: 6,
                              child: Container(
                                child: Column(
                                  children: <Widget>[
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ProfilePersonalSection(text: "About"),
                                        ProfilePersonalSection(text: "Skills")
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20.0,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ProfilePersonalSection(text: "Work"),
                                        GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          BankDetailsPage()));
                                            },
                                            child: ProfilePersonalSection(
                                                text: "Setting"))
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                : CupertinoActivityIndicator(),
          )),
    );
  }
}

class ProfilePersonalSection extends StatelessWidget {
  const ProfilePersonalSection({Key key, @required this.text})
      : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      decoration: BoxDecoration(
          color: Color(0xffFFb700), borderRadius: BorderRadius.circular(20)),
      child: Center(
        child: Text(
          text,
          style: GoogleFonts.poppins(color: Color(0xffAC3F21)),
        ),
      ),
    );
  }
}
