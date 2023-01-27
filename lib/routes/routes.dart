
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/screen/home_screen.dart';
import 'package:golf_booking/screen/splash_screen.dart';
import 'package:golf_booking/user/view/login_index_screen.dart';
import 'package:golf_booking/user/view/login_screen.dart';
import 'package:golf_booking/user/view/signup_screen.dart';

Map<String, WidgetBuilder> getApplicationRoutes() {
  return <String, WidgetBuilder>{
    // '/': (BuildContext context) => AppDrawer(child: Home()),
    '/': (BuildContext contex) => HomeScreen(),
    'splash': (BuildContext contex) => Splash_Screen(),
    'auth': (BuildContext contex) => Login_Screen(),
    'auth-index' : (BuildContext contex) => Login_Index_Screen(),
    'signup' : (BuildContext contex) => Signup_Screen(),
    // 'favorites': (BuildContext contex) => NoFavorites(),
    // 'checkout': (BuildContext contex) => Checkout(),
    // 'busqueda': (BuildContext contex) => SearchScreen(),
  };
}
