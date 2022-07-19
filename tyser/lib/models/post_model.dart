import '../componants/constants.dart';

class PostModel {
  String?id, userID,caseTitle, description, university, userName, userPhoto,phoneNumber;
List? images;

  PostModel(
      {
    required  this.caseTitle,
    required  this.id,
    required  this.description,
    required  this.university,
        required this.userID,
    required  this.userName,
    required  this.images,
    required  this.userPhoto,
    required  this.phoneNumber});

PostModel.fromJson(Map<String,dynamic>map){
caseTitle=map[   caseTitleKey  ];
userID=map[   postUserIdKey  ];
id=map[   postIdKey  ];
description=map[   descriptionKey];
university=map[    universityKey ];
    userName=map[userNameKey   ];
    userPhoto=map[userPhotoKey  ];
    images=map[postImagesKey] ;
    phoneNumber=map[phoneNumberKey];
}


toJson(){
  return{
  caseTitleKey   :caseTitle,
  descriptionKey :description,
  universityKey  :university,
    postImagesKey:images,
  userNameKey    :userName,
    postUserIdKey:userID,
  userPhotoKey   :userPhoto,
  phoneNumberKey :phoneNumber,
    postIdKey:id,


  };
}


}
