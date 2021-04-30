import 'package:poultry/config/enumvals.dart';

class User {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  UserType role = UserType.distributor;
  String password;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.phoneNumber,
    this.role,
    this.password,
  });

  @override
  String toString() {
    return "Lastname: $lastName\nFirstName: $firstName\nEmail: $email\nPhone Number: $phoneNumber";
  }
}
