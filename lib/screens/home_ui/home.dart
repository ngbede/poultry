import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/shared_pref.dart';
import 'package:poultry/widgets/quick_option_card.dart';

class Home extends StatefulWidget {
  // final _formatCurrency = NumberFormat.simpleCurrency(name: "₦");
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<String> _cardTitles = [
    "Open Orders",
    "Total Chickens",
    "Eggs Collected"
  ];

  final List<String> _cardImages = [
    "images/icons8-total-sales-100.png",
    "images/icons8-chicken-100.png",
    "images/icons8-egg-100.png"
  ];

  List<dynamic> _cardValues = [
    prefs.getInt("openOrders"),
    prefs.getInt("totalChickens"),
    prefs.getInt("eggsCollected"),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView(
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
                Expanded(
                  child: Text(
                    "Welcome, ${prefs.getString("name")}",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
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
                    color: Color(0XFF0D2C54),
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
                              "${_cardValues[index]}",
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
                  QuickOptionCard(
                    navToScreen: 1,
                    imagePath: "images/icons8-farm-house-100.png",
                    title: "Stock Count",
                    infoText: "Keep stock of goods in your farm",
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  QuickOptionCard(
                    navToScreen: 2,
                    imagePath: "images/icons8-truck-100.png",
                    title: "Open Orders",
                    infoText: "Fulfill all open orders from distributors",
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
