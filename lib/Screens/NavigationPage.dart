import 'package:employeeindia_atg/Screens/ApplyJob.dart';
import 'package:employeeindia_atg/Screens/HomePage.dart';
import 'package:employeeindia_atg/Screens/LevelPage.dart';
import 'package:employeeindia_atg/Screens/MyWorkPage.dart';
import 'package:employeeindia_atg/Screens/ProfilePage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationPage extends StatefulWidget {
  // NavigationPage({this.token});
  // final String token;

  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  static String token;

  List<Widget> _screens = <Widget>[
    HomePage(),
    MyWorkPage(),
    LevelPage(),
    ProfilePage(),
    ApplyJob()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // token = widget.token;
    print(token);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(
        width: 720,
        height: 1280,
        allowFontScaling: false); //flutter_screenuitl >= 1.2

    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
          selectedFontSize: 18.sp,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text('Home'),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.shoppingBasket,
                size: 40.h,
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 1.5),
                child: Text('My Work'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.star,
                size: 40.h,
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 1.5),
                child: Text('Levels'),
              ),
            ),
            BottomNavigationBarItem(
              icon: Icon(
                FontAwesomeIcons.user,
                size: 40.h,
              ),
              title: Padding(
                padding: EdgeInsets.only(top: 1.5),
                child: Text('Profile'),
              ),
            ),
          ],
          selectedIconTheme: IconThemeData(color: Colors.orange),
          unselectedIconTheme: IconThemeData(color: Color(0xff2C2C2C)),
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped,
        ),
        body: _screens.elementAt(_selectedIndex),
      ),
    );
  }
}
