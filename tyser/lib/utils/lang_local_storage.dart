import 'package:get_storage/get_storage.dart';

class LangLocalStorage{
  //write language
  void saveLanguage(String lang) async {
    await GetStorage().write('lang', lang);
  }

  //read current language
  Future<String> get currentLanguage async{
    return await GetStorage().read('lang');
  }
}