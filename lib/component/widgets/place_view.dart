import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:golf_booking/const/map_data.dart';
import 'package:golf_booking/privider/model_place_provider.dart';
import 'package:golf_booking/screen/datails_screen.dart';
import 'package:provider/provider.dart';

class PlaceView extends StatelessWidget {
  const PlaceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final placeProvider = Provider.of<PlaceProvider>(context);

    return SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 15, top: 20),
        child: FutureBuilder(
            future: placeProvider.fetchItems(),
            builder: (context, snapshots) {
              if (placeProvider.places.length == 0) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                return SizedBox(
                  height: 200,
                  width: 500,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                      itemCount: placeProvider.places.length,
                      separatorBuilder: (context, index){
                      return const SizedBox(width: 12);
                      },
                      itemBuilder: (context, index) {
                        return  InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) =>  DetailsScreen(
                                      id: placeProvider
                                          .places[index].id,
                                      city: placeProvider
                                          .places[index].city,
                                      name: placeProvider
                                          .places[index].name,
                                      address: placeProvider
                                          .places[index].address,
                                      phone: placeProvider
                                          .places[index].phone,
                                      hole: placeProvider
                                          .places[index].hole,
                                      available: placeProvider
                                          .places[index].available,
                                      imgUrl: placeProvider
                                          .places[index].imgUrl,
                                    )));
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 15),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Container(
                                  width: 200,
                                  height: 150,
                                  child: ClipRRect(
                                    borderRadius:
                                    BorderRadius.circular(13),
                                    child: Image.network(placeProvider
                                        .places[index].imgUrl,fit: BoxFit.fill,),
                                  ),
                                ),
                                const Gap(12),
                                Text(
                                  '${placeProvider.places[index].city} :  ${placeProvider.places[index].name}',
                                  style: const TextStyle(
                                      color: Colors.black,
                                      letterSpacing: 1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13),
                                ),
                                const Gap(8),
                                Row(
                                  children:
                                  List<Icon>.generate(5, (index) {
                                    return Icon(
                                      index == 4
                                          ? CupertinoIcons
                                          .star_lefthalf_fill
                                          : CupertinoIcons.star_fill,
                                      color: const Color(0xFFFAC921),
                                      size: 14,
                                    );
                                  }),
                                )
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
            }));
  }
}
