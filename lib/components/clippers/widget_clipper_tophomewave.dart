import 'package:flutter/material.dart';

class ClipperTopHomeWave extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 100);
    path.quadraticBezierTo(
        size.width / 4, 90 /*180*/, size.width / 2, 105);
    path.quadraticBezierTo(
        3 / 4 * size.width, 113, size.width, 86);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}