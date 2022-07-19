import 'dart:io';
import 'dart:async';
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
import 'package:tyser/core/view_models/post_view_model.dart';

import '../componants/colors.dart';
import '../componants/styles.dart';
import '../componants/title_text.dart';
import '../componants/ui_componant.dart';
import '../core/enums/device_type.dart';

class NewPostView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return GetBuilder<PostViewModel>(builder: (controller) {
      return Scaffold(appBar: AppBar(title:        TitleText(
        text: "New Post".tr,
        color: Colors.white,
      ),backgroundColor: CustomColors.darkBlue ,),
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.grey.shade100,
          body: InfoWidget(
            builder: (context, deviceInfo) {
              double width = deviceInfo.width;
              double height = deviceInfo.height;
              bool isMob =
                  deviceInfo.deviceType == DeviceType.mobile ? true : false;

              return SafeArea(
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Form(key: controller.newPostFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [

                        TextFormField(
                          onChanged: (v){
                          controller.postModel.caseTitle=v;
                        },
                          validator: (v){
                            if(v==null||v.isEmpty){
                              return 'This field cannot be empty'.tr;
                            }
                          },
                          decoration: Styles.textFormFieldStyle(
                              label: "Case".tr,),
                        ),
                        TextFormField(
                          onChanged: (v){
                            controller.postModel.university=v;
                          },
                          validator: (v){
                            if(v==null||v.isEmpty){
                              return 'This field cannot be empty'.tr;
                            }
                          },
                          decoration: Styles.textFormFieldStyle(
                              label: "University".tr,
                              hint: "In which university would you like the treatment to be?".tr),
                        ),
                        TextFormField(keyboardType: TextInputType.phone,
                          onChanged: (v){
                            controller.postModel.phoneNumber=v;
                          },
                          validator: (v){
                            if(v==null||v.isEmpty){
                              return 'This field cannot be empty'.tr;
                            }
                            else if(v.length<11){
                              return 'Invalid Phone Number'.tr;

                            }
                          },
                          decoration: Styles.textFormFieldStyle(label: "Phone".tr),
                        ),
                        TextFormField(
                          onChanged: (v){
                            controller.postModel.description=v;
                          },
                          validator: (v){
                            if(v==null||v.isEmpty){
                              return 'This field cannot be empty'.tr;
                            }
                          },
                          maxLines: 5,
                          decoration: Styles.textFormFieldStyle(
                              label: "Case Description".tr,
                              hint: "Describe the symptoms of the disease".tr),
                        ),
                        TitleText(
                          text: "Related Images".tr,
                          fontWeight: FontWeight.normal,
                          color: CustomColors.blue,
                        ),
                        SizedBox(
                            width: width,
                            height: height *(isMob?0.2:0.25),
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * (isMob?0.5:0.23),
                                    height: height * (isMob?0.2:0.2),
                                    decoration: Styles.boxDecorAll(5,
                                        color: CustomColors.blue),
                                    child: IconButton(
                                        onPressed: () =>
                                            controller.selectImages(),
                                        icon: Icon(
                                          Icons.add_to_photos,
                                          color: Colors.white,
                                          size: 30.w,
                                        )),
                                  ),
                                  SizedBox(
                                    width: width * 0.02,
                                  ),
                                  ListView.separated(
                                      physics: NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return Container(padding: EdgeInsets.all(5),
                                          child: Stack(clipBehavior: Clip.none,
                                            children: [
                                              SizedBox(
                                                width: width * (isMob?0.5:0.23),
                                                height: height * 0.2,
                                                child: Semantics(
                                                  child: Image.file(
                                                      File(controller
                                                          .images![index].path),
                                                      fit: BoxFit.fill),
                                                ),
                                              ),
                                              Positioned(top: -20,left: -20,
                                                child: IconButton(
                                                    onPressed: ()=>controller.removeImage(index),
                                                    icon: Icon(
                                                      Icons.remove_circle,
                                                      color: Colors.red,
                                                      size: 20.w,
                                                    )),
                                              )
                                            ],
                                          ),
                                        );
                                      },
                                      separatorBuilder: (context, index) {
                                        return SizedBox(
                                          width: width * 0.02,
                                        );
                                      },
                                      itemCount: controller.images!.length),
                                ],
                              ),
                            )),
                        Align(alignment: Alignment.center,
                          child: ElevatedButton(
                            onPressed:controller.loadingAddPost.value?null: () {controller.savePost();},
                            child: TitleText(
                              text: controller.loadingAddPost.value?"Loading..".tr:"Submit".tr,
                              color: Colors.white,
                            ),
                            style: Styles.elevatedButtonStyle(
                                width: width * 0.3,
                                height: height * 0.06,
                                radius: 10,
                                buttonColor: Colors.lightGreen),
                          ),
                        )
                      ],
                    ),
                  ),
                  color: Colors.white,
                  width: width,
                  height: height ,
                ),
              );
            },
          ));
    });
  }
}
