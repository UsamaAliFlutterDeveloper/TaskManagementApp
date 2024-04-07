import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../colors/colors.dart';

TextStyle kmyTS14({
  double? size = 14.0, // explicitly specify the type as double?
  Color color = kwhiteColor,
  FontWeight weight = FontWeight.w400,
}) {
  return GoogleFonts.inter(
    fontSize: size,
    color: color,
    fontWeight: weight,
  );
}
