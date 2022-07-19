import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../componants/colors.dart';

class SearchBar extends StatelessWidget{
double? height,width,secondColorRadius,mainRadius;

 Function() onTapSearch;
SearchBar(this.height, this.width,this.secondColorRadius,this.mainRadius,this.onTapSearch, {Key? key}) : super(key: key);

@override
  Widget build(BuildContext context) {
    // TODO: implement build
return Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [

    Container(
alignment: Alignment.center,
          width: width,

          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Row(
mainAxisAlignment: MainAxisAlignment.start,
            children: [


              SizedBox(
                height: height,
                width: width!*0.15,

                  child: Icon(Icons.search,color: CustomColors.blue,size: ScreenUtil().setWidth(18),)),
              SizedBox(
                width: width!*0.55,
                child: TextFormField(style:  TextStyle(fontSize: ScreenUtil().setSp(12),color: Colors.black),

                  decoration:   InputDecoration.collapsed(

                      hintText: 'Search...'.tr,
                      hintStyle: TextStyle(color: Colors.grey)

                  ),

                ),
              ),
              GestureDetector(
                onTap: ()=>onTapSearch(),
                child: Container(
                  alignment: Alignment.center,
                  child: AutoSizeText("Search".tr,style: TextStyle(color: Colors.white,fontSize: ScreenUtil().setSp(12)),),
width: width!*0.3,
                  height: height,
                  decoration: BoxDecoration(color:CustomColors.blue,borderRadius: BorderRadius.circular(mainRadius!)),

                ),
              )

            ],
          ),
      height: height,
      decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.circular(mainRadius!)),

    ),



  ],
);
    throw UnimplementedError();
  }

}