import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/component/custom_image_box.dart';
import 'package:golf_booking/const/styles.dart';

import '../kakaologin/component/social_login.dart';
import '../kakaologin/model/kakao_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = KakaoModel(KakaoLogin());
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 45),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 20),
              const Text(
                '프로필',
                textAlign: TextAlign.start,
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 34),
              ),
              const SizedBox(height: 60),
              Card(
                elevation: 0,
                margin: const EdgeInsets.only(bottom: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        const SizedBox(height: 12),
                        Stack(
                          // overflow: Overflow.visible,

                          alignment: AlignmentDirectional.topCenter,
                          fit: StackFit.loose,
                          children: <Widget>[
                            Container(
                              height: 110,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20))),
                            ),
                            Positioned(
                              top: 0,
                              child:
                              CustomImageBox(width: 100, height: 100, img: Styles.imagePath('elon.jpg'),circular: 50,)),
                          ],
                        ),
                        const Text(
                          '일론 머스크',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          // mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            const Icon(Icons.location_on_outlined),
                            const SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const <Widget>[
                                Text('지정위치 : 경남 합천군 합천읍 '),
                                Text('나이 : 36세'),
                                Text('등급 : 초보'),
                              ],
                            )
                          ],
                        )
                      ]),
                ),
              ),
              ProfileOption(text: '프로필 수정', onClick: () {//잠깐이용
                viewModel.logout();
              }),
              ProfileOption(text: '쿠폰 캐시관리', onClick: () {}),
              ProfileOption(text: '결제 수단 등록', onClick: () {}),
              ProfileOption(text: '이용 내역', onClick: () {}),
              ProfileOption(text: '공지사항', onClick: () {}),
              ProfileOption(text: '약관 및 정책', onClick: () {}),
              ProfileOption(text: '버전정보', onClick: () {}),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileOption extends StatelessWidget {
  final VoidCallback? onClick;
  final String text;
  ProfileOption({
    Key? key,
    this.onClick,
    this.text = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 13),
      child: ListTile(
        // contentPadding: EdgeInsets.all(10),
        title: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        onTap: onClick,
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          color: Colors.black,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        tileColor: Colors.white,
      ),
    );
  }
}
