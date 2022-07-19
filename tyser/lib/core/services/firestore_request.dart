import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tyser/core/functions/requests_services.dart';
import 'package:tyser/models/request_model.dart';

import '../../componants/constants.dart';

class FireStoreRequest{
  final CollectionReference _requestCollection= FirebaseFirestore.instance.collection(requestCollection);

   sendRequestToFireStore(RequestModel requestModel)async{
   //  String? sent ='';
try {
  List<RequestModel>_requests= await getSentRequests(requestModel.senderId.toString());
  for (var request in _requests) {
    if(request.postId==requestModel.postId&&requestModel.senderId==request.senderId){
      snackBar("The request has not been sent", "You have already sent a request for this post before",messageColor: Colors.white);
      return 'sentBefore' ;
    }
    log("not sent");

  }

             log(" sent");
        await _requestCollection.add(requestModel.toJson()).then((value) async {
          await value.update({requestIdKey: value.id});
          return "done";
        });
} on FirebaseException catch (e) {
  log(e.toString());

return;}

  }


}