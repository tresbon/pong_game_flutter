import 'package:flutter/material.dart';

class Bat extends StatelessWidget {
  final double witdth;
  final double height;

  Bat(this.witdth,this.height);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: witdth,
      height: height,
      decoration: new BoxDecoration(
        color: Colors.orange[800]
      ),
    );
  }
}
