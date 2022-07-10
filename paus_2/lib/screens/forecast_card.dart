import 'package:flutter/material.dart';

class ForecastTitle extends StatelessWidget {

  final now = DateTime.now().toLocal();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                Container(
                  color: Color.fromARGB(0, 255, 255, 255),
                  // decoration: BoxDecoration(
                  //   gradient: LinearGradient(
                  //     colors: [
                  //       Color(0xff4dc9e6),
                  //       Color(0xff210cae),
                  //     ]
                  //   ),
                  // ),
                  padding: EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      const Text(
                        "Today's forecast for Pune, Maharashtra",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(
                              color: Color(0x44000000),
                              offset: Offset(2, 2),
                              blurRadius: 5,
                            )
                          ]
                        ),
                      ),
                    ],
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
