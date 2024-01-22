import 'package:flutter/material.dart';

class Sphere extends StatelessWidget {
  final double radius;
  final Color color;
  final Widget widget;

  Sphere({super.key, required this.radius, required this.color, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
             //* Center color (brighter)
            color.withOpacity(0.4),

            //* Outer color (darker)
            color.withOpacity(0.8), 
          ],
          stops: [0.5, 1.0],
        ),
      ),
      child: widget,
    );
  }
}