
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tyser/core/view_models/auth_view_model.dart';
import 'package:tyser/view/auth/login_view.dart';
import 'package:tyser/view/home_view.dart';
import 'package:tyser/view/navigator_view.dart';



import '../componants/colors.dart';
import '../componants/ui_componant.dart';
import '../core/view_models/controle_view_model.dart';




class ControlView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Obx((){
      return Get.find<AuthViewModel>().user !=null? NavigatorView():LoginView();
    });


  }
}

// GetBuilder<ControlViewModel>(
// builder: (controller) => Scaffold(
//
// resizeToAvoidBottomInset: false,
// appBar: AppBar(
// actions: [
// Padding(
// padding: const EdgeInsets.symmetric(horizontal:15.0),
// child: PopupMenuButton<String>(
// onSelected: (value){
// controller.changeLanguage(value);
// },
// icon:  Padding(
// padding: const EdgeInsets.only(bottom: 5.0),
// child: Icon(Icons.language,color: CustomColors.blue,size: ScreenUtil().setWidth(18),),
// ),
// itemBuilder: (context)=>[
// // const PopupMenuItem(child: Text('EN')),
// const PopupMenuItem(child: SizedBox(child: Text('AR')),value: "ar",),
// const PopupMenuItem(child: SizedBox(child: Text('EN')),value: "en",),
// ]
// ),
// )
// ],
// centerTitle: true,
// backgroundColor: Colors.grey.shade100,
// bottomOpacity: 0,
// elevation: 0,
// title: AutoSizeText(
// "تيسير",
// style: TextStyle(
// fontSize: ScreenUtil().setSp(20),
// color: CustomColors.blue,fontFamily: "Tajawal",
// fontWeight: FontWeight.bold),
// ),
// ),
//
//
// bottomNavigationBar: controller.bottomNavigation(),
// backgroundColor: Colors.white,
// body:InfoWidget(builder: (context, deviceInfo) {
// double width=deviceInfo.width;
// double height=deviceInfo.height;
//
//
// return SizedBox(
// height: height,
// width: width,
// child: controller.currentScreen);
// }))
// );