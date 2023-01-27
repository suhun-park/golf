import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/user/component/custominput.dart';
import 'package:golf_booking/user/component/custompassword.dart';
import 'package:golf_booking/user/component/headline.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Login_Screen extends StatefulWidget {
  const Login_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

class _Login_ScreenState extends State<Login_Screen> {
  final _authentication = FirebaseAuth.instance;

  bool showSpinner = false;

  String userEmail = '';

  String userPassword = '';

  bool isEmailCheck = false;
  bool isPasswordCheck = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = new TextEditingController();
  final TextEditingController _phoneNumberController =
  new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      // TODO SAVE DATA
    }
  }

  void _incrementCounter() {
    setState(() {
      isEmailCheck = true;
    });
  }

  void _incrementPasswordCounter() {
    setState(() {
      isPasswordCheck = true;
    });
  }

  //final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.backgroundColor,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Image(image: AssetImage('assets/images/EllipseMorado.png')),
                  ShaderMask(
                      shaderCallback: (rect) {
                        return const LinearGradient(
                          begin: Alignment.topCenter,
                          end: FractionalOffset.center,
                          colors: [Colors.black, Colors.transparent],
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstIn,
                      child: const Image(
                          image: AssetImage('assets/images/EllipseRosa.png'),
                          fit: BoxFit.contain)),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
                child: Headline(title: 'GolTing - 골팅'),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 50.0, bottom: 27.0),
                    child: const Image(
                      image: AssetImage('assets/images/EllipseMorado.png'),
                    ),
                  )
                ],
              ),
              Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  height: MediaQuery.of(context).size.height * 0.64,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(50.0, 36.0, 50, 0),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Text(
                              '이메일 로그인',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                              ),
                            ),
                            Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                                  child:Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(Icons.email_outlined,size: 24.0,color: Colors.grey,semanticLabel: 'Email icon'),
                                          Padding(padding: const EdgeInsets.only(left: 10.0),
                                            child: Text('Email',
                                              style: TextStyle(color: Color(0xff868686),fontSize: 16.0),),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        controller: _emailController,
                                        onChanged: (value) {
                                          _submit();
                                          userEmail = value;
                                        },
                                        keyboardType: TextInputType.emailAddress,
                                        validator: validateEmail,
                                        decoration: InputDecoration(
                                          enabledBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          focusedBorder: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                          border: UnderlineInputBorder(
                                            borderSide: BorderSide(color: Colors.grey),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                            ),
                            Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                                  child:Column(
                                    children: <Widget>[
                                      Row(
                                        children: [
                                          Icon(Icons.lock_outline,size: 24.0,color: Colors.grey,semanticLabel: 'Email icon'),
                                          Padding(padding: const EdgeInsets.only(left: 10.0),
                                            child: Text('비밀번호',
                                              style: TextStyle(color: Color(0xff868686),fontSize: 16.0),),
                                          ),

                                        ],
                                      ),
                                      TextFormField(
                                        validator: validatePassword,
                                        onChanged: (value) {
                                          _submit();
                                          userPassword = value;
                                        },
                                        decoration: InputDecoration(
                                            enabledBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                            focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),
                                            border: UnderlineInputBorder(
                                              borderSide: BorderSide(color: Colors.grey),
                                            ),

                                            suffixText: '보기',
                                            suffixStyle: TextStyle(color: Color(0xff5956E9))
                                        ),
                                        obscureText: true,
                                      )
                                    ],
                                  ),
                                )
                            ),
                            TextButton(
                                onPressed: null,
                                child: Text('비밀번호 찾기',
                                    style: TextStyle(color: Styles.buttonColor))),
                            ElevatedButton(
                                onPressed:() async {
                                  setState(() {
                                    showSpinner = true;
                                  });
                                  try {
                                    final newUser =
                                    await _authentication.signInWithEmailAndPassword(
                                      email: userEmail,
                                      password: userPassword,
                                    );
                                    if (newUser.user != null) {
                                      Navigator.pushReplacementNamed(
                                          context, "/");
                                    }
                                  } on FirebaseAuthException catch (e) {
                                    if (e.code == 'user-not-found') {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      _showDialog('이메일을 찾을수 없습니다.', '가입되어 있지 않은 이메일주소 입니다. 확인 후 다시 로그인해주세요.');
                                      print('이메일을 찾을수 없습니다.');
                                    } else if (e.code == 'wrong-password') {
                                      setState(() {
                                        showSpinner = false;
                                      });
                                      _showDialog('비밀번호가 틀립니다.' , '비밀번호를 확인 후 다시 로그인해주세요.');
                                      print('비밀번호가 틀립니다.');
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Styles.buttonColor,
                                    fixedSize: Size(314.0, 70.0),
                                    onPrimary: Colors.white,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10.0)),
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 22),
                                    textStyle: const TextStyle(
                                        fontSize: 20, fontWeight: FontWeight.w700)),
                                child: Text('로그인')),

                            Center(
                              child: TextButton(
                                onPressed: (){
                                  Navigator.pushReplacementNamed(
                                      context, "signup");
                                },
                                child: Text(
                                  '아이디 만들기',
                                  style: TextStyle(
                                      color: Styles.buttonColor, fontSize: 17.0),
                                ),
                              ),
                            )
                          ],
                        ),
                      )),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  String? validateEmail(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(value!))
      return '이메일 형식이 아닙니다.';
    else
      _incrementCounter();
    return null;
  }

  String? validatePassword(String? value) {

    final validNumbers = RegExp(r'(\d+)');
    final validAlphabet = RegExp(r'[a-zA-Z]');
    final validSpecial = RegExp(r'^[a-zA-Z0-9 ]+$');

    //
    if (value!.length <= 8 || !validNumbers.hasMatch(value) || !validAlphabet.hasMatch(value) ) {
      return '문자 또는 숫자를 포함 8글자 이상 이어야 합니다.';
    } else if (validSpecial.hasMatch(value)){
      return '특수기호를 포함하고 있어야 합니다.';
    } else {
      _incrementPasswordCounter();
      return null;
    }
  }
  void _showDialog(String title , String text) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(text)
              ],
            ),
          ),
          actions: [
            TextButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('확인'))
          ],
        );
      },
    );
  }
}
