import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golf_booking/const/auth_data.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/screen/home_screen.dart';
import 'package:golf_booking/screen/splash_screen.dart';
import 'package:golf_booking/screen/tab_page.dart';
import 'package:golf_booking/user/component/custominput.dart';
import 'package:golf_booking/user/component/custompassword.dart';
import 'package:golf_booking/user/component/headline.dart';
import 'package:golf_booking/user/view/login_screen.dart';
import 'package:golf_booking/user/view/signup_screen.dart';

class Login_Index_Screen extends StatefulWidget {
  const Login_Index_Screen({Key? key}) : super(key: key);

  @override
  State<Login_Index_Screen> createState() => _Login_Index_ScreenState();
}

class _Login_Index_ScreenState extends State<Login_Index_Screen> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  //final _formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      // backgroundColor: Color(0xff5956E9),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            height: MediaQuery.of(context).size.height,
            // width: MediaQuery.of(context).size.width,
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 15),
              physics: const BouncingScrollPhysics(),
              children: [
                CarouselSlider.builder(
                  carouselController: _controller,
                  options: CarouselOptions(
                      aspectRatio: 2.25,
                      enlargeCenterPage: true,
                      scrollDirection: Axis.horizontal,
                      autoPlay: false,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _current = index;
                        });
                      }),
                  itemCount: 5,
                  itemBuilder:
                      (BuildContext context, int index, int realIndex) {
                    return Stack(
                      children: [
                        Container(
                          height: double.infinity,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.green[200]),
                          child: _current == index
                              ? SafeArea(
                                  minimum: const EdgeInsets.all(14),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Gap(10),
                                      const Text(
                                        '새로운 시작,\n파크고',
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ),
                                      const Gap(10),
                                      const Text(
                                        '할인이벤트',
                                        style: TextStyle(
                                            color: Colors.black54,
                                            fontSize: 10),
                                      ),
                                      RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: '결제회원 모두에게',
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20)),
                                          TextSpan(
                                              text: ' / 10% 할인 ',
                                              style: TextStyle(
                                                color: Colors.white,
                                              )),
                                        ]),
                                      ),
                                      const Spacer(),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 1),
                                        decoration: BoxDecoration(
                                            color: Styles.buttonColor,
                                            borderRadius:
                                                BorderRadius.circular(50)),
                                        child: Text(
                                          '혜택받기',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                              fontSize: 13),
                                        ),
                                      ),
                                      const Gap(5)
                                    ],
                                  ),
                                )
                              : const SizedBox(),
                        ),
                        _current == index
                            ? Positioned(
                                right: 2,
                                bottom: 0,
                                child: Container(
                                  width: 90,
                                  child: Image.asset(
                                    Styles.imagePath('customlogo.png'),
                                    fit: BoxFit.cover,
                                  ),
                                ))
                            : const SizedBox()
                      ],
                    );
                  },
                ),
                const Gap(8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(5, (int index) {
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      height: 8,
                      width: (index == _current) ? 30 : 12,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 4),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: (index == _current)
                              ? Color(Styles.buttonColor.value)
                              : Color(Styles.gradient1Color.value)),
                    );
                  }),
                ),
                SizedBox(
                  height: 30,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '언제 어디서든 \n편리하게 예약가능',
                      style: TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 22.0,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: authData.map<Widget>((auth) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => const Splash_Screen()));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image.asset(auth['image']),
                                  ),
                                ),
                                const Gap(12),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => const Login_Screen()));
                      },
                      child: Container(
                          width: 370,
                          height: 60,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.email,
                                  color: Colors.black45, size: 22),
                              SizedBox(
                                width: 5,
                              ),
                              Text(
                                '이메일로 로그인',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Signup_Screen()));
                        },
                        child: Text(
                          '이메일로 회원가입',
                          style: TextStyle(
                              fontWeight: FontWeight.w200,
                              fontSize: 16.0,
                              decoration: TextDecoration.underline,
                              color: Colors.grey),
                        ))
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
