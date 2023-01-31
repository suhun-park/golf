import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakaouser;
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../../../../screen/home_screen.dart';
import '../../component/data.dart';

class SignUpScreen extends StatefulWidget {
  final String? verificationId;

  const SignUpScreen({required this.verificationId, Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}
  FirebaseFirestore firestore = FirebaseFirestore.instance;

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  final FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();

  Widget build(BuildContext context) {
    String phoneText;
    String userName ="";
    TextEditingController userNameInput = TextEditingController();
    TextEditingController phoneVerifyCode = TextEditingController();
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    );
    return
      Scaffold(
          body:Column(children: [
            const SizedBox(
              height: 200,
            ),
            TextFormField(
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                hintText: "이름",
                border: baseBorder,
                contentPadding: EdgeInsets.all(20),
                fillColor: Colors.black,
              ),
              controller: userNameInput,
              onChanged: (String value) {
                userName = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                hintText: "6자리",
                border: baseBorder,
                contentPadding: EdgeInsets.all(20),
                fillColor: Colors.black,
              ),
              controller: phoneVerifyCode,
              onChanged: (String value) {
                phoneText = value;
              },
            ),
            TextButton(onPressed: ()async{
              final credential = PhoneAuthProvider.credential(
                  verificationId: widget.verificationId.toString(),
                  smsCode: phoneVerifyCode.text.toString());
              try {
                kakaouser.User? kuser;
                kuser = await UserApi.instance.me();
                final token  = await auth.signInWithCredential(credential);
                await storage.write(key: FIREBASE_TOKEN_KEY, value: token.user?.uid);
                await  FirebaseFirestore.instance
                    .collection('user')
                    .doc()
                    .set(
                  {
                    'uid': token.user?.uid,
                    'userId': kuser.kakaoAccount?.profile?.nickname,
                    'userName': userName,
                    "userPhone" : token.user?.phoneNumber,
                    'userEmail' :  kuser.kakaoAccount?.email,
                  },
                );
                print(token);
                print(token.user?.uid);
                print(token.user?.phoneNumber);
                Navigator.push(context, MaterialPageRoute(builder: (Context) => HomeScreen() ));

              }catch(e){
                //context.read<IsLoginedController>().loadingAction();
                print(e);
              }

            }, child: Text("인증"))

          ]));
  }
}
