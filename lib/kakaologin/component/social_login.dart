import 'dart:convert';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';
import 'package:http/http.dart'as http;

import '../model/kakao_model.dart';
import 'data.dart';

abstract class SocialLogin{
  Future<bool> login();
  Future<bool> logout();
}
class KakaoLogin implements SocialLogin{
  final storage = FlutterSecureStorage();
  @override
  Future<bool> login() async {
   try {
     bool isInstalled = await isKakaoTalkInstalled();
     if(isInstalled) {
       try {
         await UserApi.instance.loginWithKakaoTalk();
         String authCode = await AuthCodeClient.instance.toString();
         print(authCode);
         return true;
       } catch (e) {
         return false;
       }
     }else {
       try {
         OAuthToken token = await UserApi.instance.loginWithKakaoAccount();
         print(token);
         print(token.accessToken);

         final url = Uri.https('kapi.kakao.com', '/v2/user/me');

         final response = await http.get(
           url,
           headers: {
             HttpHeaders.authorizationHeader: 'Bearer ${token.accessToken}'
           },
         );
         final profileInfo = json.decode(response.body);
         await storage.write(key: ACCESS_TOKEN_KEY, value: token.accessToken);
         await storage.write(key: REFRESH_TOKEN_KEY,value: token.refreshToken);
         TokenManagerProvider.instance.manager.setToken(token);
         final viewModel = KakaoModel(KakaoLogin());
         print(viewModel.user?.kakaoAccount?.profile);
         print(viewModel.user?.kakaoAccount?.email);
         return true;
       }catch(e){
         return false;
       }
     }
   } catch (error) {
      return false;
   }
  }

  @override
  Future<bool> logout() async{
  try{
    await UserApi.instance.unlink();
    return true;
  }catch(e){
    return false;
  }
  }

}
