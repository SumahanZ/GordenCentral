import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle appStyle(
    {required double size, required Color color, required FontWeight fw}) {
  return GoogleFonts.poppins(fontSize: size.sp, color: color, fontWeight: fw);
}

TextStyle appStyleWithHt(
    {required double size,
    required Color color,
    required FontWeight fw,
    required double ht}) {
  return GoogleFonts.poppins(
      fontSize: size.sp, color: color, fontWeight: fw, height: ht.h);
}

DecoratedBox backButtonStyle = DecoratedBox(
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    border: Border.all(width: 2.w),
  ),
  child: const Icon(Icons.arrow_back_ios_new_rounded),
);
