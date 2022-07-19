import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tyser/models/post_model.dart';
import 'package:tyser/models/user_model.dart';
import 'package:http/http.dart' as http;
import '../../componants/constants.dart';

class FireStorePost{
  final CollectionReference _postCollection= FirebaseFirestore.instance.collection(postCollection);
 addPostToFireStore(PostModel postModel)async{

      return await _postCollection.add (postModel.toJson()).then((value) async {
        await value.update(
          {postIdKey:value.id});
        return value;
      });

  }


}