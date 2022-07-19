import 'dart:developer';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/core/functions/userServices.dart';
import 'package:tyser/core/services/firestore_post.dart';
import 'package:tyser/core/view_models/home_view_model.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/user_model.dart';
import 'package:tyser/view/control_view.dart';
import 'package:tyser/view/home_view.dart';
import 'package:tyser/view/navigator_view.dart';

import '../functions/upload_image.dart';

class PostViewModel extends GetxController {
  FirebaseAuth _auth=FirebaseAuth.instance;
  PostModel postModel = PostModel(
      caseTitle: '',
      userID: '',
      description: '',
      university: '',
      userName: '',
      userPhoto: '',
      phoneNumber: '', images: [], id: '');
  List<XFile>? images = [];

  selectImages() async {
    try {
      final ImagePicker _picker = ImagePicker();

      log("message");
      List<XFile>? selected = await _picker.pickMultiImage();
      images?.addAll(selected!);

      update();
    } on Exception catch (e) {
      log("erorerer " + e.toString());
    }
  }

  removeImage(int index) {
    images!.removeAt(index);
    update();
  }

  Future<List<String>> uploadFiles(List<File> _images) async {
    try {
      var imageUrls =
          await Future.wait(_images.map((_image) => uploadImage(_image)));
      return imageUrls;
    } on Exception catch (e) {
      log('errorrrr ' + e.toString());
      return [];
    }
  }
final  newPostFormKey=GlobalKey<FormState>();

Rx<bool> loadingAddPost=Rx(false);
  Future<void> savePost() async {
    if(newPostFormKey.currentState!.validate()){
      loadingAddPost.value=true;
      update();
      try {
        List<File> allImages = [];
        images?.forEach((element) {
          allImages.add(File(element.path));
        });
UserModel userModel=await getCurrentUserData();
          postModel.userName=userModel.userName;
            postModel.userPhoto=userModel.picture;
            postModel.userID=userModel.id;
             postModel.images= await uploadFiles(allImages);
            await  FireStorePost().addPostToFireStore(postModel);
        loadingAddPost.value=false;

        snackBar('Done!', "Post Uploaded");
        HomeViewModel().onInit();
        update();
        Get.offAll(()=> NavigatorView(),arguments: "re",transition: Transition.circularReveal);

      } on Exception catch (e) {
        loadingAddPost.value=false;
        update();

        log(e.toString());
        snackBar("Error", e.toString());
      }


    }

  }
}
