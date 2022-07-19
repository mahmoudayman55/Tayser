import 'package:tyser/models/user_model.dart';

import '../componants/constants.dart';

class DoctorModel implements UserModel {

  late String? university,level;
  @override
  late String? address;

  @override
  late String? email;

  @override
  late String? governorate;

  @override
  late String? id;

  @override
  late String? password;

  @override
  late String? phone;

  @override
  late String? picture;

  @override
  late String? userName;

  DoctorModel(
      {
      this.university,
      this.level,
      this.address,
      this.email,
      this.governorate,
      this.id,
      this.password,
      this.phone,
      this.picture,
      this.userName});



  @override
  toJson(){
    return {
      docIdKey:this.id,
      docPhoneKey:this.phone,
      docNameKey:this.userName,
      docAddressKey:this.address,
      docGovernorateKey:this.governorate,
      docEmailKey:this.email,
      docPasswordKey:this.password,
      docPicKey:this.picture,
      docUniversityKey:this.university,
      docLevelKey:this.level,


    };}

  DoctorModel.fromJson(Map <String,dynamic>map){

    this.id=map[docIdKey];
    this.phone=map[docPhoneKey];
    this.userName=map[docNameKey];
    this.address=map[docAddressKey];
    this.governorate=map[docGovernorateKey];
    this.email=map[docEmailKey];
    this.password=map[docPasswordKey];
    this.picture=map[docPicKey];
    this.university=map[docUniversityKey];
    this.level=map[docLevelKey];

  }





  }







