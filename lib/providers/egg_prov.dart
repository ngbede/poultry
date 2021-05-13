import 'package:flutter/foundation.dart';
import 'package:poultry/models/eggs.dart';

// TODO: add extra checks for certain use cases when adding stock values
class EggProv with ChangeNotifier {
  final Eggs _egg = Eggs();

  void setEggsCollected(int count) {
    _egg.collectedEggs = count;
    notifyListeners();
  }

  void setGoodEggs() {
    if (_egg.collectedEggs != 0) {
      _egg.goodEggs = _egg.collectedEggs - _egg.badEggs;
      notifyListeners();
    } else {
      _egg.goodEggs = _egg.collectedEggs;
      notifyListeners();
    }
  }

  void setBadEggs(int count) {
    if (count <= _egg.collectedEggs) {
      _egg.badEggs = count;
      notifyListeners();
    }
  }

  void resetValues() {
    _egg.badEggs = 0;
    _egg.goodEggs = 0;
    _egg.collectedEggs = 0;
    notifyListeners();
  }

  int get totalEggs => _egg.collectedEggs;
  int get totalGoodEggs => _egg.goodEggs;
  int get totalBadEggs => _egg.badEggs;
  String get collectionDate => _egg.collectionDate;
}
