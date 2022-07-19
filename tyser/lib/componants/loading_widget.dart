import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tyser/componants/colors.dart';

class LoadingScreen extends StatelessWidget{
  double height,width;

  LoadingScreen(this.height, this.width);

  @override
  Widget build(BuildContext context) {
  return Container(
      height: height,
      width: width,
      alignment: Alignment.center,
      child: SpinKitFadingFour(
        color: CustomColors.blue,
        size: 40.w,
      ));
  }

}