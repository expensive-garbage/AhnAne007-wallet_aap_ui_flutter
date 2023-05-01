import 'package:flutter/material.dart';
import 'package:wallet_app_ui/model/model_class_card.dart';

import '../model/model_class_card.dart';
import '../model/model_class_card.dart';

class CardWidget extends StatelessWidget {
  final CardModelClass cardObject;
  const CardWidget({Key? key, required this.cardObject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        width: 300,
        decoration: BoxDecoration(
          color: cardObject.color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Balance",
              style: TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              cardObject.getBalance().toString() + " Rs",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cardObject.getAccountNumber().toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
                Text(
                  cardObject.getExpiryMonth().toString() +"/"+ cardObject.getExpiryYear().toString(),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
