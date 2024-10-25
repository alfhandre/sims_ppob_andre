import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Roboto {
  static custom({
    required text,
    required double fontSize,
    required FontWeight fontWeight,
    required Color color,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: fontSize, color: color, fontWeight: fontWeight),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }

  static bold({
    required text,
    required double fontSize,
    Color? color = Colors.black87,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w700),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }

  static regular({
    required text,
    required double fontSize,
    Color? color = Colors.black87,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: GoogleFonts.montserrat(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w500),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }

  static light({
    required text,
    required double fontSize,
    Color? color = Colors.black87,
    TextAlign? textAlign,
    TextOverflow? overflow,
    int? maxLines,
  }) {
    return Text(
      text,
      style: GoogleFonts.roboto(
          fontSize: fontSize, color: color, fontWeight: FontWeight.w300),
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
    );
  }
}
