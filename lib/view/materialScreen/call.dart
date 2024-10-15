
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:platform_converter_app/controller/platform_controller.dart';
import 'package:platform_converter_app/controller/profile_Controller.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override

  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());
    var profileController = Get.put(ProfileController());
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Obx(() {
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
                    title: Text(homeController.data[index]['name']),
                    subtitle: Text(homeController.data[index]['chat']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.call,color: Colors.green,),
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
                            child: const Icon(Icons.delete,color: Colors.red,)),

                      ],
                    )),
              );
            },
          ),
        );
      }),
    );
  }
}
