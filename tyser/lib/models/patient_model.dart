import 'package:tyser/models/user_model.dart';

import '../componants/constants.dart';

class PatientModel implements UserModel {
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

  @override
  @override
  toJson() {
    return {
      patientIdKey          :  this.id,
      patientPhoneKey                       : this.phone,
      patientNameKey                            : this.userName,
      patientAddressKey              : this.address,
      patientGovernorateKey              : this.governorate,
      patientEmailKey              : this.email,
      patientPasswordKey              : this.password,
      patientPicKey              : this.picture,
    };
  }

  PatientModel(
      {this.address,
      this.email,
      this.governorate,
      this.id,
      this.password,
      this.phone,
      this.picture,
      this.userName});

  PatientModel.fromJson(Map<String, dynamic> map) {
    this.id =          map[           patientIdKey                           ];
    this.phone =       map[           patientPhoneKey              ] ;
    this.userName =    map[           patientNameKey                      ];
    this.address =      map[          patientAddressKey                      ];
    this.governorate = map[           patientGovernorateKey    ];
    this.email =       map[           patientEmailKey                                ];
    this.password =      map[         patientPasswordKey                                 ];
    this.picture =        map[        patientPicKey                                        ];
  }
}
