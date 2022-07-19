import 'package:get/get.dart';
import '../core/view_models/auth_view_model.dart';
import '../core/view_models/controle_view_model.dart';

import '../core/view_models/home_view_model.dart';
import '../core/view_models/post_view_model.dart';
import '../core/view_models/requests_view_model.dart';

class Binding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(() => HomeViewModel(),fenix: true,);
    Get.lazyPut(() => ControlViewModel(),fenix: true,);
    Get.lazyPut(() => AuthViewModel(),fenix: true,);
    Get.lazyPut(() => PostViewModel(),fenix: true,);
    Get.lazyPut(() => RequestsViewModel(),fenix: true,);
  }

}