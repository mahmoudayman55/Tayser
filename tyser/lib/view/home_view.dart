import 'dart:developer';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:tyser/componants/colors.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/componants/loading_widget.dart';
import 'package:tyser/componants/post_card.dart';
import 'package:tyser/componants/search_bar.dart';
import 'package:tyser/componants/title_text.dart';
import 'package:tyser/core/view_models/auth_view_model.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/request_model.dart';
import 'package:tyser/view/navigator_view.dart';
import 'package:tyser/view/new_post_view.dart';
import '../componants/ui_componant.dart';
import '../core/view_models/home_view_model.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

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

          // bool isMob =
          //     deviceInfo.deviceType == DeviceType.mobile ? true : false;

          return Scaffold(
            resizeToAvoidBottomInset: false,
            floatingActionButton: FloatingActionButton(
                onPressed: () {
                  Get.to(NewPostView());
                },
                child: const Icon(Icons.add_to_photos),
                backgroundColor: CustomColors.blue),
            backgroundColor: Colors.grey.shade100,
            body: SizedBox(
              width: width,
              height: height,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SearchBar(height * 0.06, width * .8, 20, 20, () {
                        controller.getAllPosts();
                      }),
                      SizedBox(
                        height: height * 0.031,
                      ),
                      controller.unavailableError
                          ? Center(
                              child: Column(
                                children: [
                                  TitleText(text: "Bad Connection"),
                                  TextButton(
                                      onPressed: () =>
                                          Get.offAll(() => NavigatorView()),
                                      child: Text('reload'))
                                ],
                              ),
                            )
                          : controller.loading
                              ?LoadingScreen(height, width)
                              : (controller.posts.isEmpty)
                                  ? TitleText(text: 'NO Posts')
                                  : (SizedBox(
                                      height: height * 0.87,
                                      child: ListView.separated(
                                          shrinkWrap: false,
                                          itemBuilder: (context, index) =>
                                              PostCard(
                                                userId: controller.userModel!.id
                                                    .toString(),
                                                sendRequest: () => controller
                                                    .sendRequest(RequestModel(
                                                        postId: controller
                                                            .posts[index].id,
                                                        receiverId: controller
                                                            .posts[index]
                                                            .userID,
                                                        senderId: controller
                                                            .userModel!.id,
                                                        requestId: '',
                                                        status:
                                                            requestPending)),
                                                width: width,
                                                height: height * 0.32,
                                                post: controller.posts[index],
                                                loading: controller
                                                    .loadingSendRequest,
                                              ),
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              height: height * 0.03,
                                            );
                                          },
                                          itemCount: controller.posts.length),
                                    ))
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    });
  }
}
