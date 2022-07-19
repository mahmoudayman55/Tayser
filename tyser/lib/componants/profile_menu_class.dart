import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tyser/componants/styles.dart';
import '../componants/colors.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({

    required this.text,
    required this.icon,
    required this.press,
    required this.width,
    required this.height,
    this.buttonColor=const Color(0xFFF5F6F9),
    this.titleColor= const Color.fromARGB(255, 9,35,71),
   this.fontSize=18,
    this.showArrow=true
  }) ;

final double fontSize;
final double width;
final double height;
final Color buttonColor;
final Color titleColor;
  final String text;
 final Icon icon;
  final VoidCallback press;
final  bool showArrow;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ElevatedButton(
        style: Styles.elevatedButtonStyle(width: width, height: height,buttonColor: buttonColor,radius: 10),
        onPressed: press,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            showArrow? icon:Text('')  ,
            SizedBox(width: width*0.1),
            Expanded(child: AutoSizeText(text.tr,style: TextStyle(fontSize: fontSize.sp,color: titleColor,fontWeight: FontWeight.normal),)),
            showArrow? Icon(Icons.arrow_forward_ios,color: titleColor,size: 15.w,):icon,
          ],
        ),
      ),
    );
  }
}