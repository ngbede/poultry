import 'package:flutter/foundation.dart';
import 'package:poultry/models/farm.dart';

class FarmProv with ChangeNotifier {
  final _farm = Farm();

  void serFarmName(String farmName) {
    _farm.farmName = farmName;
    notifyListeners();
  }

  void setAddress(String address) {
    _farm.address = address;
    notifyListeners();
  }

  void setState(String state) {
    _farm.state = state;
    notifyListeners();
  }

  void setLGA(String lga) {
    _farm.lga = lga;
    notifyListeners();
  }

  void setLayerCount(String layerCount) {
    _farm.numberOfLayers = layerCount;
    notifyListeners();
  }

  void setBroilerCount(String broilerCount) {
    _farm.numberOfBroilers = broilerCount;
    notifyListeners();
  }

  void setYearEstablished(String yearEstablished) {
    _farm.yearEstablished = yearEstablished;
    notifyListeners();
  }

  void setEmployeeCount(int numEmployees) {
    _farm.employees = numEmployees;
    notifyListeners();
  }

  String get farmName => _farm.farmName;
  String get address => _farm.address;
  String get state => _farm.state;
  String get lga => _farm.lga;
  String get layersCount => _farm.numberOfLayers;
  String get broilersCount => _farm.numberOfBroilers;
  String get yearEstablished => _farm.yearEstablished;
  int get employeeCount => _farm.employees;
}
