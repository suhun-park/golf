import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseModel {
  late final String uid;
  late final String userId;
  late final String userName;
  late final String userPhone;
  late final String userEmail;


  FirebaseModel(this.uid, this.userId, this.userName, this.userPhone,this.userEmail);


  FirebaseModel.fromSnapshot (DocumentSnapshot snapshot, this.uid, this.userId, this.userName, this.userPhone,this.userEmail) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    uid = data['uid'];
    userId = data['userId'];
    userName = data['userName'];
    userPhone = data['userPhone'];
    userEmail = data['userEmail'];
  }
}