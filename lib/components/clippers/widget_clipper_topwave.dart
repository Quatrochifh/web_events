import 'package:flutter/material.dart';

class ClipperTopWave extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 150);
    path.quadraticBezierTo(
        size.width / 4, 160 /*180*/, size.width / 2, 155);
    path.quadraticBezierTo(
        3 / 4 * size.width, 150, size.width, 110);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}