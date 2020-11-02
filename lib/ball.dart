import 'package:flutter/material.dart';

class Ball extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final double diam = 50;
    return Container(
      height: diam,
      width: diam,
      decoration:  new BoxDecoration(
        color: Colors.yellow[600],
        shape: BoxShape.circle,
      ),
    );
  }
}