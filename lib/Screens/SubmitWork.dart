import 'dart:convert';

import 'package:employeeindia_atg/utilities/PostData.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'package:toast/toast.dart';

class SubmitWork extends StatefulWidget {
  final String token;
  SubmitWork({this.token});
  @override
  _SubmitWorkState createState() => _SubmitWorkState();
}

Future<Post> submitWork(String access, String category, String workDone) async {
  // print(url);
  // print(email);
  print(access);

  String url = "https://employedindia.in/api/submit/";

  List<String> tasks = ['App Downloads', 'TeleCalls', 'Other'];

  String task = (tasks.indexOf(category) + 1).toString();
  final http.Response response = await http.post(url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $access'
      },
      body: jsonEncode(<String, String>{
        'Authorization': 'Bearer $access',
        'task': task,
        'work_amount': workDone,
      }));

  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 200) {
    return Post.fromJson("submitWork", json.decode(response.body));
  } else {
    print(response.body);
  }
}

class _SubmitWorkState extends State<SubmitWork> {
  String dropDownValue = "App Downloads";
  TextEditingController workAmount = new TextEditingController();
  Post submitData;

  // showResponse(String res) {

  // }

  submit(String cat, String workAmount) async {
    submitData = await submitWork(widget.token, cat, workAmount);
    print(submitData.status);
    if (submitData != null) {
      Toast.show(submitData.status, context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
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
        appBar: AppBar(
          elevation: 0.7,
          backgroundColor: Colors.white,
          title: Text(
            "Submit Your Work",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
          ),
        ),
        body: Column(
          children: <Widget>[
            DropdownButton<String>(
              value: dropDownValue,
              items: <String>[
                'App Downloads',
                'TeleCalls',
                'Other',
              ].map((String value) {
                return new DropdownMenuItem<String>(
                  value: value,
                  child: new Text(value),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  dropDownValue = value;
                });
              },
            ),
            TextField(
              controller: workAmount,
              decoration: InputDecoration(hintText: "Work Amount"),
            ),
            SizedBox(
              height: 50.h,
            ),
            RaisedButton(
              onPressed: () {
                submit(dropDownValue, workAmount.text);
              },
              child: Text("Submit"),
            )
          ],
        ),
      ),
    );
  }
}
