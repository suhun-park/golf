import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:golf_booking/component/custom_image_box.dart';
import 'package:golf_booking/component/widgets/claendar_date.dart';
import 'package:golf_booking/component/widgets/svg_icon.dart';
import 'package:golf_booking/const/map_data.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/screen/booking_screen.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key, required this.id,
    required this.city,
    required this.name,
    required this.address,
    required this.phone,
    required this.hole,
    required this.available,
    required this.imgUrl,
  }) : super(key: key);
  final String id;
  final String city;
  final String name;
  final String address;
  final String phone;
  final String hole;
  final String available;
  final String imgUrl;



  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
      // bottomSheet: renderbuttom(context),

      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.centerLeft,
              children: [
                Image.network(imgUrl,width: double.infinity,
                  fit: BoxFit.cover,
                  height: 220,
                  color: Colors.grey.withOpacity(0.35),
                  colorBlendMode: BlendMode.modulate,),
                // 플레이버튼
                // Positioned.fill(
                //   child: Image.asset(
                //     Styles.imagePath('play.png'),
                //     color: Colors.grey.withOpacity(0.5),
                //   ),
                // ),
                Positioned(
                    left: 15,
                    top: 200,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(width: 220,
                            height: 170, imgUrl,fit: BoxFit.fill,),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 30, left: 16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                               Text('$city :',
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(name,
                                style: TextStyle(
                                    fontSize: 22,
                                    color: Colors.black,
                                    letterSpacing: 1,
                                    fontWeight: FontWeight.bold),
                              ),
                              const Gap(15),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  renderText("위치" , address),
                                  renderText("전화번호" , phone),
                                  renderText("홀" , hole),
                                  renderText("예약여부" , available),
                                ]

                              )
                            ],
                          ),
                        )
                      ],
                    )),
                Positioned(
                  top: 40,
                  left: 0,
                  child: IconButton(
                    icon: const Icon(
                      CupertinoIcons.back,
                      color: Colors.black,
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                )
              ],
            ),
            const Gap(180),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 70,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 25),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 0.8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Row(
                              children: List<Icon>.generate(5, (index) {
                                return Icon(
                                  index == 4
                                      ? CupertinoIcons.star_lefthalf_fill
                                      : CupertinoIcons.star_fill,
                                  color: const Color(0xFFFAC921),
                                  size: 12,
                                );
                              }),
                            ),
                            const Spacer(),
                            Text('평점',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.35),
                                    fontSize: 10)),
                            Text(
                              mapData[0]['star'].toString() + '/5',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 25),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 0.8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Text('예약가능인원',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.35),
                                    fontSize: 12)),
                            const Spacer(),
                            const Text(
                              '12명',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                      Container(
                        height: 60,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 30),
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 0.8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          children: [
                            Text('년 회원비용',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.35),
                                    fontSize: 12)),
                            const Spacer(),
                            const Text(
                              '230,000원',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),

                  const Gap(20),
                  ClaendarDate(),
                  const Center(
                      child: Text(
                        '예약 가능 시간',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      )),
                  const Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:
                    mapData[0]['time'].map<Widget>((time) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(Styles.appBarColor.value)),
                        child: Text('$time \n 18팀' ,
                          style: TextStyle(color: Colors.white , fontSize: 14 ),
                        ),
                      );
                    }).toList(),
                  ),
                  const Gap(20),
                  const Center(
                      child: Text(
                    '골프장 소개',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17),
                  )),
                  const Gap(20),
                  Text(
                    """솔라고(SOL-LAGO)는 스페인어로 태양을 뜻하는 ‘솔(SOL)’과 호수를 의미하는 '라고 (LAGO)’의 합성어로, 호수 위로 떠오르는 태양과 그 아래 자리한 골프장을 표현하고자 했습니다.

                    현재 158만㎡(48만여평) 용지에 총36홀 (솔코스 18홀, 라고코스 18홀)로 구성되어 있으며, 모든 홀이 제각각
                    독립된 개성을 지니고 있어 골프장 코스 본연의 기본 원칙을 바탕으로 플레이어의 전략과 도전욕구, 자연 경관의
                    아름다움을 담기 위해 노력했습니다.
                    
                    솔라고의 드넓은 페어웨이, 넓은 해저드와 비치벙커는 방문하신 모든 분들께 대자연의 숨결을 느끼고
                    동화되는 경험을 선사 할 것이며 더불어 모든 임직원은 최고의 서비스로 고객 한분 한분의 기대에 부응하고 선진
                    골프문화를 선도해 나갈 것을 약속합니다.""",
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.black.withOpacity(0.4),
                        letterSpacing: 1,
                        fontWeight: FontWeight.w400),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  renderText(title , context){
    return Container(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          SizedBox(
              width: 65,
              child: Text(
                  title,
                style: TextStyle(
                    color: Colors.black
                        .withOpacity(0.35),
                    fontSize: 12),
              )),
          const Gap(20),
          Text(
              context,
            style: TextStyle(
                color:
                Colors.black.withOpacity(0.6),
                fontSize: 12),
          ),
        ],
      ),
    );
  }
  renderbuttom (context){
    return Container(
      padding:
      const EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 25),
      color: Styles.backgroundColor,
      child: ElevatedButton(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SvgIcon(assetName: 'ticket'),
            Gap(10),
            Text(
              '예약하기',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            )
          ],
        ),
        style: ElevatedButton.styleFrom(
            primary: Styles.buttonColor,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (_) => const BookingScreen()));
        },
      ),
    );
  }
}
