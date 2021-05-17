import 'package:poultry/config/date.dart';

class Eggs {
  int collectedEggs;
  int goodEggs;
  int badEggs;
  double percent;

  Eggs({
    this.collectedEggs = 0,
    this.goodEggs = 0,
    this.badEggs = 0,
    this.percent = 0,
  });

  String get collectionDate => todaysDate;
}
