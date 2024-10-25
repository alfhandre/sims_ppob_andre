import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const double defaultMargin = 15.0;
const double defaultTop = 8;

Color primaryColor = Colors.orange[800]!;
Color secondaryColor = const Color(0xffB1B1B1);
Color chatColor = const Color(0xFF6697AE);
Color alertColor = const Color(0xFFDC0101);
Color textColor1 = const Color(0xFF323232);
Color textColor2 = const Color(0xFF808080);
Color backgroundColor1 = const Color(0xFFFFFFFF);
Color backgroundColor2 = const Color(0xF2F2F2f2);
Color borderColor = const Color.fromARGB(255, 210, 210, 210);
Color backgroundColorSnackbar = const Color.fromARGB(255, 250, 229, 195);
//
Color colorsTextPrimary = const Color(0xff000000);
Color colorsTextSecondary = const Color(0xff212529);
Color colorsTextHint = const Color(0xffB1B1B1);

TextStyle primaryTextStyle = GoogleFonts.montserrat(
  color: colorsTextPrimary,
);

TextStyle secondaryTextStyle = GoogleFonts.montserrat(
  color: colorsTextSecondary,
);

TextStyle hintTextStyle = GoogleFonts.montserrat(color: colorsTextHint);

TextStyle dateTextStyle = GoogleFonts.montserrat(
  color: chatColor,
);

TextStyle buttonTextStyle = GoogleFonts.montserrat(
  color: backgroundColor1,
);

FontWeight light = FontWeight.w300;
FontWeight reguler = FontWeight.w400;
FontWeight medium = FontWeight.w500;
FontWeight semiBold = FontWeight.w600;
FontWeight bold = FontWeight.w700;
