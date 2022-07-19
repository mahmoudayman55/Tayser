
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:titled_navigation_bar/titled_navigation_bar.dart';
import 'package:tyser/view/requests_controller_view.dart';

import '../../componants/colors.dart';
import '../../utils/lang_local_storage.dart';
import '../../view/home_view.dart';
import '../../view/menu_view.dart';
import 'home_view_model.dart';

class ControlViewModel extends GetxController{

String language='en';
  int _navigatorValue=1;
  Widget currentScreen=HomeView();
  int get navigatorValue => _navigatorValue;


  set setNavigatorValue(int value) {
    _navigatorValue = value;
  }

  Future<void> changeLanguage(String lang) async {
    LangLocalStorage localStorage=LangLocalStorage();
    if(language == lang){
      return;
    }
    else  {
      language = lang;
      localStorage.saveLanguage(lang);
      Get.updateLocale(Locale(lang));
      LangLocalStorage langLocalStorage=LangLocalStorage();
      print(await langLocalStorage.currentLanguage);

    }
    update();
  }

Future<void> changeSelectedScreen(int navigatorValue) async {
  _navigatorValue = navigatorValue;

  switch (navigatorValue) {
    case 0:
      {
        currentScreen = RequestsControllerView();
        HomeViewModel().update();

        break;
      }
    case 1:
      {
        currentScreen = HomeView();

        break;
      }
    case 2:
      {
        currentScreen = MenuView();
        break;
      }
    default:HomeView();
    break;
  }
  update();
}


  Widget bottomNavigation() {
    return GetBuilder<HomeViewModel>(
      init: HomeViewModel(),
      builder: (controller) {
        return BottomNavigationBar(backgroundColor: CustomColors.darkBlue,type: BottomNavigationBarType.fixed,
          unselectedItemColor: Colors.white54,
          selectedItemColor: Colors.white,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 1,
          items: [

            BottomNavigationBarItem(
              icon: Icon(
                Icons.markunread_mailbox_outlined,
                size: 20.w,
              ),
              activeIcon: Text(
                'Requests'.tr,
                style: TextStyle(
                    fontFamily: 'Tajawal',
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(15),
                    fontWeight: FontWeight.bold),
              ),
              label: '',
            ),            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 20.w,
                ),
                activeIcon: Text('Home'.tr,
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.bold)),
                label: ''),


            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  size: 20.w,
                ),
                activeIcon: Text('Settings'.tr,
                    style: TextStyle(
                        fontFamily: 'Tajawal',
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(15),
                        fontWeight: FontWeight.bold)),
                label: ''),
          ],
          onTap: (index) {
          changeSelectedScreen(index);
          },
          currentIndex: _navigatorValue,
        );
      },
    );
  }






  @override
  void onInit() async {
    super.onInit();
    LangLocalStorage langLocalStorage=LangLocalStorage();
  language = await langLocalStorage.currentLanguage ;
  await Get.updateLocale(Locale(language));
  print(await langLocalStorage.currentLanguage);
  update();
  }
}