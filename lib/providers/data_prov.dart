import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';

class DataProv with ChangeNotifier {
  List<FlSpot> _dataPoints = [];

  void addDataPoint(List<FlSpot> data) {
    _dataPoints = data;
    notifyListeners();
  }

  void clearDataPointList() {
    _dataPoints = [];
  }

  List<FlSpot> get dataPacket => _dataPoints;
}
