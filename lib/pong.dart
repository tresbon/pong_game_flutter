import 'package:flutter/material.dart';
import 'ball.dart';
import 'bat.dart';

enum Direction { up, down, left, right }

class Pong extends StatefulWidget {
  @override
  _PongState createState() => _PongState();
}

class _PongState extends State<Pong> with SingleTickerProviderStateMixin {
  double width; // Screen width
  double height; // Screen height
  double posX = 0;
  double posY = 0;
  double batWidth = 0;
  double batHeight = 0;
  double batPosition = 0;

  //Animation controllers
  Animation<double> animation;
  AnimationController controller;
  double increment = 5;

  //Ball directions
  Direction vDir = Direction.down;
  Direction hDir = Direction.right;

  @override
  void initState() {
    posX = 0;
    posY = 0;
    controller = AnimationController(
      duration: const Duration(minutes: 10000),
      vsync: this,
    );
    animation = Tween<double>(begin: 0, end: 10).animate(controller);
    animation.addListener(() {
      setState(() {
        (hDir == Direction.right) ? posX += increment : posX -= increment;
        (vDir == Direction.down) ? posY += increment : posY -= increment;
      });
      checkBorders();
    });
    controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constrains) {
      width = constrains.maxWidth;
      height = constrains.maxHeight;
      batWidth = width / 5;
      batHeight = height / 20;
      return Container(
        width: width,
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              child: Ball(),
              top: posX,
              left: posY,
            ),
            Positioned(
              left: batPosition,
              child: GestureDetector(
                onHorizontalDragUpdate: (DragUpdateDetails update) =>
                    moveBat(update),
                child: Bat(batWidth, batHeight),
              ),
              bottom: 0,
            ),
          ],
        ),
      );
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void moveBat(DragUpdateDetails update) {
    setState(() {
      batPosition = clamp(batPosition += update.delta.dx, 0, width - width/5);
    });
  }

  double clamp(double number, double left, double right) {
    if (number < left) {
      return left;
    }
    if (number > right) {
      return right;
    }
    return number;
  }
  void checkBorders() {
    if (posX <= 0 && hDir == Direction.left) {
      hDir = Direction.right;
    }
    if (posX >= height - 50 && hDir == Direction.right) {
      hDir = Direction.left;
    }
    if (posY >= width - 50 && vDir == Direction.down) {
      vDir = Direction.up;
    }
    if (posY <= 0 && vDir == Direction.up) {
      vDir = Direction.down;
    }
  }
}
