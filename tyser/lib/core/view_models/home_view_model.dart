import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tyser/componants/colors.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/componants/post_card.dart';
import 'package:tyser/componants/search_bar.dart';
import 'package:tyser/core/functions/get_posts.dart';
import 'package:tyser/core/functions/requests_services.dart';
import 'package:tyser/core/functions/userServices.dart';
import 'package:tyser/core/functions/upload_image.dart';
import 'package:tyser/core/view_models/auth_view_model.dart';
import 'package:tyser/models/doctor_model.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/request_model.dart';
import 'package:tyser/models/user_model.dart';
import 'package:tyser/view/auth/login_view.dart';
import 'package:tyser/view/control_view.dart';
import 'package:tyser/view/menu_view.dart';
import 'package:tyser/view/new_post_view.dart';
import 'package:flutter/services.dart';
import '../../utils/lang_local_storage.dart';
import '../../view/auth/register_view.dart';
import '../../view/home_view.dart';
import '../services/firestore_request.dart';
import 'controle_view_model.dart';

class HomeViewModel extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    await getCurrentUser();
    newUserModel = userModel;
    log('on inittttt${userModel!.toJson()}');

    userModel!.id=_auth.currentUser!.uid;
    getRequests();
    await getAllPosts();

    // log(Get.arguments);
  }

  sendRequest(RequestModel requestModel)async{
    log('sending...');

    try {
      loadingSendRequest=true;
      update();
      if ( await FireStoreRequest().sendRequestToFireStore(requestModel)=='sentBefore'){
        loadingSendRequest=false;
        update();
        return;
      }
      else{
        snackBar('Done!', "Request Sent Successfully",messageColor: Colors.white,titleColor: Colors.lightGreen);
        loadingSendRequest=false;

        getRequests();
        update();
      }

    }catch (e) {
      loadingSendRequest=false;
      update();
      snackBar('error', e.toString());
      log(e.toString());
    }
  }
  selectNewPic() async {
    try {
      final ImagePicker _picker = ImagePicker();
      log("message");
      XFile? selected = await _picker.pickImage(source: ImageSource.gallery);
      newUserPic = File(selected!.path).path;
      newPicture=newUserPic;
      update();
    } on Exception catch (e) {
      log("erorerer " + e.toString());
    }
  }
  signOut() async {
    await _auth.signOut();
    Get.off(ControlView(),);
    Get.replace(LoginView(),);

    update();
  }
  updateUserData() async {
    if (updateFormKey.currentState!.validate()) {
      try {
        if (newUserModel!.toJson() == userModel!.toJson()) {
          snackBar("", "Nothing Changed");
          return;
        }

        loadingUpdateInfo = true;
        update();

        if (newUserPic != '') {
          newUserModel!.picture = await uploadImage(File(newUserPic));
          userModel!.picture = newUserModel!.picture;
        }
        await updateUserPosts(
            url: newUserModel!.picture.toString(),
            userId: newUserModel!.id.toString(),
            userName: newUserModel!.userName.toString());

        //set new data to the user
        await updateNewUserData(newUserModel!);
        userModel = await getCurrentUserData();
        newUserPic = '';
        snackBar("Done!", "Your Data Updated Successfully");

        loadingUpdateInfo = false;
        update();
        getAllPosts();
        getRequests();
      } catch (e) {
        loadingUpdateInfo = false;
        update();
        log(e.toString());
      }
    }
  }
  getRequests()async{
    try {
      loadingRequests=true;
      update();
      sentRequests=await getSentRequests(userModel!.id.toString(),);
      for (var request in sentRequests) {

        sentRequestsPosts.addAll(await getSpecificPosts(request.postId.toString()));
      }
      receivedRequests=await getReceivedRequests(userModel!.id.toString());
      for (var request in receivedRequests) {
        receivedRequestsPosts.addAll(await getSpecificPosts(request.postId.toString()));
      }
      loadingRequests=false;
      update();
    } on Exception catch (e) {
      loadingRequests=false;
      update();
      log(e.toString());
    }
  }
  acceptRequest(String requestId) async {
    await updateRequestStatus(requestId, requestAccepted);
    getRequests();

  }
  refuseRequest(String requestId) async {
    await updateRequestStatus(requestId, requestRefused);
    getRequests();

  }
bool unavailableError=false;
  getCurrentUser()async{
    try {
      unavailableError=false;
      loading=true;
      update();
      userModel=await  getCurrentUserData();
      log('on inittttt${await  getCurrentUserData()}');

      update();
    } on FirebaseException catch (e) {
      if(e.code=='unavailable'){
        snackBar("Alert", "Bad Connection");
        log('eroooooor');
        loading=false;
        unavailableError=true;
        update();
        //getCurrentUser();
      }
    }
  }
  getAllPosts() async {
    loading = true;
    update();
    try {
      posts = await getPosts();
      loading = false;
      update();
    } on Exception catch (e) {
      loading = false;
      update();
      snackBar("error", e.toString());
    }
  }

final FirebaseAuth _auth = FirebaseAuth.instance;
String newUserPic = '';
UserModel? newUserModel;
bool loadingSendRequest=false;
String newPicture='';
var updateFormKey = GlobalKey<FormState>();
List<RequestModel> sentRequests=[];
List<RequestModel> receivedRequests=[];
List<PostModel> receivedRequestsPosts=[];
List<PostModel> sentRequestsPosts=[];
bool loadingRequests=false;
String? university, level;
List<PostModel> posts = [];
bool loading = false;
bool loadingUpdateInfo = false;
UserModel? userModel;


}
