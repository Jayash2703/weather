import 'package:flutter/material.dart';
import 'package:paus_2/screens/forecast_card.dart';

class UVICard extends StatelessWidget {
  UVICard(this.uvi);

  double? uvi;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      color: Colors.lightBlue[100],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Text(
                    "UV Index - " + uvi.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  LinearProgressIndicator(
                    value: (uvi ?? 3.0 / 12.0),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
