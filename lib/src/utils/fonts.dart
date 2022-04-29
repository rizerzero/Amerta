import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final headerFont = GoogleFonts.overlock();
final headerFontWhite = headerFont.copyWith(color: Colors.white);

final bodyFont = GoogleFonts.aBeeZee();
TextTheme bodyFontTheme(BuildContext context) =>
    GoogleFonts.aBeeZeeTextTheme(Theme.of(context).textTheme);
final bodyFontWhite = bodyFont.copyWith(color: Colors.white);
