import 'package:poultry/config/enumvals.dart';

class User {
  String name;

  String email;
  String phoneNumber;
  UserType role;
  String password;
  String address;

  User({
    this.name,
    this.email,
    this.phoneNumber,
    this.role = UserType.distributor,
    this.password,
    this.address,
  });

  @override
  String toString() {
    return "Name: $name\nEmail: $email\nPhone Number: $phoneNumber";
  }
}
