import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:golf_booking/model/model_place.dart';

class PlaceProvider with ChangeNotifier {
  late CollectionReference itemsReference;
  List<Place> places = [];

  PlaceProvider({reference}) {
    itemsReference = reference ?? FirebaseFirestore.instance.collection('palce');
  }

  Future<void> fetchItems() async {
    places = await itemsReference.get().then( (QuerySnapshot results) {
      return results.docs.map( (DocumentSnapshot document) {
        return Place.fromSnapshot(document);
      }).toList();
    });
    notifyListeners();
  }
}