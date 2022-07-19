import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tyser/componants/colors.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/componants/images_list_view.dart';
import 'package:tyser/componants/post_card.dart';
import 'package:tyser/componants/search_bar.dart';
import 'package:tyser/componants/styles.dart';
import 'package:tyser/componants/title_text.dart';
import 'package:tyser/core/functions/requests_services.dart';
import 'package:tyser/core/services/firestore_request.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/request_model.dart';
import 'package:tyser/view/new_post_view.dart';
import '../componants/ui_componant.dart';
import '../core/enums/device_type.dart';
import '../core/view_models/home_view_model.dart';

class PostDetailsView extends StatelessWidget {
  PostModel post;

  PostDetailsView(this.post, {Key? key}) : super(key: key);

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
            body: Column(
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
                              Container(
                                child: CachedNetworkImage(
                                    imageUrl:
                                        "https://thumbor.forbes.com/thumbor/fit-in/x/https://www.forbes.com/health/wp-content/uploads/2021/10/does_medicare_cover_dental_getty_creative.jpeg",
                                    fit: BoxFit.fill),
                                width: width,
                                height: height * 0.3,
                                decoration: Styles.boxDecorAll(0,
                                    color: CustomColors.darkBlue),
                              ),
                              Positioned(
                                  top: height * 0.2,
                                  child: (post.userPhoto == null ||
                                          post.userPhoto!.isEmpty)
                                      ? CircleAvatar(
                                          backgroundColor: Colors.white,
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
                                      : CircleAvatar(
                                          backgroundColor: Colors.grey,
                                          backgroundImage:
                                              // (post.userPhoto == null ||
                                              //     post.userPhoto!.isEmpty)
                                              //     ?
                                              //AssetImage('assets/images/person.jpg')
                                              NetworkImage(
                                                  post.userPhoto.toString()),
                                          radius: height * 0.09,
                                        ))
                            ]),
                        Align(
                          alignment: Alignment.center,
                          child: Container(
                            margin:
                                EdgeInsetsDirectional.only(top: height * 0.09),
                            child: TitleText(
                              text: "${post.userName}",
                              color: CustomColors.darkBlue,
                            ),
                          ),
                        ),
                        SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    bottom: height * 0.03, top: height * 0.03),
                                decoration: Styles.boxDecorAll(10),
                                height: height * 0.25,
                                clipBehavior: Clip.none,
                                width: width,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TitleText(
                                            text:
                                                "${"Case".tr}: ",
                                            color: CustomColors.blue,
                                            fontSize: 15),
                                        TitleText(
                                            text: "${"University".tr}: ",
                                            color: CustomColors.blue,
                                            fontSize: 15),
                                        TitleText(
                                            text: "${"Phone Number".tr}: ",
                                            color: CustomColors.blue,
                                            fontSize: 15),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        TitleText(
                                            text: "${post.caseTitle}",
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                        TitleText(
                                            text: "${post.university}",
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                        TitleText(
                                            text: "${post.phoneNumber}",
                                            color: Colors.black,
                                            fontWeight: FontWeight.normal,
                                            fontSize: 15),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                child: TitleText(
                                    text: "${"Description".tr}: ",
                                    color: CustomColors.blue,
                                    fontSize: 15),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: SizedBox(
                                    width: width * 0.8,
                                    child: AutoSizeText("${post.description}")),
                              ),
                              Container(
                                margin: EdgeInsetsDirectional.only(
                                    top: height * 0.03),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 15.0,
                                ),
                                child: TitleText(
                                    text: "${"Related Images".tr}: ",
                                    color: CustomColors.blue,
                                    fontSize: 15),
                              ),
                              SizedBox(
                                width: width,
                                height: height * 0.2,
                                child: ImagesListView(
                                    images: post.images,
                                    screenWidth: width,
                                    screenHeight: height,
                                    isMob: isMob),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: controller.loadingSendRequest?null:() =>controller.sendRequest(RequestModel(
                             requestId: '',
                             senderId: controller.userModel!.id,
                             receiverId: post.userID,
                             postId: post.id,
                             status: requestPending)),
                  child:  TitleText(
                    text: controller.loadingSendRequest?"Loading..".tr:"Send Request".tr,
                    color: Colors.white,
                  ),
                  style: Styles.elevatedButtonStyle(
                      width: width,
                      height: height * 0.07,
                      buttonColor: CustomColors.blue),
                )
              ],
            ),
          );
        },
      );
    });
  }
}
