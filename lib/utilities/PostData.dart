import 'dart:convert';

class Post {
  String access;
  String refresh, expiry;

  String detail;
  String message;

  // profile Variables
  String employeeName;
  String perks;
  int level;
  String balance;

  // submitWork Var
  String status;

  // Get all gigs
  String id;
  String company_name;
  String work_type;
  String profile_image;
  String total_target;
  String target_achieved;
  String description;
  String requirements;
  List<dynamic> gigs;

  Post.login({this.access, this.refresh, this.expiry});
  Post.forgotPassword({this.detail});
  Post.signUp({this.message});
  Post.profile({this.employeeName, this.perks, this.level, this.balance});
  Post.submitWork({this.status});
  Post.getAllGigs({this.gigs});

  factory Post.fromJson(String val, Map<String, dynamic> json) {
    Post data;
    if (val == "login") {
      data = Post.login(
          // name: json['name'],
          access: json['access'],
          refresh: json['refresh'],
          expiry: json['expiry']);
    }

    if (val == "forgotPassword") {
      data = Post.forgotPassword(detail: json['detail']);
    }

    if (val == "signUp") {
      data = Post.signUp(message: json['message']);
    }

    if (val == 'profile') {
      data = Post.profile(
        employeeName: json["Employee Name"],
        perks: json["Current Perks"],
        level: json["Current Level"],
        balance: json["Current Balance"],
      );
    }

    if (val == 'submitWork') {
      data = Post.submitWork(
        status: json["Status"],
      );
    }

    if (val == "getAllGigs") {
      data = Post.getAllGigs(gigs: json["gigs"]);
    }

    return data;
  }

  // Map toMap() {
  //   var map = new Map<String, String>();
  //   map['email'] = email;
  //   map['password'] = password;

  //   return map;
  // }
}
