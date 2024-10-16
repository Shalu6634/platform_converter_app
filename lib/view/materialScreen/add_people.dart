import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/controller/platform_controller.dart';
import 'package:platform_converter_app/controller/profile_Controller.dart';

import '../home_page.dart';

class AddPeople extends StatelessWidget {
  const AddPeople({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var profileController = Get.put(ProfileController());
    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        builder: (BuildContext context, Widget? child) =>
            Theme(
                data:
                ThemeData.dark().copyWith(
             colorScheme: ColorScheme.dark(
               primary: Colors.white,
             )
            ),
                child: child!),
        context: context,
        initialTime: TimeOfDay.now(),
      );

      homeController.time =
          pickedTime!.hour.toString() + ":" + pickedTime.minute.toString();
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () async {
                      homeController.ImagefilePath.value = "";
                      ImagePicker image = ImagePicker();
                      XFile? xfile =
                          await image.pickImage(source: ImageSource.gallery);

                      if (xfile != null) {
                        // Check if xfile is not null
                        String path = xfile.path;
                        File fileImage = File(path);
                        homeController.setImg(fileImage);
                        homeController.ImagefilePath.value = "img";
                      } else {
                        // Handle the case where the user did not pick an image
                        print("No image selected");
                      }
                    },
                    child: Obx(
                      () => CircleAvatar(
                        radius: height * 0.085,
                        backgroundColor: Theme.of(context).focusColor,
                        backgroundImage:
                            (homeController.ImagefilePath.value == "")
                                ? null
                                : FileImage(homeController.ImgPath!.value),
                        child: (homeController.ImagefilePath.value == "")
                            ? Icon(
                                Icons.add_a_photo_outlined,
                                size: height * 0.035,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onPrimaryContainer,
                              )
                            : null,

                      ).marginOnly(top: height * 0.020, bottom: height * 0.030),
                    ),
                  ),
                ),

                //image
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: width * 0.9,
              height: height * 0.1 - 30,
              child: TextFormField(
                controller: homeController.txtName,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                cursorColor: Theme.of(context).primaryColorDark,
                decoration: InputDecoration(
                  labelText: 'Full name',
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorDark),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: width * 0.9,
              height: height * 0.1 - 30,
              child: TextFormField(
                controller: homeController.txtPhone,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                cursorColor: Theme.of(context).primaryColorDark,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorDark),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              width: width * 0.9,
              height: height * 0.1 - 30,
              child: TextFormField(
                controller: homeController.txtChat,
                style: TextStyle(color: Theme.of(context).primaryColorDark),
                cursorColor: Theme.of(context).primaryColorDark,
                decoration: InputDecoration(
                  labelText: 'Chat',
                  labelStyle:
                      TextStyle(color: Theme.of(context).primaryColorDark),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(10)),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Theme.of(context).primaryColorDark),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      showDatePicker(
                        context: context,
                        firstDate: DateTime(2000),
                        lastDate: DateTime.now(),
                        selectableDayPredicate: (day) {
                          homeController.date = day.year.toString() +
                              "-" +
                              day.month.toString() +
                              "-" +
                              day.day.toString();
                          return true;
                        },
                      );
                    },
                    child: Icon(
                      Icons.calendar_month_outlined,
                      color: Theme.of(context).primaryColorDark,
                      size: height * 0.030,
                    ),
                  ),
                  Text(
                    '   Pick Date',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ],
              ).marginOnly(left: 15, top: 10),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, top: 10),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      _selectTime(context);
                    },
                    child: Icon(
                      Icons.watch_later_outlined,
                      color: Theme.of(context).primaryColorDark,
                      size: height * 0.030,
                    ),
                  ),
                  Text(
                    '   Pick Time',
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.w500,
                        fontSize: 18),
                  ),
                ],
              ).marginOnly(left: 15, top: 15, bottom: 15),
            ),
            OutlinedButton(
                onPressed: () async {
                  homeController.insertAllData(
                      homeController.txtName.text,
                      homeController.txtChat.text,
                      homeController.txtPhone.text,
                      homeController.ImgPath!.value.path,
                      homeController.date!,
                      homeController.time!);

                  homeController.txtChat.clear();
                  homeController.txtName.clear();
                  homeController.txtPhone.clear();
                  homeController.ImagefilePath.value = "";
                  homeController.time = "";
                  homeController.date = "";
                  GetSnackBar(
                    title: ' Add Contact',
                  );
                },
                child: const Text(
                  'save',
                  style: TextStyle(color: Colors.green, fontSize: 17),
                ))
          ],
        ),
      ),
    );
  }
}
