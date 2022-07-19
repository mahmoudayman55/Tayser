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
import 'package:tyser/componants/title_text.dart';

import 'package:tyser/view/requests_view.dart';

import '../componants/colors.dart';
import '../core/view_models/home_view_model.dart';
import '../core/view_models/requests_view_model.dart';

class RequestsControllerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);

    return GetBuilder<HomeViewModel>(builder: (controller) {
      return DefaultTabController(
        initialIndex: 1,
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title:  TitleText(
                text: 'Requests'.tr,
                color: Colors.white,
              ),
              backgroundColor: CustomColors.blue,
              actions: [
                TextButton(
                    onPressed: ()=>controller.getRequests(),
                    child:  TitleText(
                      text: "Refresh".tr,
                      color: Colors.white,fontSize: 12,
                    ))
              ],
              bottom: TabBar(
                  indicatorColor: CustomColors.orange,
                  onTap: (index) {},
                  tabs: [
                    Tab(text: 'Sent'.tr),
                    Tab(
                      text: 'Received'.tr,
                    ),
                  ]),
            ),
            backgroundColor: Colors.grey.shade100,
            body: TabBarView(
              children: [
                RequestsView(
                    controller.sentRequestsPosts, controller.sentRequests),
                RequestsView(
                    controller.receivedRequestsPosts, controller.receivedRequests),
              ],
            )),
      );
    });
  }
}
