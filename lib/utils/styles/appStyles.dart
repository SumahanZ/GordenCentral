import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(
    {required double size, required Color color, required FontWeight fw}) {
  return GoogleFonts.poppins(fontSize: size, color: color, fontWeight: fw);
}

TextStyle appStyleWithHt(
    {required double size,
    required Color color,
    required FontWeight fw,
    required double ht}) {
  return GoogleFonts.poppins(
      fontSize: size, color: color, fontWeight: fw, height: ht);
}

DecoratedBox backButtonStyle = DecoratedBox(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(width: 2),
  ),
  child: const Icon(Icons.arrow_back_ios_new_rounded),
);
