import 'package:cloud_firestore/cloud_firestore.dart';

class Place {
  late String id;
  late String city;
  late String name;
  late String address;
  late String phone;
  late String hole;
  late String available;
  late String imgUrl;


  Place({
    required this.id,
    required this.city,
    required this.name,
    required this.address,
    required this.phone,
    required this.hole,
    required this.available,
    required this.imgUrl,





  });
  Place.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    city = data['city'];
    name = data['name'];
    address = data['address'];
    phone = data['phone'];
    hole = data['hole'];
    available = data['available'];
    imgUrl = data['imgUrl'];
  }
}