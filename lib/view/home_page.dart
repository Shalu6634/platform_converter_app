import 'dart:io';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_converter_app/controller/platform_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

ImagePicker imagePicker = ImagePicker();
File? fileImage;

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var homeController = Get.put(HomeController());

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contacts'),
        bottom: TabBar(controller: _tabController, tabs: const [
          Tab(
            icon: Icon(Icons.person_add_alt_1),
          ),
          Tab(
            text: 'Chat',
          ),
          Tab(
            text: 'Call',
          ),
          Tab(
            text: 'Settings',
          ),
        ]),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 30),
                        child: Container(
                          height: height * 0.2,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              shape: BoxShape.circle,
                              image: (fileImage != null)
                                  ? DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(fileImage!))
                                  : const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          'assets/image/ganpati.jpeg'),
                                    )),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 130, left: 100),
                      child: Center(
                        child: Container(
                          height: height * 0.1 - 12,
                          width: width * 0.1 - 12,
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle, color: Colors.green),
                          child: Center(
                            child: GestureDetector(
                              onTap: () async {
                                XFile? xfileImage = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                                setState(() {
                                  fileImage = File(xfileImage!.path);
                                });
                              },
                              child: const Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
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
                    style: const TextStyle(color: Colors.black),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: 'Full name',
                      labelStyle: const TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
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
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      labelStyle: const TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
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
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: 'Chat',
                      labelStyle: const TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 1, color: Colors.green),
                          borderRadius: BorderRadius.circular(10)),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  child: Row(
                    children: [Icon(Icons.calendar_month), Text(' Pick Date')],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 25, top: 10),
                  child: Row(
                    children: [
                      Icon(Icons.watch_later_outlined),
                      Text(' Pick Time')
                    ],
                  ),
                ),
                OutlinedButton(
                    onPressed: () async {
                      String name = homeController.txtName.text;
                      String chat = homeController.txtChat.text;
                      String phone = homeController.txtPhone.text;
                      homeController.insertAllData(name, chat, phone);

                      homeController.txtChat.clear();
                      homeController.txtName.clear();
                      homeController.txtPhone.clear();
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
          Obx(() {
            if (homeController.data.isEmpty) {
              return const Center(child: Text('No items found.'));
            }
            return Padding(
              padding: const EdgeInsets.all(10),
              child: ListView.builder(
                itemCount: homeController.data.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                        title: Text(homeController.data[index]['name']),
                        subtitle: Text(homeController.data[index]['chat']),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GestureDetector(
                                onTap: () {
                                 showDialog(context: context, builder: (context) =>
                                     AlertDialog(
                                       title: Text('Update Info'),
                                       content: Column(
                                         mainAxisSize: MainAxisSize.min,
                                         children: [
                                           TextField(
                                           controller:homeController.txtName,
                                             decoration: InputDecoration(),
                                           ),
                                           TextField(
                                             controller:homeController.txtChat,
                                             decoration: InputDecoration(),
                                           ),
                                           TextField(
                                             controller:homeController.txtPhone,
                                             decoration: InputDecoration(),
                                           ),

                                         ],
                                       ),
                                       actions: [
                                         IconButton(onPressed: (){
                                           homeController.updateData(
                                               homeController.data[index]['id'],
                                               homeController.txtName.text,
                                               homeController.txtChat.text,
                                               homeController.txtPhone.text);
                                           Get.back();
                                         }, icon: Text('Save'))

                                       ],
                                     )
                                 );
                                },
                                child: const Icon(Icons.edit)),
                            SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                                onTap: () {
                                  homeController.removeData(
                                    int.parse(
                                      homeController.data[index]['id'].toString(),
                                    ),
                                  );
                                },
                                child: const Icon(Icons.delete))
                          ],
                        )),
                  );
                },
              ),
            );
          }),
          Column(
            children: [],
          ),
          Column(
            children: [],
          )
        ],
      ),
    );
  }
}
