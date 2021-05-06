import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:intl/intl.dart';

class Home extends StatelessWidget {
  final List<Color> _customColors = [
    Color(0XFF0D2C54),
    Color(0XFF0D2C54), //(0XFF009444),
    Color(0XFF0D2C54), //(0XFF888BB2),
  ];
  final _formatCurrency = NumberFormat.simpleCurrency(name: "₦");
  final List<String> _cardTitles = [
    "Total Sales",
    "Total Chickens",
    "Crates of Eggs"
  ];
  final List<String> _cardImages = [
    "images/icons8-total-sales-100.png",
    "images/icons8-chicken-100.png",
    "images/icons8-egg-100.png"
  ];
  final List<dynamic> _cardValues = [100000, "423", "30"];
  @override
  Widget build(BuildContext context) {
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 20),
          child: Align(
            alignment: Alignment.topLeft,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Color(0XFF35D4C0),
                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  "Hello Emmanuel",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Container(
            height: 150,
            child: Swiper(
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  decoration: BoxDecoration(
                    color: _customColors[index],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "${_cardImages[index]}",
                              scale: 2,
                              color: Color(0XFF35D4C0),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${_cardTitles[index]}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0XFF35D4C0),
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              (index == 0)
                                  ? "${_formatCurrency.format(_cardValues[index])}"
                                  : "${_cardValues[index]}",
                              style: TextStyle(
                                  fontSize: 25,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              loop: false,
              itemCount: 3,
              viewportFraction: 0.8,
              scale: 0.8,
              pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.white,
                  color: Colors.grey,
                ),
                margin: EdgeInsets.symmetric(vertical: 1),
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 20.0,
            top: 20.0,
          ),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              "Quick Options",
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFEFF4F5),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      height: 200,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "images/icons8-farm-house-100.png",
                            scale: 2.5,
                            color: Colors.black,
                          ),
                          Text(
                            "Stock Count",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Keep stock of items in your farm"),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0XFFEFF4F5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            10,
                          ),
                        ),
                      ),
                      height: 200,
                      padding: EdgeInsets.all(8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset(
                            "images/icons8-truck-100.png",
                            scale: 2.5,
                            color: Colors.black,
                          ),
                          Text(
                            "Open Orders",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text("Fulfill all open orders from distributors"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
