import 'package:flutter/material.dart';
import 'package:maps_app/markers/markers.dart';

class TestMarkerScreen extends StatelessWidget {
  const TestMarkerScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 150,
          width: 350,
          color: Colors.red,
          child: CustomPaint(
            painter: EndMarkerPainter(
              destination: 'Roosters Rest & snack Bar',
              kilometers: 86
            ),
          ),
        ),
      ),
    );
  }
}