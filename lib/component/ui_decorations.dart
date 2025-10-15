// lib/screen/bp/ui_decorations.dart
import 'package:flutter/material.dart';

BoxDecoration heartBoxDecoration({required Color color}) {
  return BoxDecoration(
    color: color,
    borderRadius: BorderRadius.circular(12),
  );
}

ShapeDecoration grayBoxDecoration() {
  return ShapeDecoration(
    color: Colors.white,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    shadows: const [
      BoxShadow(
        color: Color(0x3F000000),
        blurRadius: 4,
        offset: Offset(0, 2),
        spreadRadius: 0,
      ),
    ],
  );
}
