import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ProfileController extends GetxController {
  var isProfileEditable = false.obs;
  var isDarkTheme = false.obs;

  void toggleProfileEditable() {
    isProfileEditable.value = !isProfileEditable.value;
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
  }

  ThemeData get themeData =>
      isDarkTheme.value ? ThemeData.dark() : ThemeData.light();
}
