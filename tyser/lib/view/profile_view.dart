import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tyser/componants/colors.dart';
import 'package:tyser/componants/images_list_view.dart';
import 'package:tyser/componants/loading_widget.dart';
import 'package:tyser/componants/post_card.dart';
import 'package:tyser/componants/search_bar.dart';
import 'package:tyser/componants/styles.dart';
import 'package:tyser/componants/title_text.dart';
import 'package:tyser/models/doctor_model.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/view/new_post_view.dart';
import '../componants/ui_componant.dart';
import '../core/enums/device_type.dart';
import '../core/view_models/home_view_model.dart';
import 'dart:io';
class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return GetBuilder<HomeViewModel>(builder: (controller) {
      return InfoWidget(
        builder: (context, deviceInfo) {
          double width = deviceInfo.width;
          double height = deviceInfo.height;
          log("height from login screen $height");

          bool isMob =
              deviceInfo.deviceType == DeviceType.mobile ? true : false;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Form(key: controller.updateFormKey,
              child: Column(
                children: [
                  SizedBox(
                    width: width,
                    height: height * 0.93,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Stack(
                              alignment: Alignment.center,
                              clipBehavior: Clip.none,
                              children: [
                                Positioned(
                                  child: CachedNetworkImage(
                                      imageUrl:
                                          "https://thumbor.forbes.com/thumbor/fit-in/x/https://www.forbes.com/health/wp-content/uploads/2021/10/does_medicare_cover_dental_getty_creative.jpeg",
                                      fit: BoxFit.fill),
                                ),
                                Positioned(
                                    top: height * 0.2,
                                    child:controller.newPicture==''? (controller.userModel!.picture == null ||
                                            controller.userModel!.picture!.isEmpty)
                                        ? CircleAvatar(
                                            backgroundColor:
                                                CustomColors.blueShadow,
                                            backgroundImage:
                                                // (post.userPhoto == null ||
                                                //     post.userPhoto!.isEmpty)
                                                //     ?
                                                AssetImage(
                                                    'assets/images/person.jpg')
                                            //  NetworkImage(post.userPhoto.toString())
                                            ,
                                            radius: height * 0.09,
                                          )
                                        : ClipOval(
                                      child: CachedNetworkImage(imageUrl:
                                      controller.newUserModel!.picture.toString(),
                                        width: width*0.34,
                                        height: width*0.34,placeholder:   (context, url) => Center(child:  CircularProgressIndicator(color: CustomColors.blue,)),
                                        errorWidget: (context, url, error) => Image.asset("assets/images/person.jpg"),fit: BoxFit.cover,
                                      ),
                                    ):ClipOval(

                                      // (post.userPhoto == null ||
                                      //     post.userPhoto!.isEmpty)
                                      //     ?
                                     child: Image.file(

                                         File(controller.newPicture), width: width*0.34,
                                       height: width*0.34,fit: BoxFit.cover,)
                                      //  NetworkImage(post.userPhoto.toString())
                                      ,
                                    )

                                ),
                                Container(
                                    margin: EdgeInsets.only(top: 150, left: 100),
                                    child: FloatingActionButton(backgroundColor: CustomColors.blueShadow,
                                      onPressed: () {
                                        controller.selectNewPic();
                                      },
                                      child: Icon(
                                        Icons.photo_camera,
                                        size: 25.w,
                                      ),
                                    )),
                              ]),
                          controller.loadingUpdateInfo?LoadingScreen(height*0.6, width):  Container(
                            margin: EdgeInsets.only(top:120),
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [

                                TextFormField(
                                  initialValue: controller.userModel!.userName,
                                  onChanged: (value) {
                                    controller.newUserModel!.userName = value;
                                  },
                                  validator: (v) {
                                    if (v!.isEmpty) {
                                      return 'Enter Your UserName'.tr;
                                    }
                                  },
                                  decoration: Styles.textFormFieldStyle(
                                      contentPadding: isMob ? 15 : 20,
                                      label: "User Name".tr,
                                      fontSize: 12,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                  initialValue: controller.userModel!.phone,
                                  keyboardType: TextInputType.phone,
                                  onChanged: (value) {
                                    controller.newUserModel!.phone = value;
                                  },
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Enter Your Phone Number';
                                    } else if (value.length != 11) {
                                      return 'Invalid Phone Number';
                                    }
                                  },
                                  decoration: Styles.textFormFieldStyle(
                                      contentPadding: isMob ? 15 : 20,
                                      label: "Phone Number".tr,
                                      fontSize: 12,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                  initialValue: controller.userModel!.governorate,
                                  onChanged: (value) {
                                    controller.newUserModel!.governorate = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Your Governorate';
                                    }
                                  },
                                  decoration: Styles.textFormFieldStyle(
                                      contentPadding: isMob ? 15 : 20,
                                      label: "Governorate".tr,
                                      fontSize: 12,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
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
                                  initialValue: controller.userModel!.address,
                                  onChanged: (value) {
                                    controller.newUserModel!.address = value;
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'Enter Your Address';
                                    }
                                  },
                                  decoration: Styles.textFormFieldStyle(
                                      contentPadding: isMob ? 15 : 20,
                                      label: "Address".tr,
                                      fontSize: 12,
                                      prefixIcon: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Icon(
                                          Icons.water_damage_outlined,
                                          size: 15.w,
                                        ),
                                      )),
                                ),
                                SizedBox(
                                  height: height * 0.03,
                                ),
                                (controller.userModel is DoctorModel)
                                    ? Column(
                                        children: [
                                          TextFormField(
                                            initialValue:
                                                controller.userModel is DoctorModel
                                                    ? (controller.userModel
                                                            as DoctorModel)
                                                        .university
                                                    : "",
                                            onChanged: (value) {
                                              (controller.newUserModel
                                                      as DoctorModel)
                                                  .university = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter Your University';
                                              }
                                            },
                                            decoration: Styles.textFormFieldStyle(
                                                contentPadding: isMob ? 15 : 20,
                                                label: "University".tr,
                                                fontSize: 12,
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.location_city,
                                                    size: 15.w,
                                                  ),
                                                )),
                                          ),
                                          SizedBox(
                                            height: height * 0.03,
                                          ),
                                          TextFormField(
                                            initialValue:
                                                controller.userModel is DoctorModel
                                                    ? (controller.userModel
                                                            as DoctorModel)
                                                        .level
                                                    : "",
                                            onChanged: (value) {
                                              (controller.userModel as DoctorModel)
                                                  .level = value;
                                            },
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'Enter Your Level';
                                              }
                                            },
                                            decoration: Styles.textFormFieldStyle(
                                                contentPadding: isMob ? 15 : 20,
                                                label: "Level".tr,
                                                fontSize: 12,
                                                prefixIcon: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.grade,
                                                    size: 15.w,
                                                  ),
                                                )),
                                          ),
                                        ],
                                      )
                                    : const SizedBox(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: controller.loadingUpdateInfo?null:() => controller.updateUserData(),
                    child:  TitleText(
                      text: controller.loadingUpdateInfo?"Loading..".tr:"Update".tr,
                      color: Colors.white,
                    ),
                    style: Styles.elevatedButtonStyle(
                        width: width,
                        height: height * 0.07,
                        buttonColor: CustomColors.blue),
                  )
                ],
              ),
            ),
          );
        },
      );
    });
  }
}
