import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golf_booking/const/map_data.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/screen/booking_screen.dart';


class SavedBooking extends StatelessWidget {
  const SavedBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Styles.appBarColor,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text('최근 예약내역', style: TextStyle(fontWeight: FontWeight.w700),),
      ),
      body: Column(
        children: [
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                    color: Styles.gradient1Color,
                    borderRadius: BorderRadius.circular(7)
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6
                      ),
                      decoration: BoxDecoration(
                          color: Styles.gradient2Color,
                          borderRadius: BorderRadius.circular(5)
                      ),
                      child: const Text('예약가능', style: TextStyle(color: Colors.white, fontSize: 12),),
                    ),
                    const Gap(5),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6
                      ),
                      child: Text('예약 불가능', style: TextStyle(color: Colors.black.withOpacity(0.6), fontSize: 12),),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.only(left: 15, top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: mapData.map<Widget>((map) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 25),
                    child: SizedBox(
                      height: 180,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(13),
                              child: Image.asset(map['image'])
                          ),
                          const Gap(12),
                          Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(mapData.indexOf(map) == 0 ? map['title']+' (최근)' :  map['title'] , style: const TextStyle(color: Colors.black, letterSpacing: 1, fontWeight: FontWeight.bold, fontSize: 20),),
                                const Gap(8),
                                Row(
                                  children: List<Icon>.generate(5, (index) {
                                    return Icon(index == 4 ? CupertinoIcons.star_lefthalf_fill : CupertinoIcons.star_fill, color: const Color(0xFFFAC921), size: 18,);
                                  }),
                                ),
                                const Gap(15),
                                Row(
                                  children: [
                                    Text('홀수', style: TextStyle(color: Colors.black.withOpacity(0.35), fontSize: 12),),
                                    const Gap(4),
                                    Text('18', style: TextStyle(color: Colors.black.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.bold),),
                                  ],
                                ),
                                const Gap(5),
                                Text('예약가능, 주차가능', style: TextStyle(color: Colors.black.withOpacity(0.35), fontSize: 12, fontWeight: FontWeight.bold),),
                                const Spacer(),
                                ElevatedButton(
                                  child: const Text('예약하기', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500),),
                                  style: ElevatedButton.styleFrom(
                                      primary: Styles.buttonColor,
                                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(7)
                                      )
                                  ),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (_) => const BookingScreen()
                                    ));
                                  },
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

          ),
        ],
      ),
    );
  }
}
