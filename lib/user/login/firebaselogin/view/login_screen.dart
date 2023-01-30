import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/user/login/firebaselogin/view/signup_screen.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;

    TextEditingController phoneController = TextEditingController();
    String? phoneText = "";
    const baseBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black,
        width: 1.0,
      ),
    );
    return
      Scaffold(
      body:Column(
      children: [
        SizedBox(height: 200,),

        TextFormField(
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            hintText: "+82입력후1231234123",
            border: baseBorder,
            contentPadding: EdgeInsets.all(20),
            fillColor: Colors.black,
          ),
          controller: phoneController,
          onChanged: (String value) {
            phoneText = value;
          },
        ),
        TextButton(
          onPressed: () {
             auth.verifyPhoneNumber(
                timeout: const Duration(seconds: 60),
                phoneNumber: phoneText,
                verificationCompleted: (_) {
                  print("success");
                  //context.read<IsLoginedController>().loadingAction();
                },
                verificationFailed: (e){
                  //context.read<IsLoginedController>().loadingAction();
                },
                codeSent: (String verificationId, int? token){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SignUpScreen(verificationId: verificationId,)));
                  print(verificationId);
                  print(token);
                }, codeAutoRetrievalTimeout: (String verificationId) {


            },);
          },
          child: const Text("휴대폰인증"),

        ),
      ],
      ),
    );
  }
}