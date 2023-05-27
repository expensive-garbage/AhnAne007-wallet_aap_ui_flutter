import 'package:flutter/material.dart';

class ListTileButtonWidget extends StatelessWidget {
  final String imageAsset;
  final String tileHeader;
  final String tileSubName;
  const ListTileButtonWidget(
      {Key? key,
      required this.imageAsset,
      required this.tileHeader,
      required this.tileSubName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 80,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey.shade100),
                child: Image.asset(imageAsset),
              ),
              SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tileHeader,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    tileSubName,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ),
    );
  }
}
