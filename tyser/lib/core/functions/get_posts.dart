
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/models/post_model.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
final CollectionReference _postCollectionRef =
    FirebaseFirestore.instance.collection(postCollection);

Future<List<PostModel>>   getPosts() async {
  List<PostModel>_posts=[];

  await _postCollectionRef.get().then((value) {
    log("posts is : ${value.docs}");
  for (var post in value.docs) {
    _posts.add(PostModel.fromJson(Map<String,dynamic>.from(post.data() as Map)));
  }
  });
  return _posts;

}
Future<List<PostModel>>   getSpecificPosts(String postId) async {
  List<PostModel>_posts=[];

  await _postCollectionRef.where(postIdKey,isEqualTo:postId ).get().then((value) {
    log("posts is : ${value.docs}");
  for (var post in value.docs) {
    _posts.add(PostModel.fromJson(Map<String,dynamic>.from(post.data() as Map)));
  }
  });
  return _posts;

}
