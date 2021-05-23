import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:poultry/config/date.dart';
import 'package:poultry/config/enumvals.dart';
import 'package:poultry/config/firebase.dart';
import 'package:poultry/providers/birds_prov.dart';
import 'package:poultry/providers/egg_prov.dart';
import 'package:poultry/widgets/stock_card.dart';
import 'package:provider/provider.dart';

class Stock extends StatefulWidget {
  @override
  _StockState createState() => _StockState();
}

class _StockState extends State<Stock> {
  Future<void> updateStockUI() async {
    //store.collection("stock_eggs").doc(auth.currentUser.uid).snapshots();
    DocumentReference documentRefEggs =
        store.collection('stock_eggs').doc(auth.currentUser.uid);
    DocumentReference documentRefChickens =
        store.collection('stock_chickens').doc(auth.currentUser.uid);
    store.runTransaction(
      (transaction) async {
        DocumentSnapshot<Map> eggSnapshot =
            await transaction.get(documentRefEggs);
        DocumentSnapshot<Map> chickenSnapshot =
            await transaction.get(documentRefChickens);
        if (eggSnapshot.exists) {
          if (eggSnapshot.data().containsKey(formatDate())) {
            Provider.of<EggProv>(
              context,
              listen: false,
            ).setPercent(1.0);
          } else {
            Provider.of<EggProv>(
              context,
              listen: false,
            ).setPercent(0.0);
          }
        }
        if (chickenSnapshot.exists) {
          Provider.of<BirdsProv>(context, listen: false).setNumberOfbatches(
            chickenSnapshot.data().length,
          );
        }
      },
    );
  }

  @override
  // ignore: must_call_super
  void initState() {
    updateStockUI();
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        StockCard(
          name: "Chickens",
          itemCount: Provider.of<BirdsProv>(context).batchCount,
          reportCategory: StockReport.chickens,
        ),
        StockCard(
          name: "Eggs",
          itemCount: 1,
          itemsCounted: Provider.of<EggProv>(context).percentage == 1.0 ? 1 : 0,
          reportCategory: StockReport.eggs,
          completionRate: Provider.of<EggProv>(context).percentage,
        ),
      ],
    );
  }
}
