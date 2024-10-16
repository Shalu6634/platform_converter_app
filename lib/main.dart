import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter_app/controller/converterController.dart';
import 'package:platform_converter_app/controller/profile_Controller.dart';
import 'package:platform_converter_app/view/cupertinoScreen.dart';
import 'package:platform_converter_app/view/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        FocusScope.of(context).unfocus(); // Hides the keyboard
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    var profileController=Get.put(ProfileController());
    var controller = Get.put(Convertercontroller());
    return Obx(
      () => GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: CupertinoColors.activeBlue,
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.black,
            colorScheme: ColorScheme.light(
              primary: Colors.black87,
              secondary: Colors.grey.shade800,
              onPrimary: Colors.grey,
              onSecondary: Color(0xffe8ddfd),
              onPrimaryContainer: Color(0xff4f378a),
            )),
        darkTheme: ThemeData(
            primaryColor: CupertinoColors.activeBlue,
            primaryColorLight: Colors.white,
            primaryColorDark: Colors.white,
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
              secondary: Colors.grey.shade500,
              onPrimary: Colors.grey.shade800,
              onSecondary: Color(0xff4f378a),
              onPrimaryContainer: Colors.white,
            )),
        themeMode:
            (profileController.isDarkTheme.value == true) ? ThemeMode.dark : ThemeMode.light,
        home: controller.platformConverter == true
            ? const CupertinoScreen()
            : HomePage(),
        // getPages: [
        //   GetPage(name: '/', page: () => Navigatescreen(),),
        // ],
      ),
    );

  }
}
