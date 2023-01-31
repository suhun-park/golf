class FirebaseModel {
  String? uid;
  String? userEmail;
  String? userId;
  String? userName;
  String? userPhone;


  FirebaseModel(
  {this.uid,
  this.userEmail,
  this.userId,
  this.userName,
  this.userPhone,
  });

  FirebaseModel.fromJson(Map<String, dynamic> json) {
  uid = json['uid'];
  userEmail = json['userEmail'];
  userId = json['userId'];
  userName = json['userName'];
  userPhone = json['userPhone'];
  }

  Map<String, dynamic> toJson() {
  final Map<String, dynamic> data = new Map<String, dynamic>();
  data['uid'] = uid;
  data['userEmail'] = userEmail;
  data['userId'] = userId;
  data['userName'] = userName;
  data['userPhone'] = userPhone;
  return data;
  }
}
