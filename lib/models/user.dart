import 'package:poultry/config/enumvals.dart';

class User {
  String name;

  String email;
  String phoneNumber;
  UserType role = UserType.distributor;
  String password;

  User({
    this.name,
    this.email,
    this.phoneNumber,
    this.role,
    this.password,
  });

  @override
  String toString() {
    return "Name: $name\nEmail: $email\nPhone Number: $phoneNumber";
  }
}
