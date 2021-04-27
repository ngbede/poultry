import 'package:flutter/foundation.dart';
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

  String get firstName => _user.firstName;
  String get lastname => _user.lastName;
  String get email => _user.email;
  String get phoneNumber => _user.phoneNumber;

  void getInfo() {
    print(_user.toString());
  }
}
