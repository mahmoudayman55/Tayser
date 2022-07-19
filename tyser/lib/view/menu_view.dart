import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:tyser/componants/loading_widget.dart';
import 'package:tyser/componants/title_text.dart';
import 'package:tyser/view/profile_view.dart';



import '../componants/colors.dart';
import '../componants/profile_menu_class.dart';
import '../componants/styles.dart';
import '../componants/ui_componant.dart';
import '../core/enums/device_type.dart';
import '../core/view_models/home_view_model.dart';


class MenuView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return GetBuilder<HomeViewModel>(builder: (controller) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: InfoWidget(
          builder: (context, deviceInfo) {
            double width = deviceInfo.width;
            double height = deviceInfo.height;
            bool isMob =
                deviceInfo.deviceType == DeviceType.mobile ? true : false;
            return SizedBox(
              width: width,
              height: height,
              child:   controller.loading?LoadingScreen(height, width)  :   Padding(
                padding: const EdgeInsets.all(15.0),
                child:Column(mainAxisAlignment: MainAxisAlignment.center,
                        children: [

                   SizedBox(

                              child:
                              (controller.userModel== null)
                                  ?
                              CircleAvatar(
                                backgroundColor: Colors.lightGreen,
                                backgroundImage:
                                const AssetImage('assets/images/person.jpg')
                                ,
                                radius: height * 0.09,
                              ):    ClipOval(
                                child: CachedNetworkImage(imageUrl:
                                controller.userModel!.picture.toString(),
                                  width: width*0.34,
                                  height: width*0.34,placeholder:   (context, url) => Center(child:  CircularProgressIndicator(color: CustomColors.blue,)),
                                  errorWidget: (context, url, error) => Image.asset("assets/images/person.jpg"),fit: BoxFit.cover,
                                ),
                              )),
                          TitleText(text: controller.userModel!.userName.toString(),color: CustomColors.blue,)
                          ,
                          SizedBox(height: height*0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                ProfileMenu(width: width*0.8,
                                  text: "Account",
                                  icon: Icon(Icons.person,color: CustomColors.deepBlue,),
                                  press: () => Get.to(()=>ProfileView()), height: height*0.07,
                                ),

                                ProfileMenu(width: width*0.8,height: height*0.07,
                                  text: "Sign Out",
                                  icon: Icon(Icons.logout,color: CustomColors.deepBlue,),
                                  press: () =>controller.signOut(),
                                ),
                              ],
                            ),
                          ),


                        ],
                      )

              ),
            );
          },
        ),
      );
    });
  }
}
