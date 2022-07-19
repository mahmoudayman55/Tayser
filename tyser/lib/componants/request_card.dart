import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/componants/profile_menu_class.dart';
import 'package:tyser/componants/styles.dart';
import 'package:tyser/componants/title_text.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/request_model.dart';
import 'package:tyser/view/post_details_view.dart';

import '../core/services/firestore_request.dart';
import 'colors.dart';

class RequestCard extends StatelessWidget {
  double width, height;
  PostModel post;
  VoidCallback acceptRequest;
  VoidCallback refuseRequest;
  String userId;
  bool loading;
  RequestModel request;

  RequestCard({required this.width,
    required this.height,
    required this.post,
    required this.request,
    required this.acceptRequest,
    required this.refuseRequest,
    required this.loading,
    required this.userId});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      width: width,
      height: height,
      decoration: Styles.boxDecorAll(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(width: width * 0.8,
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: height * 0.6,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TitleText(
                                  fontWeight: FontWeight.normal,
                                  text: "${"From".tr}: ",
                                  color: CustomColors.blue,
                                  fontSize: 12),
                              TitleText(
                                  fontWeight: FontWeight.normal,
                                  text: "${"To".tr}: ",
                                  color: CustomColors.blue,
                                  fontSize: 12),
                              TitleText(
                                  fontWeight: FontWeight.normal,
                                  text: "${"Case".tr}: ",
                                  color: CustomColors.blue,
                                  fontSize: 12),
                              TitleText(
                                  fontWeight: FontWeight.normal,
                                  text: "${"University".tr}: ",
                                  color: CustomColors.blue,
                                  fontSize: 12),
                              TitleText(
                                  fontWeight: FontWeight.normal,
                                  text: "${"Phone Number".tr}: ",
                                  color: CustomColors.blue,
                                  fontSize: 12),
                            ],
                          ),
                          SizedBox(
                            width: width * 0.03,
                          ),
                          SizedBox(
                            width: width * 0.4,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                TitleText(
                                    text:
                                    "${request.sender!.id == userId
                                        ? "you".tr
                                        : request.sender!.userName}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                                TitleText(
                                    text:
                                    "${request.receiver!.id == userId
                                        ? "you".tr
                                        : request.receiver!.userName}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                                TitleText(
                                    text: "${post.caseTitle}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                                TitleText(
                                    text: "${post.university}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                                TitleText(
                                    text: "${post.phoneNumber}",
                                    color: Colors.black,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: width * 0.4,
                height: height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: width * 0.3,
                      height: height * 0.5,
                      child: Semantics(
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: (post.userPhoto == null ||
                                post.userPhoto!.isEmpty)
                                ? Image.asset('assets/images/person.jpg')
                                : CachedNetworkImage(
                              imageUrl: post.userPhoto.toString(),
                              width: width * 0.34,
                              height: width * 0.34,
                              placeholder: (context, url) =>
                                  Center(
                                      child: CircularProgressIndicator(
                                        color: CustomColors.blue,
                                      )),
                              errorWidget: (context, url, error) =>
                                  Image.asset("assets/images/person.jpg"),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ),
                    TitleText(
                      text: post.userName.toString(),
                      fontSize: 10,
                      color: CustomColors.blue,
                    )
                  ],
                ),
              ),
            ],
          ),
          SizedBox(width: width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () => Get.to(PostDetailsView(post)),
                  child: Text(
                    "More Details".tr,
                    style: Styles.txtStyle(
                      color: Colors.lightGreen,
                      fontSize: 12,
                    ),
                  ),
                ),
                SizedBox(
///from : 9vR77IrfM6NEYip7sYr7fAU7bMO2 mustafa doc
///to : XyzOI3ebqSTl03YAjqonHwThWqV2 ahmed mohamed pat
///post : FYrEwhWVpazZiRmJFg8M
///status : pending
                  child: (userId != post.userID)
                      ? TitleText(
                      text: request.status.toString().tr,
                      color: request.status == requestPending
                          ? CustomColors.blue
                          : (request.status.toString() == requestAccepted
                          ? Colors.lightGreen
                          : Colors.red))
                      : request.status != requestPending ? TitleText(fontSize: 12,
                    text: request.status == requestAccepted
                        ? "You accepted this request".tr
                        : "You refused this request".tr  ,
                    color: request.status == requestPending
                        ? CustomColors.blue
                        : request.status == requestAccepted
                        ? Colors.lightGreen
                        : Colors.red,): Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //    press: loading ? () => null : acceptRequest,
                      //  text: loading ? "Loading.." : "Accept".tr,
                      ElevatedButton(
                        onPressed: loading ? () => null : acceptRequest,
                        style: Styles.elevatedButtonStyle(padding: 0,
                            radius: 10,
                            buttonColor: Colors.lightGreen,
                            width: width * 0.3,
                            height: height * 0.07),
                        child: TitleText(
                          text: loading ? "Loading..".tr : "Accept".tr,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: width*0.03,),
                      ElevatedButton(
                        onPressed: loading ? () => null : refuseRequest,
                        style: Styles.elevatedButtonStyle(padding: 0,
                            radius: 10,
                            buttonColor: Colors.red,
                            width: width * 0.3,
                            height: height * 0.07),
                        child: TitleText(
                          text: loading ? "Loading..".tr : "Refuse".tr,
                          color: Colors.white,
                          fontSize: 15,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
