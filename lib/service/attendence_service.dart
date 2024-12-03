import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../controller/db_controller.dart';
class FireStoreServices
{
  FireStoreServices._();
  static FireStoreServices firebaseStoreServices=FireStoreServices._();
  final FirebaseFirestore firestore=FirebaseFirestore.instance;

  List idList=[];
  var dataController=Get.put(DatabaseController());

  Future<void> deleteDataFromFireStore()
  async {
    for(int i=0;i<idList.length;i++)
    {
      await firestore.collection("users").doc(idList[i].toString()).delete();
    }
  }
  Future<void> addDataInFireStore(String name,String date,String present,int id)
  async {
    final docId=await firestore.collection("users").add(
        {
          'name':name,
          'date':date,
          'present':present,
          'id':id
        }
    );
    idList.add(docId);
  }

  Future<void> readDataFromFireStore()
  async {
    final query=await firestore.collection("users").get();
    for(final doc in query.docs)
    {
      final data=doc.data() as Map<String, dynamic>;
      dataController.insertData(data['name'], data['date'], data['present']);
    }
  }
}