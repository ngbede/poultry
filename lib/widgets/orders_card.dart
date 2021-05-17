import 'package:flutter/material.dart';
import 'package:poultry/order_form.dart';

class OrderCard extends StatelessWidget {
  final String status;
  final String name; // of distributore
  final int productCount;
  final String contact;
  final String address;
  final String date;
  final String id;
  OrderCard({
    @required this.status,
    @required this.name,
    @required this.productCount,
    @required this.contact,
    @required this.address,
    @required this.date,
    @required this.id,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => OrderForm(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(
          height: 150,
          child: Card(
            child: Row(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  width: 20,
                  color: status == "PENDING" ? Colors.amber : Color(0XFF35D4C0),
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: Text(
                      status.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        letterSpacing: 3.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "From $name",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text("Products: $productCount"),
                        Text("Contact: $contact"),
                        Text("Address: $address "),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      right: 2,
                      bottom: 8.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("$date"),
                        Text("ID: $id")
                        //  Text("Benue")
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
