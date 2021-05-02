import 'package:poultry/models/user.dart';

//TODO: add a date field for both broilers and layers to track their age bought
class Farm {
  String farmName;
  String address;
  String state;
  String lga;
  User farmOwner;
  String numberOfLayers;
  String numberOfBroilers;
  String yearEstablished;
  int employees;

  Farm({
    this.farmName,
    this.farmOwner,
    this.numberOfLayers,
    this.numberOfBroilers,
    this.address,
    this.lga,
    this.state,
    this.employees,
    this.yearEstablished,
  });
}
