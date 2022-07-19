import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/componants/form_keys.dart';
import 'package:tyser/core/view_models/auth_view_model.dart';
import 'package:tyser/view/auth/register_view.dart';

import '../../componants/colors.dart';
import '../../componants/search_bar.dart';
import '../../componants/title_text.dart';
import '../../componants/ui_componant.dart';
import '../../core/enums/device_type.dart';
import '../../core/view_models/controle_view_model.dart';
import '../../core/view_models/home_view_model.dart';

import 'package:email_validator/email_validator.dart';

import '../../componants/colors.dart';
import '../../componants/styles.dart';
import '../../core/enums/device_type.dart';
import '../../core/view_models/home_view_model.dart';
import 'login_view.dart';

class LoginView extends StatelessWidget {
  static final GlobalKey<FormState> _signInFormKey = GlobalKey<FormState>(debugLabel: 'signinKey');

  @override
  Widget build(BuildContext context) {

    return InfoWidget(builder: (context, deviceInfo) {

      double width = deviceInfo.width;
      double height = deviceInfo.height;
      bool isMob = deviceInfo.deviceType == DeviceType.mobile ? true : false;

      return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [CustomColors.blue, Colors.white],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                    stops: const [.25, .25])),
            width: width,
            height: height,
            child: GetBuilder<AuthViewModel>(
                builder: (controller) => SafeArea(
                      child: SingleChildScrollView(
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 90, horizontal: 10),
                          child: Stack(alignment: Alignment.center,
                            children: [
                              Container(alignment: Alignment.center,child: Column(mainAxisAlignment: MainAxisAlignment.center,children: [
                                Text("something went wrong"),
                                TextButton(onPressed: ()=>(Get.offAll(LoginView())), child: Text('reload'.tr))
                              ],),),
                              Form(
                              key: _signInFormKey,

                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TitleText(
                                        text: "Tayser",
                                        fontSize: 40,
                                        color: CustomColors.darkBlue,
                                        shadow: [
                                          Shadow(
                                              color: CustomColors.blue,
                                              blurRadius: 5)
                                        ]),
                                    SizedBox(
                                      height: height * 0.06,
                                    ),
                                    SizedBox(
                                      width: isMob ? width * 0.9 : width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TitleText(
                                              text: 'Sign In'.tr,
                                              color: CustomColors.blue,
                                              fontSize: 30),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    Container(
                                      width: isMob ? width * 0.9 : width * 0.7,
                                      alignment: Alignment.center,
                                      decoration: Styles.boxDecor(15),
                                      padding: EdgeInsets.all(15),
                                      child: Form(key: controller.signInFormKey,


                                        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            SizedBox(
                                              child: TextFormField(keyboardType: TextInputType.emailAddress,
                                                onChanged: (value) => controller
                                                    .onEmailChanged(value),
                                                validator: (value) {
                                                  if (value == null ||
                                                      !EmailValidator.validate(
                                                          value)) {
                                                    return 'invalid email'.tr;
                                                  }
                                                },
                                                decoration:
                                                    Styles.textFormFieldStyle(
                                                        contentPadding:
                                                            isMob ? 15 : 35,
                                                        label: "Email".tr,
                                                        fontSize: 15,
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsets.all(
                                                                  8.0),
                                                          child: Icon(
                                                            Icons.email,
                                                            size: 15.w,
                                                          ),
                                                        )),
                                              ),
                                            ),
                                            SizedBox(
                                              height: height * 0.03,
                                            ),
                                            TextFormField(obscureText: true,
                                              onChanged: (value) => controller
                                                  .onPasswordChanged(value),
                                              validator: (value) {
                                                if (value == null||value.isEmpty) {
                                                  return 'This field cannot be empty'.tr;
                                                } else if (value.length < 8) {
                                                  return 'invalid password'.tr;
                                                }
                                              },
                                              decoration: Styles.textFormFieldStyle(
                                                  contentPadding: isMob ? 15 : 35,
                                                  fontSize: 15,
                                                  prefixIcon: Padding(
                                                    padding:
                                                        const EdgeInsets.all(8.0),
                                                    child: Icon(
                                                      Icons.lock,
                                                      size: 15.w,
                                                    ),
                                                  ),
                                                  label: "Password".tr),
                                            ),
                                            SizedBox(
                                              height: height * 0.03,
                                            ),
                                            ElevatedButton(
                                              onPressed:
                                                  controller.signInLoading.value
                                                      ? null
                                                      : () => controller
                                                          .signInWithEmail(),
                                              child: Text(
                                                controller.signInLoading.value
                                                    ? "loading.."
                                                    : "Sign In".tr,
                                                style: Styles.txtStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              style: Styles.elevatedButtonStyle(
                                                  buttonColor: CustomColors.blue,
                                                  padding: 1,
                                                  width: isMob
                                                      ? width * 0.9
                                                      : width * 0.7,
                                                  height: isMob
                                                      ? height * 0.05
                                                      : height * 0.06),
                                            ),

                                            GestureDetector(onTap: (){

                                              snackBar("", "سمي الله بس كده وانت تفتكر",messageColor: Colors.white);
                                            },
                                              child: TitleText(fontWeight: FontWeight.normal,
                                                    text: "forget password".tr+"?",
                                                    color: CustomColors.blue,
                                                    fontSize: 15,
                                                  ),
                                            ),  TitleText(
                                                  text: "Register as".tr,
                                                  color: CustomColors.blue,
                                                  fontSize: 15,
                                                ),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                                              TextButton(
                                                  onPressed: () {
                                                    controller.userType='doc';
                                                    controller.update();
                                                    Get.to(RegisterView());
                                                  },
                                                  child: TitleText(fontWeight: FontWeight.normal,
                                                    text: "doctor".tr,
                                                    color: CustomColors.blue,
                                                    fontSize: 15,
                                                  )),       TextButton(
                                                  onPressed: () {
                                                    controller.userType='patient';
                                                  controller.update();
                                                    Get.to(RegisterView());

                                                  },
                                                  child: TitleText(fontWeight: FontWeight.normal,
                                                    text: "patient".tr,
                                                    color: CustomColors.blue,
                                                    fontSize: 15,
                                                  )),
                                            ],)
                                          ],
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: height * 0.025,
                                    // ),
                                    // Text(
                                    //   "-- ${"OR".tr} --",
                                    //   style: TextStyle(
                                    //       fontSize: ScreenUtil().setSp(18),
                                    //       fontFamily: 'Tajawal',
                                    //       fontWeight: FontWeight.bold,
                                    //       color: CustomColors.deepOrange),
                                    // ),
                                    // ElevatedButton(
                                    //   style: Styles.elevatedButtonStyle(
                                    //       width: width * 0.7,
                                    //       height: height * 0.05,
                                    //       buttonColor: Colors.white),
                                    //   onPressed: () {
                                    //     controller.signInWithGoogle();
                                    //   },
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       Text(
                                    //         "Sign In With Google".tr,
                                    //         style: Styles.txtStyle(
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 13),
                                    //       ),
                                    //       Image(
                                    //         image: const AssetImage(
                                    //             'assets/images/search.png'),
                                    //         width: width * 0.05,
                                    //         height: width * 0.05,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                    // SizedBox(height: height * 0.02),
                                    // ElevatedButton(
                                    //   style: Styles.elevatedButtonStyle(
                                    //       width: width * 0.7,
                                    //       height: height * 0.05,
                                    //       buttonColor: Colors.blue),
                                    //   onPressed: () {
                                    //     //   controller.googleSignInMethod();
                                    //   },
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.spaceEvenly,
                                    //     children: [
                                    //       Text(
                                    //         "Sign In With FaceBook".tr,
                                    //         style: Styles.txtStyle(
                                    //             color: Colors.white,
                                    //             fontWeight: FontWeight.bold,
                                    //             fontSize: 13),
                                    //       ),
                                    //       Icon(
                                    //         Icons.facebook,
                                    //         color: Colors.white,
                                    //         size: 20.w,
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),
                                  ]),
                            )],
                          ),
                        ),
                      ),
                    ))),
      );
    });
  }
}
