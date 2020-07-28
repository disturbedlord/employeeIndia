import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BankDetailsPage extends StatefulWidget {
  @override
  _BankDetailsPageState createState() => _BankDetailsPageState();
}

class _BankDetailsPageState extends State<BankDetailsPage> {
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
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.pop(context),
          ),
          backgroundColor: Colors.white,
          title: Text(
            "Add Bank Details",
            style: GoogleFonts.poppins(color: Colors.black),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: <Widget>[
              BankInputFields(text: "Account Number"),
              SizedBox(
                height: 20.h,
              ),
              BankInputFields(text: "Ifsc Code"),
              SizedBox(
                height: 20.h,
              ),
              BankInputFields(text: "UPI"),
              SizedBox(
                height: 30.h,
              ),
              FlatButton(
                color: Colors.red[300],
                child: Text("Save"),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}

class BankInputFields extends StatelessWidget {
  const BankInputFields({
    Key key,
    @required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          hintText: text,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10))),
    );
  }
}
