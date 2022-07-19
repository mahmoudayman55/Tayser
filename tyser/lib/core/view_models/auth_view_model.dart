import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tyser/core/services/firestore_user.dart';
import 'package:tyser/models/doctor_model.dart';
import 'package:tyser/models/user_model.dart';
import 'package:tyser/view/auth/login_view.dart';
import 'package:tyser/view/auth/register_view.dart';
import 'package:tyser/view/control_view.dart';
import 'package:tyser/view/home_view.dart';
import 'package:tyser/view/navigator_view.dart';

import '../../componants/colors.dart';
import '../../componants/constants.dart';
import '../../componants/form_keys.dart';
import '../../models/patient_model.dart';

class AuthViewModel extends GetxController {@override
  // TODO: implement onStart
  InternalFinalCallback<void> get onStart {
  update();
  return super.onStart;
}
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ["email"]);

  String name = '';
  String email = '';
  String password = '';
  String phone = '';
  String governorate = '';
  String address = '';

  String university = '';
  String level = '';

  ValueNotifier<bool> signInLoading = ValueNotifier(false);
  ValueNotifier<bool> registerLoading = ValueNotifier(false);
  Rxn<User> _user = Rxn<User>();

  String? get user => _user.value?.email;

  void signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();
      final GoogleSignInAccount? googleAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication? gSignInAuth =
          await googleAccount?.authentication;
      final AuthCredential userAuthCredential = GoogleAuthProvider.credential(
          accessToken: gSignInAuth?.accessToken, idToken: gSignInAuth?.idToken);
      UserCredential userCredential =
          await _auth.signInWithCredential(userAuthCredential);
      User user = userCredential.user as User;
      //userModel =UserModel(userName: user.displayName as String,id:user.uid ,address: "UNKNOWN" ,email:user.email as String,governorate: "UNKNOWN",password: ,phone: ,picture: );
      log("email : ${userCredential.user}");
    } on Exception catch (e) {
      log("error : ${e}");
      Get.snackbar("error", e.toString());
    }
  }

GlobalKey<FormState>  signInFormKey = GlobalKey<FormState>(debugLabel: '_LoginFormState');
GlobalKey<FormState>  registerFormKey = GlobalKey<FormState>( );

  void onEmailChanged(String value) {
    email = value;
    update();
  }
  void onPasswordChanged(String value) {
    password = value;
    update();
  }
  void signInWithEmail() async {
    if (signInFormKey .currentState!.validate()) {
      try {
        signInLoading.value = true;
        update();
        await _auth.signInWithEmailAndPassword(
            email: email, password: password);
        signInLoading.value = false;
        Get.offAll(NavigatorView());
        snackBar("Welcome!", 'logged in successfully',messageColor: Colors.white,titleColor: Colors.lightGreen);
        update();
      } on FirebaseAuthException catch(e) {
switch(e.code){
  case 'wrong-password': {
    snackBar("Error", 'password is wrong, try again',messageColor: Colors.white);
break;
  }
  case "user-not-found": {
    snackBar("Error", 'user not found, try again',messageColor: Colors.white);
break;
  }
  case "network-request-failed": {
    snackBar("Error", 'There is no internet connection',messageColor: Colors.white);
break;
  }
  default:
    {
      snackBar("Error", 'something went wrong, restart the application and try again',messageColor: Colors.white);
      break;
    }
}

signInLoading.value = false;
        update();
log(e.code.toString());
log(e.toString());
      }
    }
  }
  void registerWithEmail() async {
     if (registerFormKey.currentState!.validate()) {
    try {
      //print(userModel!.email);
      registerLoading.value = true;
      update();
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((user) async {

          UserModel userModel = userType == 'doc'?DoctorModel(
            id: user.user!.uid,
            userName: name,
            email: user.user!.email,
            password: password,
            phone: phone,
            governorate: governorate,
            address: address,
            university: university,
            picture: '',
            level: level
          ): PatientModel(
              id: user.user!.uid,
              userName: name,
              email: user.user!.email,
              password: password,
              phone: phone,
              governorate: governorate,
              address: address,
              picture: ''

          );
        await FireStoreUser().addUserToFireStore(userModel);
      });
      registerLoading.value = false;
      update();

      Get.offAll(NavigatorView());
      snackBar("Welcome!", 'Your Account Created Successfully',messageColor: Colors.white,titleColor: Colors.lightGreen);
    }on FirebaseAuthException catch (e) {
      switch(e.code){
        case 'email-already-in-use': {
          snackBar("Error", 'email already in use, try another one',messageColor: Colors.white);
          break;
        }

        default:
          {
            snackBar("Error", 'something went wrong, restart the application and try again',messageColor: Colors.white);
            break;
          }
      }


      registerLoading.value = false;
      update();
      log(e.code);
      log(e.toString());
    }
    }
  }

  String userType = "patient";

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(_auth.authStateChanges());
  }


}
