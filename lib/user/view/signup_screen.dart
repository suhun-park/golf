import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/user/component/headline.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class Signup_Screen extends StatefulWidget {
  const Signup_Screen({Key? key}) : super(key: key);

  @override
  State<Signup_Screen> createState() => _Signup_ScreenState();
}

class _Signup_ScreenState extends State<Signup_Screen> {
  final _authentication = FirebaseAuth.instance;
  bool showSpinner = false;
  String userEmail = '';
  String userPassword = '';
  String userPasswordCopy = '';
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
    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Styles.backgroundColor,
        body: Column(
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
                            '이메일 회원가입',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                            ),
                          ),
                          Container(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Icon(Icons.email_outlined,
                                        size: 24.0,
                                        color: Colors.grey,
                                        semanticLabel: 'Email icon'),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        'Email',
                                        style: TextStyle(
                                            color: Color(0xff868686),
                                            fontSize: 16.0),
                                      ),
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
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                    border: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.grey),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )),
                          Container(
                              child: Padding(
                            padding: EdgeInsets.fromLTRB(0.0, 45.0, 0.0, 0.0),
                            child: Column(
                              children: <Widget>[
                                Row(
                                  children: [
                                    Icon(Icons.lock_outline,
                                        size: 24.0,
                                        color: Colors.grey,
                                        semanticLabel: 'Email icon'),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(left: 10.0),
                                      child: Text(
                                        '비밀번호',
                                        style: TextStyle(
                                            color: Color(0xff868686),
                                            fontSize: 16.0),
                                      ),
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
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      border: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.grey),
                                      ),
                                      suffixText: '보기',
                                      suffixStyle:
                                          TextStyle(color: Color(0xff5956E9))),
                                  obscureText: true,
                                )
                              ],
                            ),
                          )),
                          SizedBox(
                            height: 12,
                          ),
                          ElevatedButton(
                              onPressed: isEmailCheck && isPasswordCheck
                                  ? () async {
                                setState(() {
                                  showSpinner = true;
                                });
                                      try {
                                        final newUser = await _authentication
                                            .createUserWithEmailAndPassword(
                                          email: userEmail,
                                          password: userPassword,
                                        );
                                        if (newUser.user != null) {
                                          Navigator.pushReplacementNamed(
                                              context, "/");
                                        }
                                      } on FirebaseAuthException catch (e) {
                                        if (e.code == 'weak-password') {
                                          print('비밀번호를 다시 확인해주세요.');
                                        } else
                                        if (e.code == 'email-already-in-use') {
                                          print('이미 가입된 이메일 입니다.');
                                          setState(() {
                                            showSpinner = false;
                                          });
                                          _showDialog('이미 가입된 이메일 입니다.','본 이메일은 이미 가입되어있는 이메일 입니다.');
                                        } else {
                                          setState(() {
                                            showSpinner = false;
                                          });
                                        }
                                      }catch (e) {
                                        print(e);
                                      }
                                    }
                                  : null,

                              style: ElevatedButton.styleFrom(
                                  primary: Styles.buttonColor,
                                  fixedSize: Size(314.0, 70.0),
                                  onPrimary: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10.0)),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 22),
                                  textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700)),
                              child: Text('회원가입')),
                        ],
                      ),
                    )),
              ),
            ),
          ],
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

  void _showDialog(String title, String text) {
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
