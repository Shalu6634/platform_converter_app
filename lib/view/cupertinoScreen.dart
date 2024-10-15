import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/controller/converterController.dart';

import 'package:platform_converter_app/controller/platform_controller.dart';
import 'package:platform_converter_app/controller/profile_Controller.dart';


class CupertinoScreen extends StatelessWidget {
  const CupertinoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var controller = Get.put(Convertercontroller());
    var profileController = Get.put(ProfileController());
    Future<void> _selectTime(BuildContext context) async {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      homeController.time =
          pickedTime!.hour.toString() + ":" + pickedTime.minute.toString();
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Platform Converter',
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
          ),
          actions: [
            Obx(
              () => CupertinoSwitch(
                value: controller.platformConverter.value,
                onChanged: (value) {
                  controller.platformConverter.value = value;
                },
              ),
            ),
          ]),
      body: CupertinoPageScaffold(
        child: CupertinoTabScaffold(
          tabBar: CupertinoTabBar(
            activeColor: Colors.blue,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
              ),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.chat_bubble_text), label: 'chat'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.person), label: 'call'),
              BottomNavigationBarItem(
                  icon: Icon(CupertinoIcons.phone), label: 'settings'),
            ],
          ),
          tabBuilder: (BuildContext context, int index) {
            switch (index) {
              case 0:
                return CupertinoTabView(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () async {
                              homeController.ImagefilePath.value = "";
                              ImagePicker image = ImagePicker();
                              XFile? xfile = await image.pickImage(
                                  source: ImageSource.gallery);
                              String path = xfile!.path;
                              File fileImage = File(path);
                              homeController.setImg(fileImage);
                              if (homeController.ImgPath != null) {
                                homeController.ImagefilePath.value = "image";
                              }
                            },
                            child: Obx(
                              () => CircleAvatar(
                                radius: height * 0.085,
                                backgroundColor: Theme.of(context).focusColor,
                                backgroundImage: (homeController
                                            .ImagefilePath.value ==
                                        "")
                                    ? null
                                    : FileImage(homeController.ImgPath!.value),
                                child:
                                    (homeController.ImagefilePath.value == "")
                                        ? Icon(
                                            CupertinoIcons.camera,
                                            size: height * 0.035,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .onPrimaryContainer,
                                          )
                                        : null,
                                // child: controller.ImgPath!.value == null
                                //     ? Icon(Icons.person, size: 100)
                                //     : null,
                              ).marginOnly(
                                  top: height * 0.020, bottom: height * 0.030),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 20),
                            child: CupertinoTextField(
                              placeholder: 'Name',
                              cursorColor: Colors.blueAccent,
                              prefix: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(CupertinoIcons.person),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blue,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 20),
                            child: CupertinoTextField(
                              placeholder: 'Phone',
                              cursorColor: Colors.blueAccent,
                              prefix: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(CupertinoIcons.phone),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blue,
                                  )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                right: 20, left: 20, top: 20),
                            child: CupertinoTextField(
                              placeholder: 'Chat',
                              cursorColor: Colors.blueAccent,
                              prefix: const Padding(
                                padding: EdgeInsets.all(10),
                                child: Icon(CupertinoIcons.chat_bubble_text),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.blue,
                                  )),
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
                                        homeController.date =
                                            day.year.toString() +
                                                "-" +
                                                day.month.toString() +
                                                "-" +
                                                day.day.toString();
                                        return true;
                                      },
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.calendar_today,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: height * 0.030,
                                  ),
                                ),
                                Text(
                                  '   Pick Date',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
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
                                    CupertinoIcons.clock,
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    size: height * 0.030,
                                  ),
                                ),
                                Text(
                                  '   Pick Time',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18),
                                ),
                              ],
                            ).marginOnly(left: 15, top: 15, bottom: 15),
                          ),
                          CupertinoButton(
                            child: Text(
                              'SAVE',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColorLight),
                            ),
                            onPressed: () {
                              homeController.insertAllData(
                                  homeController.ImgPath!.value.path,
                                  homeController.time!,
                                  homeController.date!,
                                  homeController.txtChat.text,
                                  homeController.txtPhone.text,
                                  homeController.txtName.text);
                              homeController.txtName.clear();
                              homeController.txtPhone.clear();
                              homeController.txtChat.clear();
                              homeController.ImagefilePath.value = "";
                              homeController.time = "";
                              homeController.date = "";
                            },
                            color: CupertinoColors.activeBlue,
                          )
                        ],
                      ),
                    );
                  },
                );
              case 1:
                if ((homeController.data.length == 0)) {
                  return CupertinoTabView(
                    builder: (BuildContext context) {
                      return CupertinoPageScaffold(
                        child: Center(
                            child: Text(
                          'No any chats yet...',
                          style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                              color: Colors.grey.shade800),
                        )),
                      );
                    },
                  );
                } else {
                  return ListView.builder(
                    itemCount: homeController.data.length,
                    itemBuilder: (context, index) => Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Card(
                          child: CupertinoListTile(
                            title:
                                Text('${homeController.data[index]['name']}'),
                            subtitle:
                                Text('${homeController.data[index]['chat']}'),
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                File(homeController.data[index]['img']),
                              ),
                            ),
                            trailing: Text(
                                '${homeController.data[index]['date'] + ' \n ${homeController.data[index]['time']}'}'),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              case 2:
                if (homeController.data.isEmpty) {
                  return const Center(child: Text('No any chat yet'));
                }

                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                    itemCount: homeController.data.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                File(homeController.data[index]['img']),
                              ),
                            ),
                            title: Text(homeController.data[index]['name'],style: TextStyle(color: Theme.of(context).primaryColor),),
                            subtitle: Text(homeController.data[index]['chat']),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  CupertinoIcons.phone,
                                  color: Colors.green,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      homeController.removeData(
                                        int.parse(
                                          homeController.data[index]['id']
                                              .toString(),
                                        ),
                                      );
                                    },
                                    child: const Icon(
                                      CupertinoIcons.delete,
                                      color: Colors.red,
                                    )),
                              ],
                            )),
                      );
                    },
                  ),
                );
              case 3:
                return Obx(
                  () => Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // Profile section
                          ListTile(
                            leading: Icon(Icons.person),
                            title: const Text('Profile'),
                            subtitle: const Text('Update Profile Data'),
                            trailing: CupertinoSwitch(
                              value: profileController.isProfileEditable.value,
                              onChanged: (value) {
                                profileController.toggleProfileEditable();
                              },
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (profileController.isProfileEditable.value)
                            Column(
                              children: [
                                CircleAvatar(
                                  radius: 40,
                                  backgroundColor: Colors.blue,
                                  child: IconButton(
                                    icon: Icon(CupertinoIcons.camera, size: 32),
                                    onPressed: () {},
                                  ),
                                ),
                                const Padding(
                                  padding: const EdgeInsets.only(top: 10,left: 100),
                                  child: CupertinoTextField(
                                    placeholder: 'Enter your name...',
                                    decoration: BoxDecoration(),
                                  ),
                                ),
                                const Padding(
                                  padding:  EdgeInsets.only(top: 10,left: 100),
                                  child: CupertinoTextField(

                                    placeholder: 'Enter your bio...',
                                    decoration: BoxDecoration(),
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        // Add save functionality
                                      },
                                      child: Text('SAVE',
                                          style:
                                              TextStyle(color: Colors.blue)),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Add clear functionality
                                      },
                                      child: Text('CLEAR',
                                          style:
                                              TextStyle(color: Colors.blue)),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          const Divider(thickness: 1),
                          // Theme section
                          ListTile(
                            leading: Icon(Icons.brightness_6),
                            title: Text('Theme'),
                            subtitle: Text('Change Theme'),
                            trailing: CupertinoSwitch(
                              value: profileController.isDarkTheme.value,
                              onChanged: (value) {
                                profileController.toggleTheme();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}
