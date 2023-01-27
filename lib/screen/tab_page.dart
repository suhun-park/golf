import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/screen/booking_screen.dart';
import 'package:golf_booking/screen/home_screen.dart';
import 'package:golf_booking/screen/profile_screen.dart';
import 'package:golf_booking/screen/saved_booking.dart';

class Home extends StatefulWidget {
  @override
  State createState() {
    return _HomeState();
  }
}

class _HomeState extends State {
  @override
  int _currentIndex = 0;
  final List _children = [
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
    HomeScreen(),
  ];
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff2f2f2),
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        selectedItemColor: Styles.backgroundColor,
        iconSize: 30,
        elevation: 0.9,
        backgroundColor: const Color(0xfff2f2f2),
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined, color: Color(0xff2f6f38)),
              label: 'Home',
              activeIcon: Icon(
                Icons.home,
                color: Color(0xff2f6f38),
              )),
          BottomNavigationBarItem(
              icon:
              Icon(Icons.receipt_outlined, color: Color(0xff200E32)),
              backgroundColor: Color(0xfff2f2f2),
              label: '예약하기',
              activeIcon: Icon(
                Icons.shopping_cart,
                color: Color(0xff5956E9),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border_outlined,
                  color: Color(0xff200E32)),
              backgroundColor: Color(0xfff2f2f2),
              label: '최근예약',
              activeIcon: Icon(
                Icons.favorite,
                color: Color(0xff5956E9),
              )),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline, color: Color(0xff200E32)),
              backgroundColor: Color(0xfff2f2f2),
              label: '프로필',
              activeIcon: Icon(
                Icons.person,
                color: Color(0xff5956E9),
              )),

        ],
      ),
    );
  }

  void onTabTapped(int index) {
    Widget page = Home();
    switch (index) {
      case 1:
        page = BookingScreen();
        break;
      case 2:
        page = SavedBooking();
        break;
      case 3:
        page = ProfileScreen();
        break;
    }
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => page),
    );
    // setState(() {
    //   _currentIndex = index;
    //   print(index);
    // });
  }
}
