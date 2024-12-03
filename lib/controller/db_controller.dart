import 'package:get/get.dart';

import '../helper/db_helper.dart';

class DatabaseController extends GetxController
{
  RxList dataList=[].obs;
  @override
  void onInit() {
    // TODO: implement onInit
    initDb();
    getData();
    super.onInit();
  }

  Future<void> initDb()
  async {
    await DatabaseHelper.databaseHelper.database;
  }

  Future<void> insertData(String name,String date,String present)
  async {
    await DatabaseHelper.databaseHelper.addData(name, date, present);
    getData();
  }

  Future<RxList> getData()
  async {
    dataList.value=await DatabaseHelper.databaseHelper.readData();
    return dataList;
  }

  Future<void> updateData(String name,String date,String present,int id)
  async {
    await DatabaseHelper.databaseHelper.updateData(name, date, present, id);
    getData();
  }

  Future<void> deleteData(int id)
  async {
    await DatabaseHelper.databaseHelper.deleteData(id);
  }


}