import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:poultry/chicken_report.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/egg_report.dart';

class StockCard extends StatelessWidget {
  final String name;
  final int itemCount;
  final int itemsCounted;
  final StockReport reportCategory;
  final double completionRate;
  StockCard({
    @required this.name,
    @required this.itemCount,
    @required this.reportCategory,
    this.itemsCounted = 0,
    this.completionRate = 0,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 20,
      ),
      child: Container(
        height: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
          ),
          color: Color(0XFFEFF4F5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Color(0XFF35D4C0),
                width: double.infinity,
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Next Report due: ",
                    ),
                    Text(
                      todaysDate,
                      style: TextStyle(
                        color: Color(0XFF35D4C0),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 1.5,
                color: Color(0XFF35D4C0),
              ),
              Text(
                name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              CircularPercentIndicator(
                radius: 140.0,
                lineWidth: 15.0,
                animation: true,
                percent: completionRate,
                center: Text(
                  "${completionRate * 100} %",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                footer: Text(
                  "$itemsCounted of $itemCount items complete",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17.0,
                  ),
                ),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Color(
                  0XFF35D4C0,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          reportCategory == StockReport.chickens
                              ? ChickenReport()
                              : EggReport(),
                    ),
                  );
                },
                child: Container(
                  width: 200,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    color: Color(0XFF35D4C0),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 7.0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Start report",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
