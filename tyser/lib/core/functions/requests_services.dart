
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/core/functions/userServices.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/request_model.dart';
import 'package:tyser/models/user_model.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final CollectionReference _requestCollectionRef =
FirebaseFirestore.instance.collection(requestCollection);

Future<List<RequestModel>>   getReceivedRequests(String receiverId) async {
  List<RequestModel>_requests=[];

  await _requestCollectionRef.where(requestReceiverIdKey,isEqualTo:receiverId ).get().then((value) async {
    log("received requests are : ${value.docs}");
    for (var request in value.docs) {
      UserModel userModel=await getUserData(request[requestSenderIdKey]);

      RequestModel requestModel=RequestModel.fromJson(Map<String,dynamic>.from(request.data() as Map));
      requestModel.sender=userModel;
      requestModel.receiver=await getCurrentUserData();
      _requests.add(requestModel);
    }
  });
  return _requests;

}




Future<List<RequestModel>>   getSentRequests(String senderId) async {
  List<RequestModel>_requests=[];
print(senderId);
  await _requestCollectionRef.where(requestSenderIdKey,isEqualTo:senderId ).get().then((value) async {
    log("sent requests : ${value.docs}");
    for (var request in value.docs) {
      UserModel userModel=await getUserData(request[requestReceiverIdKey]);
      RequestModel requestModel =RequestModel.fromJson(Map<String,dynamic>.from(request.data() as Map));
      requestModel.receiver=userModel;
      requestModel.sender=await getCurrentUserData();
      _requests.add(requestModel);
      print("Test");
      print(requestModel.receiver!.id);
    }
    log(_requests.toString());
  });
  return _requests;

}



Future<void> updateRequestStatus(String id,String state) async {

    await _requestCollectionRef.doc(id).update(
        {requestStatusKey:state});

}
