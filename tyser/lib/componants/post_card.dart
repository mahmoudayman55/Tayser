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

class PostCard extends StatelessWidget {
  double width, height;
  PostModel post;
  VoidCallback sendRequest;
  String userId;
  bool loading;

  PostCard(
      {required this.width,
      required this.height,
      required this.post,
      required this.sendRequest,
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
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: height * 0.35,
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
                          width: width * 0.32,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
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
                  TitleText(
                      text: "${"Description".tr}:   ",
                      color: CustomColors.blue,
                      fontWeight: FontWeight.normal,
                      fontSize: 12),
                  SizedBox(
                    width: width * 0.6,
                    child: RichText(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                            text: "${post.description}",
                            style: Styles.txtStyle(
                                fontSize: 12, color: Colors.black))),
                  ),
                ],
              ),
              SizedBox(
                width: width * 0.27,
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
                                    placeholder: (context, url) => Center(
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
          Row(
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
                width: width * 0.4,
                child:(userId==post.userID)?
               SizedBox():
                ProfileMenu(
                  width: width * 0.15,
                  text: loading ? "Loading..".tr : "Send Request".tr,
                  showArrow: false,
                  fontSize: 12,
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 12.w,
                  ),
                  titleColor: Colors.white,
                  press: loading ? () => null : sendRequest,
                  buttonColor: CustomColors.blue, height: height*0.05,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
