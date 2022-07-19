
import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tyser/utils/translations.dart';
import 'package:tyser/view/auth/login_view.dart';
import 'package:tyser/view/control_view.dart';

import 'helper/binding.dart';

void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
 // Hive.registerAdapter(UserModelAdapter());
  //await Hive.initFlutter();
  // await Hive.openBox('user');
  // print(box.values.toString()+'      dsfsdfsadfasdfasdfasdfasdfasdfasdfasdf');
// SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
  runApp(DevicePreview(builder: (context)=>MyApp(),enabled: !kReleaseMode,));

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(

      builder: (_) => GetMaterialApp(


translations: Translation(),
        locale: const Locale("en"),
        fallbackLocale: const Locale('en'),
        builder: DevicePreview.appBuilder,
        initialBinding: Binding(),
defaultTransition: Transition.upToDown,     
   debugShowCheckedModeBanner: false,
         home:ControlView(),
        theme: ThemeData(primarySwatch: Colors.blue),
      ),
    );
  }
}
