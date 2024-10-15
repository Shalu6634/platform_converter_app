import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/controller/platform_controller.dart';
import 'package:platform_converter_app/controller/profile_Controller.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var profileController = Get.put(ProfileController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Obx(
      () => (homeController.data.length == 0)
          ? Center(
              child: Text(
              'No any chats yet...',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ))
          : ListView.builder(
              itemCount: homeController.data.length,
              itemBuilder: (context, index) => Card(
                    child: ListTile(
                        leading: CircleAvatar(
                          backgroundImage: FileImage(
                            File(homeController.data[index]['img']),
                          ),
                        ),
                        title: Text(homeController.data[index]['name']),
                        subtitle: Text(homeController.data[index]['chat']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${homeController.data[index]['date'] + ' \n ${homeController.data[index]['time']}'}',

                            ),
                            SizedBox(
                              width: 10,
                            ),

                            // GestureDetector(
                            //     onTap: () {
                            //       homeController.removeData(
                            //         int.parse(
                            //           homeController.data[index]['id']
                            //               .toString(),
                            //         ),
                            //       );
                            //     },
                            //     child: const Icon(
                            //       Icons.delete,
                            //       color: Colors.red,
                            //     ))

                            GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      title: const Text('Update----- '),
                                      content: SingleChildScrollView(
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            GestureDetector(
                                              onTap: () async {
                                                homeController
                                                    .ImagefilePath.value = "";
                                                ImagePicker image =
                                                    ImagePicker();
                                                XFile? xfile =
                                                    await image.pickImage(
                                                        source: ImageSource
                                                            .gallery);

                                                if (xfile != null) {
                                                  // Check if xfile is not null
                                                  String path = xfile.path;
                                                  File fileImage = File(path);
                                                  homeController
                                                      .setImg(fileImage);
                                                  homeController.ImagefilePath
                                                      .value = "img";
                                                } else {
                                                  // Handle the case where the user did not pick an image
                                                  print("No image selected");
                                                }
                                              },
                                              child: Obx(
                                                () => CircleAvatar(
                                                  radius: height * 0.060,
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .focusColor,
                                                  backgroundImage:
                                                      (homeController
                                                                  .ImagefilePath
                                                                  .value ==
                                                              "")
                                                          ? null
                                                          : FileImage(
                                                              homeController
                                                                  .ImgPath!
                                                                  .value),
                                                  child: (homeController
                                                              .ImagefilePath
                                                              .value ==
                                                          "")
                                                      ? Icon(
                                                          Icons
                                                              .add_a_photo_outlined,
                                                          size: height * 0.035,
                                                          color: Theme.of(
                                                                  context)
                                                              .colorScheme
                                                              .onPrimaryContainer,
                                                        )
                                                      : null,
                                                  // child: controller.ImgPath!.value == null
                                                  //     ? Icon(Icons.person, size: 100)
                                                  //     : null,
                                                ).marginOnly(
                                                    top: height * 0.020,
                                                    bottom: height * 0.030),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  homeController.txtName,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  hintText: 'Name....',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  homeController.txtChat,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  hintText: 'Chat....',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            TextFormField(
                                              controller:
                                                  homeController.txtPhone,
                                              decoration: InputDecoration(
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      10)),
                                                  hintText: 'Phone....',
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey)),
                                            ),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            homeController.updateData(
                                                homeController.txtName.text,
                                                homeController.txtChat.text,
                                                homeController.txtPhone.text,
                                                homeController
                                                    .ImgPath!.value.path,
                                              homeController.data[index]['id'],);

                                            homeController.txtName.clear();
                                            homeController.txtChat.clear();
                                            homeController.txtPhone.clear();
                                            homeController.time = "";
                                            homeController.date = "";
                                            Get.back();
                                          },
                                          child: Text(
                                            'save',
                                            style:
                                                TextStyle(color: Colors.green),
                                          ),
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              homeController.txtName.clear();
                                              homeController.txtPhone.clear();
                                              homeController.txtChat.clear();
                                              homeController
                                                  .ImagefilePath.value = "";
                                              homeController.time = "";
                                              homeController.date = "";
                                              Get.back();
                                            },
                                            child: Text(
                                              'cancel',
                                              style:
                                                  TextStyle(color: Colors.red),
                                            ))
                                      ],
                                    ),
                                  );
                                },
                                child: Icon(Icons.edit))
                          ],
                        )),
                  )),
    );
  }
}
