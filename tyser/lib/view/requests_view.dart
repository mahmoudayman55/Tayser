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
import 'package:tyser/componants/request_card.dart';
import 'package:tyser/componants/title_text.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/request_model.dart';

import '../componants/loading_widget.dart';
import '../componants/post_card.dart';
import '../componants/ui_componant.dart';
import '../core/enums/device_type.dart';
import '../core/view_models/home_view_model.dart';
import '../core/view_models/requests_view_model.dart';

class RequestsView extends StatelessWidget {
  List<PostModel> posts;
  List<RequestModel> requests;

  RequestsView(this.posts, this.requests);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return GetBuilder<HomeViewModel>(builder: (controller2) {
      return Scaffold(
          backgroundColor: Colors.grey.shade100,
          body: InfoWidget(
            builder: (context, deviceInfo) {
              double width = deviceInfo.width;
              double height = deviceInfo.height;
              bool isMob =
                  deviceInfo.deviceType == DeviceType.mobile ? true : false;

              return SizedBox(
                width: width,
                height: height,
                child: Column(
                  children: [
                    controller2.loadingRequests
                        ?LoadingScreen(height, width)
                        : requests.isEmpty
                            ? TitleText(text: "No Requests".tr)
                            : SizedBox(height: height,width: width*0.95,
                              child: ListView.separated(
                                  shrinkWrap: false,
                                  itemBuilder: (context, index) {
                                    return RequestCard(
                                        request: requests[index],
                                        width: width * 0.7,
                                        height: height * 0.36,
                                        post: posts[index],
                                        acceptRequest: () => controller2
                                            .acceptRequest(requests[index]
                                                .requestId
                                                .toString()),
                                        refuseRequest: () => controller2
                                            .refuseRequest(requests[index]
                                                .requestId
                                                .toString()),
                                        loading: false,
                                        userId: controller2.userModel!.id
                                            .toString());
                                  },
                                  separatorBuilder: (context, index) {
                                    return SizedBox(
                                      height: height * 0.03,
                                    );
                                  },
                                  itemCount: requests.length),
                            ),
                  ],
                ),
              );
            },
          ));
    });
  }
}
