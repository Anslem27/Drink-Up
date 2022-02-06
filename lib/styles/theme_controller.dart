import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';


class ThemeController extends GetxController {
  //get instance of Getstorage
  final _box = GetStorage();
  final _key = "isDarkMode";
  //Get the thememode from local storage
  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  bool _loadTheme() => _box.read(_key) ?? false;
  void saveTheme(bool isDarkMode) => _box.write(_key, isDarkMode);
  void changeTheme(ThemeData theme) => Get.changeTheme(theme);
  void changeThemeMode(ThemeMode themeMode) => Get.changeThemeMode(themeMode);
}

final themeController = Get.put(ThemeController());
//called as eg themeMode:themeController.theme 
/* final themeController= Get.find<ThemeController>()*/


/* ElevatedButton(
  onpressed(){
    if(Get.isDarkMode){
      //Change theme to light if dark
      themeController.changeThemeMode(ThemeMode.light);
      //themeController.changeTheme(Themes.light);
      themeController.saveTheme(false);
    }else{
      //change theme to dark
      themeController.changeThememode(ThemeMode.dark);
      //themeController.changeTheme(Themes.dark);
      themeControler.saveTheme(true);
    }
  }
) */