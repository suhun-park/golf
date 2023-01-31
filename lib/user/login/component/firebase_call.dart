import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:golf_booking/user/login/component/data.dart';

import '../model/firebase_model.dart';

class FirebaseCall {
  final storage = FlutterSecureStorage();
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<List<FirebaseModel>?> getFirebaseData() async {
    try {
      CollectionReference<Map<String, dynamic>> collectionReference =
      FirebaseFirestore.instance.collection("user");
      QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await collectionReference.where(
        'uid', isEqualTo: await storage.read(key: FIREBASE_TOKEN_KEY),).get();
      List<FirebaseModel> firebaseData = [];
      for (var element in querySnapshot.docs) {
        firebaseData.add(FirebaseModel.fromJson(element.data()));
      }
      print(firebaseData[0].uid);
      return firebaseData;
    }catch(e){
      return null;
    }
  }
}