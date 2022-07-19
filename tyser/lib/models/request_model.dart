import 'package:tyser/models/user_model.dart';

import '../componants/constants.dart';

class RequestModel {
  String? requestId, senderId, receiverId, postId, status;
  UserModel? sender,receiver;

  RequestModel(
      {
        this.receiver,
        this.sender,
    required this.requestId     ,
    required this.senderId          ,
    required this.receiverId          ,
    required this.postId            ,
    required this.status      });

  RequestModel.fromJson(Map<String,dynamic>map){
    requestId =  map[           requestIdKey                            ];
    senderId  =  map[           requestSenderIdKey            ] ;
    receiverId=  map[           requestReceiverIdKey                 ];
    postId    =  map[           requestPostIdKey                       ];
    status    =  map[           requestStatusKey          ];

  }
  toJson(){
    return {

      requestIdKey:             requestId               ,
      requestSenderIdKey:       senderId                      ,
      requestReceiverIdKey:     receiverId                      ,
      requestPostIdKey:         postId                      ,
      requestStatusKey:         status                      ,

    };
  }
}
