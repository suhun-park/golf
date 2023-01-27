import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golf_booking/component/custom_image_box.dart';
import 'package:golf_booking/component/widgets/claendar_date.dart';
import 'package:golf_booking/component/widgets/svg_icon.dart';
import 'package:golf_booking/const/map_data.dart';
import 'package:golf_booking/const/regions.dart';
import 'package:golf_booking/const/styles.dart';

class BookingScreen extends StatefulWidget {
  const BookingScreen({Key? key}) : super(key: key);

  @override
  State<BookingScreen> createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> {
  int _selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Styles.appBarColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text(
          '경남 : 합천 골프장',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: [
            Gap(10),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              margin: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Styles.appBarColor),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SvgIcon(assetName: 'search'),
                  const Gap(10),
                  Text(
                    '검색할 골프장을 입력해주세요.',
                    style: TextStyle(color: Colors.white.withOpacity(0.9)),
                  )
                ],
              ),
            ),

            Container(
                padding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                margin: const EdgeInsets.symmetric(horizontal: 15),
                // decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(8),
                //     color: Styles.appBarColor),
                child: Row(
                  children: [
                    CupertinoButton(
                        borderRadius: BorderRadius.circular(12),
                        // child: Text('value = $_selectedValue $regions)'),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              regions[_selectedValue],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                height: 1.0,
                                color: Colors.black54,
                                fontSize: 18.0,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Gap(3),
                            Icon(
                              Icons.unfold_more_outlined,
                              size: 16,
                              color: Colors.grey,
                            )
                          ],
                        ),
                        onPressed: () => showCupertinoModalPopup(
                            context: context,
                            builder: (_) => SizedBox(
                              width: double.infinity,
                              height: 250,
                              child: CupertinoPicker(
                                backgroundColor: Colors.white,
                                itemExtent: 30,
                                scrollController:
                                FixedExtentScrollController(
                                  initialItem: 1,
                                ),
                                children: [
                                  ...regions.map((e) => Text(
                                    e,
                                    style:
                                    TextStyle(color: Colors.black),
                                  ))
                                ],
                                onSelectedItemChanged: (int value) {
                                  setState(() {
                                    _selectedValue = value;
                                  });
                                },
                              ),
                            ))),
                  ],
                )),
            Divider(
              color: Colors.black.withOpacity(0.6),
            ),
            ClaendarDate(),
            Divider(
              color: Colors.black.withOpacity(0.6),
            ),


            const Gap(20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(mapData.length, (index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ExpansionTile(
                    leading: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black),
                        child: mapData.isEmpty
                            ? CircularProgressIndicator()
                            : CustomImageBox(
                                circular: 0,
                                height: 100,
                                width: 100,
                                img: mapData[index]['image'],
                              )),
                    title: Text(
                      mapData[index]['title'],
                      style: const TextStyle(
                          fontWeight: FontWeight.w700, color: Colors.black),
                    ),
                    collapsedIconColor: Colors.black,
                    iconColor: Styles.highlightColor,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2),
                                width: 0.8),
                            borderRadius: BorderRadius.circular(8)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '예약가능시간',
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                                Text(
                                  '1년 회원권 금액 :' + mapData[index]['pay'],
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.8)),
                                ),
                              ],
                            ),
                            const Gap(10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children:
                                  mapData[index]['time'].map<Widget>((time) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 5),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Color(Styles.buttonColor.value)),
                                  child: Text(time,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                );
                              }).toList(),
                            ),
                            const Gap(30)
                          ],
                        ),
                      )
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}
