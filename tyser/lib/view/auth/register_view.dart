import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get.dart';
import 'package:flutter/painting.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:tyser/core/view_models/auth_view_model.dart';
import '../../componants/colors.dart';
import '../../componants/title_text.dart';
import '../../componants/ui_componant.dart';
import '../../core/enums/device_type.dart';
import '../../core/view_models/home_view_model.dart';
import '../../componants/styles.dart';
import 'login_view.dart';


class RegisterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InfoWidget(builder: (context, deviceInfo) {
      double width = deviceInfo.width;
      double height = deviceInfo.height;
      bool isMob = deviceInfo.deviceType == DeviceType.mobile ? true : false;

    try  {
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
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            child: Form(
                              key: controller.registerFormKey,
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
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
                                      height: height * 0.04,
                                    ),
                                    SizedBox(
                                      width: isMob ? width * 0.9 : width * 0.7,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          TitleText(
                                              text: 'Register'.tr,
                                              color: CustomColors.blue,
                                              fontSize: 30),
                                          TextButton(
                                              onPressed: () =>
                                                  Get.offAll(LoginView()),
                                              child: TitleText(
                                                text: "Sign In".tr,
                                                color: CustomColors.blue,
                                                fontSize: 15,
                                              )),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: height * 0.03,
                                    ),
                                    Container(
                                      width: isMob ? width * 0.9 : width * 0.7,
                                      alignment: Alignment.center,
                                      decoration: const BoxDecoration(
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey,
                                                blurRadius: 1,
                                                spreadRadius: .1)
                                          ],
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      padding: EdgeInsets.all(15),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          SizedBox(
                                            height: 0,
                                          ),
                                          TextFormField(
                                            onChanged: (value) {
                                              controller.name = value;
                                            },
                                            validator: (v) {
                                              if (v!.isEmpty) {
                                                return 'Enter Your UserName'.tr;
                                              }
                                            },
                                            decoration:
                                                Styles.textFormFieldStyle(
                                                    contentPadding:
                                                        isMob ? 15 : 20,
                                                    label: "User Name".tr,
                                                    fontSize: 12,
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.person,
                                                        size: 15.w,
                                                      ),
                                                    )),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          TextFormField(
                                            onChanged: (value) {
                                              controller.email = value;
                                            },
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
                                                        isMob ? 15 : 20,
                                                    label: "Email".tr,
                                                    fontSize: 12,
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
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          TextFormField(
                                            obscureText: true,
                                            onChanged: (value) {
                                              controller.password = value;
                                            },
                                            validator: (value) {
                                              if (value == null ||
                                                  value.length < 8) {
                                                return 'invalid password';
                                              }
                                            },
                                            decoration:
                                                Styles.textFormFieldStyle(
                                                    contentPadding:
                                                        isMob ? 15 : 20,
                                                    label: "Password".tr,
                                                    fontSize: 12,
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.lock,
                                                        size: 15.w,
                                                      ),
                                                    )),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          TextFormField(
                                            keyboardType: TextInputType.phone,
                                            onChanged: (value) {
                                              controller.phone = value;
                                            },
                                            validator: (value) {
                                              if (value == null) {
                                                return 'Enter Your Phone Number'.tr;
                                              } else if (value.length != 11) {
                                                return 'Invalid Phone Number'.tr;
                                              }
                                            },
                                            decoration:
                                                Styles.textFormFieldStyle(
                                                    contentPadding:
                                                        isMob ? 15 : 20,
                                                    label: "Phone Number".tr,
                                                    fontSize: 12,
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.phone,
                                                        size: 15.w,
                                                      ),
                                                    )),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          TextFormField(
                                            onChanged: (value) {
                                              controller.governorate = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter Your Governorate'.tr;
                                              }
                                            },
                                            decoration:
                                                Styles.textFormFieldStyle(
                                                    contentPadding:
                                                        isMob ? 15 : 20,
                                                    label: "Governorate".tr,
                                                    fontSize: 12,
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons.account_balance,
                                                        size: 15.w,
                                                      ),
                                                    )),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          TextFormField(
                                            keyboardType:
                                                TextInputType.emailAddress,
                                            onChanged: (value) {
                                              controller.address = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter Your Address'.tr;
                                              }
                                            },
                                            decoration:
                                                Styles.textFormFieldStyle(
                                                    contentPadding:
                                                        isMob ? 15 : 20,
                                                    label: "Address".tr,
                                                    fontSize: 12,
                                                    prefixIcon: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Icon(
                                                        Icons
                                                            .water_damage_outlined,
                                                        size: 15.w,
                                                      ),
                                                    )),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          controller.userType == 'doc'
                                              ? Column(
                                                  children: [
                                                    TextFormField(
                                                      onChanged: (value) {
                                                        controller.university =
                                                            value;
                                                      },
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Enter Your University'.tr;
                                                        }
                                                      },
                                                      decoration: Styles
                                                          .textFormFieldStyle(
                                                              contentPadding:
                                                                  isMob
                                                                      ? 15
                                                                      : 20,
                                                              label:
                                                                  "University"
                                                                      .tr,
                                                              fontSize: 12,
                                                              prefixIcon:
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                  Icons
                                                                      .location_city,
                                                                  size: 15.w,
                                                                ),
                                                              )),
                                                    ),
                                                    SizedBox(
                                                      height: height * 0.03,
                                                    ),
                                                    TextFormField(
                                                      onChanged: (value) {
                                                        controller.level =
                                                            value;
                                                      },
                                                      validator: (value) {
                                                        if (value!.isEmpty) {
                                                          return 'Enter Your Level'.tr;
                                                        }
                                                      },
                                                      decoration: Styles
                                                          .textFormFieldStyle(
                                                              contentPadding:
                                                                  isMob
                                                                      ? 15
                                                                      : 20,
                                                              label: "Level".tr,
                                                              fontSize: 12,
                                                              prefixIcon:
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        8.0),
                                                                child: Icon(
                                                                  Icons.grade,
                                                                  size: 15.w,
                                                                ),
                                                              )),
                                                    ),
                                                  ],
                                                )
                                              : const SizedBox(),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          Align(
                                            alignment: Alignment.center,
                                            child: ElevatedButton(
                                              onPressed: controller
                                                      .registerLoading.value
                                                  ? null
                                                  : () {
                                                      controller
                                                          .registerWithEmail();
                                                    },
                                              child: Text(
                                                controller.registerLoading.value
                                                    ? "Loading..".tr
                                                    : "Register".tr,
                                                style: Styles.txtStyle(
                                                    fontSize: 20,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                              style: Styles.elevatedButtonStyle(
                                                  padding: 1,
                                                  buttonColor:
                                                      CustomColors.blue,
                                                  width: isMob
                                                      ? width * 0.9
                                                      : width * 0.7,
                                                  height: isMob
                                                      ? height * 0.05
                                                      : height * 0.06),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: height * 0.03,
                                    // ),
                                    // Text(
                                    //   "-- ${"OR".tr} --",
                                    //   style: TextStyle(
                                    //       fontSize: ScreenUtil().setSp(18),
                                    //       fontFamily: 'Tajawal',
                                    //       fontWeight: FontWeight.bold,
                                    //       color: CustomColors.deepOrange),
                                    // ),
                                    // SizedBox(height: height * 0.03),
                                    // ElevatedButton(
                                    //   style: Styles.elevatedButtonStyle(
                                    //       width: width * 0.7,
                                    //       height: height * 0.05,
                                    //       buttonColor: Colors.white),
                                    //   onPressed: () {
                                    //      controller.signInWithGoogle();
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
                                    //         image: AssetImage(
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
                            ),
                          ),
                        ),
                      ))),
        );
      }catch(e){return Scaffold( body: Container(
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
              child: Container(
                padding: const EdgeInsets.symmetric(
                    vertical: 10, horizontal: 10),
                child: Column(children: [TitleText(text: "something wrong happened!"),TextButton(onPressed: ()=>Get.offAll(()=>LoginView()), child: Text('reload'))],),
              ),
            ))),);}
    });
  }
}
