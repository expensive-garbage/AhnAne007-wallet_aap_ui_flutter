import 'package:flutter/material.dart';

import '../pages/user_send_page.dart';

class ShadowButtonWidget extends StatelessWidget {
  final String iconImagePath;
  final String buttonText;

  const ShadowButtonWidget(
      {Key? key, required this.iconImagePath, required this.buttonText,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: [
        Container(
          height: 100,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400, blurRadius: 40, spreadRadius: 10),
            ],
          ),
          child: Center(
            child: Image.asset(iconImagePath),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          buttonText,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[700],
          ),
        )
      ]);
  }
}
