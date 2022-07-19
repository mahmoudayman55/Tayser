import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tyser/componants/constants.dart';
import 'package:tyser/models/user_model.dart';

class FireStoreUser{
  final CollectionReference _doctorCollection= FirebaseFirestore.instance.collection(doctorCollection);
  final CollectionReference _patientCollection= FirebaseFirestore.instance.collection(patientCollection);

  Future<void> addUserToFireStore(UserModel userModel)async{
if(userModel.runtimeType.toString()=="DoctorModel"){
  print('doctor register');
  return await _doctorCollection.doc(userModel.id).set(userModel.toJson());

}
else{
  print('patient register');

  return await _patientCollection.doc(userModel.id).set(userModel.toJson());
}
  }
}