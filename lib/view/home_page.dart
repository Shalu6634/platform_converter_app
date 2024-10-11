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
    _tabController = TabController(length: 1, vsync: this);
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
          // Tab(
          //   icon: Icon(Icons.chat),
          // ),
          // Tab(
          //   icon: Icon(Icons.call),
          // ),
          // Tab(
          //   icon: Icon(Icons.settings),
          // ),
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
                                fit: BoxFit.cover, image: NetworkImage('')),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 140, left: 130),
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
                    // controller: txtName,
                    style: TextStyle(color: Colors.black),
                    cursorColor: Colors.green,
                    decoration: InputDecoration(
                      labelText: 'Full name',
                      labelStyle: TextStyle(color: Colors.green),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.green),
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
                    // controller: txtEmail,
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
                    // controller: txtEmail,
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
              OutlinedButton(onPressed: (){

              }, child: Text('save',style: TextStyle(color: Colors.green,fontSize: 17),))
              ],
            ),
          )
        ],
      ),
    );
  }
}
