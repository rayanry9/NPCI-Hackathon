import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uperks/constants/user_type.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  String? profilePicUrl;
  final UserType userType;
  String? upiId;
  List<String>? friendIds;

  UserModel.withoutId(
    this.name,
    this.email,
    this.phoneNumber,
    this.userType,
  ) : id = "";

  UserModel(
    this.id,
    this.name,
    this.email,
    this.phoneNumber,
    this.userType,
  );

  factory UserModel.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options) {
    final data = snapshot.data()!;
    return UserModel(
      snapshot.id,
      data["name"],
      data["email"],
      data["phoneNumber"],
      data["type"] == UserType.seller.name
          ? UserType.seller
          : UserType.customer,
    )
      ..profilePicUrl = data["profilePicUrl"]
      ..upiId = data["upiId"]
      ..friendIds = data["friendIds"];
  }

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "email": email,
      'phoneNumber': phoneNumber,
      'type': userType.name,
      'profilePicUrl': profilePicUrl,
      'upiId': upiId,
      'friendIds': friendIds,
    };
  }

  static Map<String, dynamic> toFirestoreForUpdate(
      {String? name,
      String? phoneNumber,
      String? profilePicUrl,
      String? upiId}) {
    var map = <String, dynamic>{};
    if (name != null) map.putIfAbsent("name", () => name);
    if (phoneNumber != null) map.putIfAbsent("phoneNumber", () => phoneNumber);
    if (profilePicUrl != null) {
      map.putIfAbsent("profilePicUrl", () => profilePicUrl);
    }
    if (upiId != null) map.putIfAbsent("upiId", () => upiId);
    return map;
  }
}

extension Calculations on List<UserModel> {
  String getNameFromId(String id) {
    return where((user) => user.id == id).first.name;
  }
}

/*
	 user id
	 name
	 email
	 ph no
	 points recieved
	 upi id[]
	 profile pic
	 friends []
	 user type
	 storee deatils
	 points redeemed
*/
