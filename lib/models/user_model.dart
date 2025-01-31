class UserModel {
  final String name;
  final String email;
  final String? phoneNumber;

  const UserModel({required this.name, required this.email, this.phoneNumber});
}
