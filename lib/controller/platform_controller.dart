
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:platform_converter_app/helper/platform_helper.dart';
import 'package:sqflite/sqflite.dart';
class HomeController extends  GetxController
{
  Database? _db;
  RxList data = [].obs;
  TextEditingController txtChat = TextEditingController();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initDb();
    getContactInfo();
  }

  Future<void> initDb()
    async {
      await DbHelper.dbHelper.database;
    }

    Future<void>  insertAllData(String name,String chat, String phone)
     async {
       await DbHelper.dbHelper.insertData(name,chat,phone);
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
  Future<void> updateData(
      int id,String name, String chat,String phone) async {
    await DbHelper.dbHelper.updateInfo(name, chat, phone,id);
    await getContactInfo();
  }
}