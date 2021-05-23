import 'package:flutter/foundation.dart';
import 'package:poultry/models/birds.dart';

class BirdsProv with ChangeNotifier {
  Birds _birdBatch = Birds();

  void setBatchName(String name) {
    _birdBatch.batchName = name;
    notifyListeners();
  }

  void setStartDate(String date) {
    _birdBatch.startDate = date;
    notifyListeners();
  }

  void setQuantity(int count) {
    _birdBatch.quantity = count;
    notifyListeners();
  }

  void setBirdType(String birdClass) {
    _birdBatch.birdType = birdClass;
    notifyListeners();
  }

  void setMonth(String month) {
    _birdBatch.month = month;
    notifyListeners();
  }

  void setDay(String day) {
    _birdBatch.day = day;
    notifyListeners();
  }

  void setYear(String year) {
    _birdBatch.year = year;
    notifyListeners();
  }

  // how many bathces of chickens does the farm have
  void setNumberOfbatches(int count) {
    _birdBatch.batchCount = count;
    notifyListeners();
  }

  void resetValues() {
    _birdBatch.batchName = "";
    _birdBatch.quantity = 0;
    _birdBatch.startDate = "";
    _birdBatch.birdType = "Broiler";
    _birdBatch.day = "1";
    _birdBatch.month = "January";
    _birdBatch.year = "2021";
    notifyListeners();
  }

  String get birdBatchName => _birdBatch.batchName;
  String get birdType => _birdBatch.birdType;
  String get startDate => _birdBatch.startDate;
  int get batchQuantity => _birdBatch.quantity;
  String get startMonth => _birdBatch.month;
  String get startDay => _birdBatch.day;
  String get startYear => _birdBatch.year;
  int get batchCount => _birdBatch.batchCount;
}
