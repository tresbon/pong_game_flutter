import 'package:flutter/material.dart';
import 'ball.dart';
import 'bat.dart';

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width;
  double height;
  double posX;
  double posY;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  Animation<double> animation;
  AnimationController controller;

  @override
  void initState(){
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 100).animate(controller);
    animation.addListener(() {
      setState(() {
        posX++;
        posY++;
      });
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
          width  = constrains.maxWidth;
          height = constrains.maxHeight;
          batWidth = width / 5;
          batHeight = height / 20;
      return Stack(
        children: <Widget>[
          Positioned(
            child: Ball(),
            top: posX,
            left: posY,
          ),
          Positioned(
            child: Bat(batWidth, batHeight),
            bottom: 0,
          ),
        ],
      );
    });
  }
}
