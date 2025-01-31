import 'package:uperks/constants/user_type.dart';

class UserModel {
  final String? name;
  final String? email;
  final String? phoneNumber;
  final UserType? userType;
	String? profilePicUrl;
	List<String>? transactionIds;
	List<String>? upiIds;
	List<String>? friendIds;

  UserModel({
    required this.name,
    required this.email,
    this.phoneNumber,
    this.userType,
  });
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
