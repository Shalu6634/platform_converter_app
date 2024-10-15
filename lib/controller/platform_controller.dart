
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform_converter_app/helper/platform_helper.dart';

class HomeController extends  GetxController
{

  RxList data = [].obs;

   String? date;
   String? time;

  RxString ImagefilePath="".obs;
  Rx<File>? ImgPath;
  TextEditingController txtChat = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  int selectedIndex  = 0;
  @override
  void onInit() {
    // TODO: implement onInit
    initDb();
    super.onInit();
    getContactInfo();
  }
  void setImg(File img) {
    ImgPath = img.obs;
  }
  Future<void> initDb()
    async {
      await DbHelper.dbHelper.database;
    }

    Future<void>  insertAllData(String name,String chat,String phone,String img,String date,String time)
     async {
       await DbHelper.dbHelper.insertData(name,chat,phone,img,date,time);
      await getContactInfo();
    }


  Future<RxList> getContactInfo() async {
    data.value = await DbHelper.dbHelper.readData();
    return data;
  }

  Future<void> removeData(int id) async {

    print(id);
   await DbHelper.dbHelper.removeInfo(id);
    print('===================');
    print(id);
    await getContactInfo();
  }
  Future<void> updateData(String name,String chat,String phone,String img,int id) async {
    await DbHelper.dbHelper.updateInfo(name,chat,phone,img,id);
    await getContactInfo();
  }
  //ios
  //datetime


}