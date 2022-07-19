import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Styles {
  static InputDecoration textFormFieldStyle(
      {String label = "",
      String hint = "",
      double fontSize = 12,
      double contentPadding = 18,
      FontWeight fontWeight = FontWeight.normal,
      Widget prefixIcon = const Padding(
        padding: EdgeInsets.all(0),
      )}) {
    return InputDecoration(
        contentPadding: EdgeInsets.all(contentPadding),
        prefixIcon: prefixIcon,
        labelText: label,
        alignLabelWithHint: true,
        hintText: hint,
        labelStyle: TextStyle(fontSize: fontSize.sp, fontWeight: fontWeight),
        border: OutlineInputBorder());
  }

  static BoxDecoration boxDecor(double radius,
      {double blurRad = 3,
      double offset = 2,
      Color color = Colors.white,
      Color blurColor = const Color.fromARGB(255, 224, 224, 224)}) {
    return BoxDecoration(
      color: color,
      boxShadow: [
        BoxShadow(
            color: blurColor, offset: Offset.fromDirection(offset), blurRadius: blurRad)
      ],
      borderRadius:  BorderRadius.circular(radius),
    );
  }

  static BoxDecoration boxDecorAll(double radius,
      {double blurRad = 3,
      double offset = 2,
      Color color = Colors.white,
      Color blurColor = const Color.fromARGB(255, 224, 224, 224)}) {
    return BoxDecoration(
      color: color,
      boxShadow: [
        BoxShadow(
            color: blurColor, offset: Offset.fromDirection(2), blurRadius: 3)
      ],
      borderRadius: BorderRadius.all(Radius.circular(radius)),
    );
  }

  static ButtonStyle elevatedButtonStyle(
      {double radius=0,double padding =8,Color buttonColor = Colors.deepOrangeAccent,required double width,required double height}) {
    return ElevatedButton.styleFrom(fixedSize: Size(width, height),padding: EdgeInsets.all(padding),
        primary: buttonColor, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)));
  }

  static TextStyle txtStyle(
      {Color color = Colors.black,
List<Shadow>? shadow=const [],
      double fontSize = 18,
      FontWeight fontWeight = FontWeight.normal}) {
    return TextStyle(shadows:shadow,
        color: color, fontSize: fontSize.sp, fontWeight: fontWeight);
  }
}
