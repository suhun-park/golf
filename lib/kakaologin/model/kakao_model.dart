import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../component/social_login.dart';

class KakaoModel {
  final SocialLogin _socialLogin;
  bool isLogined =false;
  User? user;


  KakaoModel(this._socialLogin);
  Future login() async {
    isLogined =await _socialLogin.login();
    if(isLogined) {
      user = await UserApi.instance.me();
      print(user);
    }
  }
  Future logout() async {
    await _socialLogin.logout();
    isLogined = false;
    user = null;
  }
}