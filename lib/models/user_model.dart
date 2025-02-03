import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uperks/constants/user_type.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  final String? phoneNumber;
  String? profilePicUrl;
  final UserType userType;
  List<String>? transactionIds;
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
      ..transactionIds = data["transactionsIds"]
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
      'transactionIds': transactionIds,
      'upiId': upiId,
      'friendIds': friendIds,
    };
  }

  static Map<String, dynamic> toFirestoreForUpdate(
      {String? name,
      String? email,
      String? phoneNumber,
      String? profilePicUrl,
      String? upiId}) {
    var map = <String, dynamic>{};
    if (name != null) map.putIfAbsent("name", () => name);
    if (email != null) map.putIfAbsent("email", () => email);
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
	 transactions_id[]
	 user type
	 storee deatils
	 points redeemed
*/
