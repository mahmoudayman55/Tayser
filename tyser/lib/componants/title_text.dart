import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../componants/styles.dart';

class TitleText extends StatelessWidget {
  final String text;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final List<Shadow>? shadow;
  const TitleText(
      {
        required this.text,
        this.shadow=const[],
        this.textAlign=TextAlign.start,
        this.fontSize = 18,
        this.color = Colors.black,
        this.fontWeight = FontWeight.w800});
  @override
  Widget build(BuildContext context) {
    return Text(text,textAlign: textAlign,
        maxLines: 2,
        style: Styles.txtStyle(shadow: shadow,fontSize: fontSize, fontWeight: fontWeight, color: color,));
  }
}