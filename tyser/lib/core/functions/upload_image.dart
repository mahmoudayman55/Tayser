import 'package:firebase_storage/firebase_storage.dart';

Future<String> uploadImage(var imageFile) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child("profileImages/${imageFile}");
  await ref.putFile(imageFile);
  String url = await ref.getDownloadURL();
  return url;
}