import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double height, width, radius;
  const Skeleton({
    super.key,
    this.height = 40,
    this.width = 100,
    this.radius = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}