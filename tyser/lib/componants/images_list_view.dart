import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tyser/componants/styles.dart';
import 'package:tyser/componants/title_text.dart';

import 'colors.dart';

class ImagesListView extends StatelessWidget {
  List? images;
  double screenWidth, screenHeight;
  bool isMob;

  ImagesListView(
      {required this.images,
      required this.screenWidth,
      required this.screenHeight,
      required this.isMob});

  @override
  Widget build(BuildContext context) {
    return images!.isEmpty
        ? Center(child: TitleText(text: "No photos are attached"))
        : ListView.separated(
            physics: AlwaysScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.all(5),
                child: Container(
                  decoration: Styles.boxDecorAll(5),
                  width: screenWidth * (isMob ? 0.5 : 0.23),
                  height: screenHeight * 0.3,
                  child: Semantics(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(
                                color: CustomColors.blue,
                              )),
                          imageUrl: images![index],
                          fit: BoxFit.fill,
                        )),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return SizedBox(
                width: screenWidth * 0.02,
              );
            },
            itemCount: images!.length);
  }
}
