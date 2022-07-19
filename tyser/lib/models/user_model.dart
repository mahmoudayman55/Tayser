abstract class UserModel {
  String? id,phone;
   String? userName,address,governorate,email,password,picture;

  UserModel(
      {required this.id,
      required this.phone,
      required this.userName,
      required this.address,
      required this.governorate,
      required this.email,
      required this.password,
      required this.picture});


  toJson(){

  }
}