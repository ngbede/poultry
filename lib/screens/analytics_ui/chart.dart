import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/constants.dart';
import 'package:poultry/widgets/picker.dart';

class Chart extends StatelessWidget {
  final double maxXValue;
  final double maxYValue;
  final List<LineChartBarData> lineBarData;
  Chart({
    @required this.maxXValue,
    @required this.maxYValue,
    @required this.lineBarData,
  });
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 0.9,
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                'Eggs Collected',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Center(
              child: customPicker(
                context,
                months,
                Color(0xffFAFAFA),
                "May",
                // TODO: Add month selection
                (value) => print("pick month"),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  left: 6.0,
                ),
                child: LineChart(
                  LineChartData(
                    lineTouchData: LineTouchData(
                      touchTooltipData: LineTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
                      ),
                      touchCallback: (LineTouchResponse touchResponse) {},
                      handleBuiltInTouches: true,
                    ),
                    gridData: FlGridData(
                        show: true,
                        drawHorizontalLine: true,
                        horizontalInterval: 5
                        // drawVerticalLine: true,
                        ),
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTextStyles: (value) => const TextStyle(
                          color: Color(0xff72719b),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        margin: 20,
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 1:
                              return '1';
                            case 5:
                              return '5';
                            case 9:
                              return '9';
                            case 13:
                              return '13';
                            case 17:
                              return '17';
                            case 21:
                              return '21';
                            case 25:
                              return '25';
                            case 29:
                              return '29';
                            case 31:
                              return '31';
                          }
                          return '';
                        },
                      ),
                      leftTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (value) => const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        getTitles: (value) {
                          switch (value.toInt()) {
                            case 0:
                              return '0';
                            case 20:
                              return '20';
                            case 40:
                              return '40';
                            case 60:
                              return '60';
                            case 80:
                              return '80';
                            case 100:
                              return '100';
                            case 120:
                              return '120';
                            case 140:
                              return '140';
                            case 160:
                              return '160';
                            case 180:
                              return '180';
                            case 200:
                              return '200';
                          }
                          return '';
                        },
                        margin: 5,
                        reservedSize: 30,
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: const Border(
                        bottom: BorderSide(
                          color: Colors.black, //(0xff4e4965),
                          width: 1,
                        ),
                        left: BorderSide(
                          color: Colors.black,
                          width: 1,
                        ),
                        right: BorderSide(
                          color: Colors.transparent,
                        ),
                        top: BorderSide(
                          color: Colors.transparent,
                        ),
                      ),
                    ),
                    minX: 1,
                    maxX: maxXValue,
                    maxY: maxYValue,
                    minY: 0,
                    lineBarsData: lineBarData,
                  ),
                  swapAnimationDuration: const Duration(milliseconds: 250),
                  //swapAnimationCurve: Curves.,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
