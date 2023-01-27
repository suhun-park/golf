import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golf_booking/component/custom_image_box.dart';
import 'package:golf_booking/component/layouts.dart';
import 'package:golf_booking/component/widgets/dotted_container.dart';
import 'package:golf_booking/component/widgets/place_view.dart';
import 'package:golf_booking/const/map_data.dart';
import 'package:golf_booking/const/styles.dart';
import 'package:golf_booking/screen/datails_screen.dart';
import 'package:golf_booking/screen/profile_screen.dart';
import 'package:golf_booking/screen/saved_booking.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CollectionReference product = FirebaseFirestore.instance.collection('items');
  CollectionReference mainBanner =
      FirebaseFirestore.instance.collection('mainBanner');

  final CarouselController _controller = CarouselController();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  int _current = 0;

  Future<void> _update(DocumentSnapshot documentSnapshot) async {
    nameController.text = documentSnapshot['name'];
    priceController.text = documentSnapshot['price'];

    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String price = priceController.text;
                    await product
                        .doc(documentSnapshot.id)
                        .update({"name": name, "price": price});
                    nameController.text = "";
                    priceController.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _create() async {
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          child: Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(labelText: 'Price'),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final String name = nameController.text;
                    final String price = priceController.text;
                    await product
                        .add({'name': name, 'price': price})
                        .then((value) => print("$name생성완료"))
                        .catchError(
                            (error) => print("Failed to add user: $error"));

                    nameController.text = "";
                    priceController.text = "";
                    Navigator.of(context).pop();
                  },
                  child: Text('Update'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _delete(String productId) async {
    await product.doc(productId).delete();
  }

  @override
  Widget build(BuildContext context) {
    final size = Layouts.getSize(context);

    return Scaffold(
      // backgroundColor: Styles.backgroundColor,
      appBar: renderAppbar(),
      body: WillPopScope(
        onWillPop: () {
          return Future(() => false);
        },
        child: ListView(
          padding: const EdgeInsets.symmetric(vertical: 15),
          physics: const BouncingScrollPhysics(),
          children: [
            mainbanner(),
            const Gap(12),
            mainBennerSlide(),
            const Gap(12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '추천 골프장',
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.black,
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '더보기',
                        style: TextStyle(
                            fontSize: 11,
                            letterSpacing: 1,
                            color: Colors.black.withOpacity(0.6),
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        CupertinoIcons.chevron_forward,
                        color: Colors.black.withOpacity(0.6),
                        size: 15,
                      )
                    ],
                  )
                ],
              ),
            ),
            PlaceView(),
            const Gap(10),
            Divider(
              color: Colors.black.withOpacity(0.6),
            ),
            Container(
              padding: const EdgeInsets.only(left: 15, bottom: 10),
              child: const Text(
                '할인권 정보',
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: 15),
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  Container(
                      margin: const EdgeInsets.only(right: 15),
                      width: size.width * 0.55,
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/backgraund.jpg',
                            ),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.9),
                                BlendMode.dstATop),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12),
                        // color: Colors.green[400]
                      ),
                      child: Row(
                        children: [
                          const Gap(15),
                          Image.asset(Styles.imagePath('credit_card.png')),
                          const Gap(50),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(12),
                              const Text(
                                '경남\n합천 골프장',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const Gap(2),
                              Row(children: [
                                Text('할인권',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                Text(' 30%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ]),
                              const Gap(10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Styles.buttonColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  '할인권 받기',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ),
                              const Gap(22)
                            ],
                          ),
                        ],
                      )),
                  Container(
                      //height: 170,
                      width: size.width * 0.55,
                      margin: const EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                              'assets/images/backgraund.jpg',
                            ),
                            colorFilter: ColorFilter.mode(
                                Colors.black.withOpacity(0.9),
                                BlendMode.dstATop),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(12),
                        // color: Colors.green[400]
                      ),
                      child: Row(
                        children: [
                          Image.asset(Styles.imagePath('saly2.png')),
                          const Gap(30),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Gap(12),
                              const Text(
                                '대구\n대구 골프장',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              const Gap(2),
                              Row(children: [
                                Text('할인권',
                                    style: TextStyle(
                                        color: Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold)),
                                Text(' 30%',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20)),
                              ]),
                              const Gap(10),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                decoration: BoxDecoration(
                                    color: Styles.buttonColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Text(
                                  '할인권 받기',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 10),
                                ),
                              ),
                              const Gap(22),
                            ],
                          ),
                        ],
                      )),
                ],
              ),
            ),
            const Gap(22),
            StreamBuilder(
              stream: product.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot =
                            streamSnapshot.data!.docs[index];
                        return Card(
                          margin: EdgeInsets.only(
                              left: 16, right: 16, top: 8, bottom: 8),
                          child: ListTile(
                            title: Text(documentSnapshot['name']),
                            subtitle: Text(documentSnapshot['price']),
                            trailing: SizedBox(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _update(documentSnapshot);
                                    },
                                    icon: Icon(Icons.edit),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _delete(documentSnapshot.id);
                                    },
                                    icon: Icon(Icons.delete),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
            Container(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/logo.jpg',
                    width: 100,
                  ),
                  Icon(Icons.add),
                  Text('사업자정보 : 123-45-12342'),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () {
          _create();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  ////

  ////

  mainbanner() {
    return StreamBuilder(
        stream: mainBanner.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return CarouselSlider.builder(
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
                itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (BuildContext context, int index, int realIndex) {
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          color: Colors.black54, fontSize: 10),
                                    ),
                                    RichText(
                                      text: TextSpan(children: [
                                        TextSpan(
                                            text:
                                                documentSnapshot.get('context'),
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
                });
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  Widget mainBennerSlide() {
    return StreamBuilder(
        stream: mainBanner.snapshots(),
        builder: (BuildContext context,
            AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(streamSnapshot.data!.docs.length, (int index) {
                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 8,
                  width: (index == _current) ? 30 : 12,
                  margin:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: (index == _current)
                          ? Color(Styles.buttonColor.value)
                          : Color(Styles.gradient1Color.value)),
                );
              }),
            );
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  AppBar renderAppbar() {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Transform.scale(
            scale: 0.7,
            child: GestureDetector(
              child: CustomImageBox(
                width: 70,
                height: 70,
                img: Styles.imagePath('elon.jpg'),
                circular: 40,
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const ProfileScreen()));
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              //컬러 바꿔야됨 검은색 아이콘으로 /수정
              Icon(
                Icons.location_on_outlined,
                color: Colors.black54,
                size: 18,
              ),
              Gap(5),
              Text(
                '경남 합천군 합천읍',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                    fontWeight: FontWeight.w500),
              )
            ],
          ),
          InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const SavedBooking()));
            },
            child: const DottedContainer(
                //컬러 바꿔야됨 검은색 아이콘으로 /수정
                child: Icon(
              Icons.notifications_active_outlined,
              color: Colors.black54,
              size: 18,
            )),
          )
        ],
      ),
    );
  }
}
