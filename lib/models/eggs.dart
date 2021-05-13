import 'package:poultry/config/date.dart';

class Eggs {
  int collectedEggs;
  int goodEggs;
  int badEggs;

  Eggs({
    this.collectedEggs = 0,
    this.goodEggs = 0,
    this.badEggs = 0,
  });

  String get collectionDate => todaysDate;
}
