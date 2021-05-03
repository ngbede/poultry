import 'package:flutter/foundation.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/models/user.dart';

class UserProv with ChangeNotifier {
  final User _user = User();
  void setFirstName(String firstName) {
    _user.firstName = firstName;
    notifyListeners();
  }

  void setLastName(String lastName) {
    _user.lastName = lastName;
    notifyListeners();
  }

  void setEmail(String email) {
    _user.email = email;
    notifyListeners();
  }

  void setPhoneNumber(String number) {
    _user.phoneNumber = number;
    notifyListeners();
  }

  void setPassword(String password) {
    _user.password = password;
    notifyListeners();
  }

  void setUserRole(UserType role) {
    _user.role = role;
    notifyListeners();
  }

  String get firstName => _user.firstName;
  String get lastname => _user.lastName;
  String get email => _user.email;
  String get phoneNumber => _user.phoneNumber;
  UserType get role => _user.role;
  String get password => _user.password;

  void getInfo() {
    print(_user.toString());
  }
}