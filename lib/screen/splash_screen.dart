import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/payment/view/payment_screen.dart';
import 'package:golf_booking/screen/home_screen.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart' as http;

import '../user/login/firebaselogin/view/login_screen.dart';
import '../user/login/kakaologin/component/data.dart';
import '../user/login/kakaologin/component/social_login.dart';
import '../user/login/kakaologin/model/kakao_model.dart';
import '../user/view/login_index_screen.dart';

class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  State<Splash_Screen> createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  final storage = FlutterSecureStorage();
  final viewModel = KakaoModel(KakaoLogin());
  void initState() {
    super.initState();
    checkToken();
  }
  void checkToken() async{
    OAuthToken? token = await TokenManagerProvider.instance.manager.getToken();
    if(token?.refreshToken !=null){
    try {
      await storage.write(key: ACCESS_TOKEN_KEY, value: token?.accessToken);
      Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
    }catch(e) {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => Login_Index_Screen()),
              (route) => false);
    }
  }else{
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
              builder: (_) => Login_Index_Screen()),
              (route) => false);
    }
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle style =
    ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(51.0, 70.0, 0.0, 0.0),
              child: Center(
                child: Text('파크고에서 \n골프예약과 \n장비 구매까지',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 55.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.start),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 20.0),
                child: Container(
                    child: const Image(
                        image: AssetImage('assets/images/customlogo.png'),
                        fit: BoxFit.contain))),
            SizedBox(height: 40.0,),
           /* ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                onPrimary: Styles.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 80,
                  vertical: 22,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),
              onPressed: () {
                // Navigator.pushReplacementNamed(context, "auth-index");
                //Navigator.pushReplacementNamed(context, "/");
                Navigator.push(context,MaterialPageRoute(builder: (context) => Login_Index_Screen()));
              },
              child: const Text('시작하기'),
            )*/
          ],
        ),
      ),
    );
  }
}
