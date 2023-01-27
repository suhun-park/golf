import 'package:cloud_firestore/cloud_firestore.dart';

class Item {
  late String id;
  late String title;
  late String context;
  late String subcontext;

  Item({
    required this.id,
    required this.title,
    required this.context,
    required this.subcontext,
});
  Item.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    id = snapshot.id;
    title = data['title'];
    context = data['context'];
    subcontext = data['subcontext'];
  }
}