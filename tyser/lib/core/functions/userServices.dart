import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/models/doctor_model.dart';
import 'package:tyser/models/patient_model.dart';
import 'package:tyser/models/user_model.dart';

import '../../models/post_model.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final CollectionReference _patientCollectionRef =
    FirebaseFirestore.instance.collection(patientCollection);

final CollectionReference _docCollectionRef =
    FirebaseFirestore.instance.collection(doctorCollection);



Future<UserModel> getCurrentUserData() async {
  DocumentSnapshot userData =
      await _docCollectionRef.doc(_auth.currentUser!.uid).get();
  UserModel userModel;

  if (userData.data() == null) {
    userData = await _patientCollectionRef.doc(_auth.currentUser!.uid).get();
    userModel = PatientModel.fromJson(
        Map<String, dynamic>.from(userData.data() as Map<dynamic, dynamic>));
    print("user model from get user data${userData.data()}");
    return userModel;
  } else {
    userModel = DoctorModel.fromJson(
        Map<String, dynamic>.from(userData.data() as Map<dynamic, dynamic>));
    print("haha${userModel.toJson()}");

    return userModel;
  }
}
Future<UserModel> getUserData(String userId) async {
  DocumentSnapshot userData =
      await _docCollectionRef.doc(userId).get();
  UserModel userModel;

  if (userData.data() == null) {
    userData = await _patientCollectionRef.doc(userId).get();
    userModel = PatientModel.fromJson(
        Map<String, dynamic>.from(userData.data() as Map<dynamic, dynamic>));
    print("user model from get user data${userData.data()}");
    return userModel;
  }
  else {
    userModel = DoctorModel.fromJson(
        Map<String, dynamic>.from(userData.data() as Map<dynamic, dynamic>));

    return userModel;
  }
}


Future<void> updateNewUserData(UserModel userModel) async {
  if(userModel is DoctorModel){
    await _docCollectionRef.doc(userModel.id).set(userModel.toJson());
  }else{
    await _patientCollectionRef.doc(userModel.id).set(userModel.toJson());

  }
}


final CollectionReference _postCollection= FirebaseFirestore.instance.collection(postCollection);

Future<void> updateUserPosts({required String userId, required String url,required String userName})async{

  List<PostModel>_posts=[];

  await _postCollection.where(postUserIdKey, isEqualTo: userId).get()
      .then((value) {
    log("posts is : ${value.docs}");
    for (var post in value.docs) {
      _posts.add(PostModel.fromJson(Map<String,dynamic>.from(post.data() as Map)));
    }
  });

  if(_posts.isNotEmpty){
    for (var post in _posts) {
      await _postCollection
          .doc(post.id.toString()) // <-- Doc ID where data should be updated.
          .update({userPhotoKey: url==""?post.userPhoto:url,userNameKey:userName}) // <-- Nested value
          .then((_) => log('photo Updated'));
      log(url);
      log(userId);
      log(post.id.toString());
      log(post.userID.toString());
    }
  }
}

