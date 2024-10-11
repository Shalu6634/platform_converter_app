import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_converter_app/helper/platform_helper.dart';
class HomeController extends  GetxController
{
  // @override
  // void onInit() {
  //   super.onInit();
  //   initDb();
  // }
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initDb();
  }

  Future<void> initDb()
    async {
      await DbHelper.dbHelper.database;
    }

    void insertData()
    {

    }

}