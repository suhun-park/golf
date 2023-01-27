import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golf_booking/const/styles.dart';


class MainBerner extends StatefulWidget {
  const MainBerner({Key? key}) : super(key: key);

  @override
  State<MainBerner> createState() => _MainBernerState();
}

class _MainBernerState extends State<MainBerner> {
  @override
  Widget build(BuildContext context) {
    CollectionReference mainBanner =
        FirebaseFirestore.instance.collection('mainBanner');

    final CarouselController _controller = CarouselController();
    int _current = 0;

    return StreamBuilder(
        stream: mainBanner.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Column(
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
                            print(index);
                          });
                        }),
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder:
                        (BuildContext context, int index, int realIndex) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Stack(
                        children: [
                          Container(
                            height: double.infinity,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    'assets/images/aa2.jpg',
                                  ),
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(12),
                              // color: Colors.green[400]
                            ),
                            child: _current == index
                                ? SafeArea(
                                    minimum: const EdgeInsets.all(14),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Gap(10),
                                        Text(
                                          documentSnapshot.get("title"),
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
                                                text: documentSnapshot
                                                    .get('context'),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20)),
                                            TextSpan(
                                                text: documentSnapshot
                                                    .get('subcontext'),
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
                                  child: Image.asset(
                                    Styles.imagePath('saly.png'),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const SizedBox()
                        ],
                      );
                    }),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List<Widget>.generate(
                      streamSnapshot.data!.docs.length, (int index) {

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
                )
              ],
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
