import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:tyser/componants/styles.dart';

const String docIdKey           ="docId";
const String docPhoneKey        ="docPhone";
const String docNameKey         ="docName";
const String docAddressKey      ="docAddress";
const String docGovernorateKey  ="docGovernorate";
const String docEmailKey        ="docEmail";
const String docPasswordKey     ="docPassword";
const String docPicKey          ="docPic";
const String docUniversityKey          ="docUniversity";
const String docLevelKey          ="docLevel";

const String patientIdKey         ="patId";
const String patientPhoneKey      ="patPhone";
const String patientNameKey       ="patName";
const String patientAddressKey    ="patAddress";
const String patientGovernorateKey="patGovernorate";
const String patientEmailKey      ="patEmail";
const String patientPasswordKey   ="patPassword";
const String patientPicKey        ="patPic";

const caseTitleKey  ="postCaseTitle";
const postUserIdKey  ="userId";
const postIdKey  ="postId";
const descriptionKey  ="postDescription";
const universityKey ="postUniversity";
const userNameKey   ="postUserName";
const userPhotoKey    ="postUserPhoto";
const postImagesKey    ="postImagesKey";
const phoneNumberKey  ="postPhoneNumber";


const requestIdKey          ="requestId";
const requestSenderIdKey       ="senderId";
const requestReceiverIdKey     ="receiverId";
const requestPostIdKey        ="postId";
const requestStatusKey        ="Status";

const requestAccepted  ="Accepted";
const requestRefused  ="Refused";
const requestPending  ="Pending";


const doctorCollection  ="Doctor";
const patientCollection  ="Patient";
const postCollection  ="Post";
const requestCollection  ="Request";



SnackbarController snackBar(String title, String message,
    {Color titleColor = Colors.red, Color messageColor = Colors.black54}) =>
    Get.snackbar('', '',
        titleText: Text(
          title,
          style: Styles.txtStyle(fontSize: 15,color: titleColor,fontWeight: FontWeight.bold),
        ),
        messageText: Text(
          message,
          style: Styles.txtStyle(fontSize:15,color: messageColor),
        ),duration: Duration(seconds: 3),
        snackPosition: SnackPosition.BOTTOM);