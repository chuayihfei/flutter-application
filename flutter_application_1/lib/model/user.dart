import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  final String name;
  final String email;
  // final String image;
  final DateTime lastActive;
  final bool isOnline;

  const UserModel({
    required this.name,
    // required this.image,
    required this.lastActive,
    required this.uid,
    required this.email,
    this.isOnline = false,
  });

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data();
    return UserModel(
      uid: data?['uid'],
      name: data?['name'],
      //  image: json['image'],
      email: data?['email'],
      isOnline: data?['isOnline'],
      lastActive: DateTime.parse(data?['lastActive']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      if (uid != null) "uid": uid,
      if (name != null) "name": name,
      if (email != null) "email": email,
      if (isOnline != null) "isOnline": isOnline,
      if (lastActive != null) "lastActive": lastActive,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        uid: json['uid'],
        name: json['name'],
        //  image: json['image'],
        email: json['email'],
        isOnline: json['isOnline'],
        lastActive: json['lastActive'].toDate(),
      );

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'name': name,
        // 'image': image,
        'email': email,
        'isOnline': isOnline,
        'lastActive': lastActive,
      };
}
