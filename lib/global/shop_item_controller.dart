import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../modal/shop_modal.dart';


class ItemController extends GetxController {
  var items = <Item>[].obs;
  var idCounter = 1.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchItems();
  }

  Future<void> fetchItems() async {
    final snapshot = await _firestore.collection('items').get();
    items.value = snapshot.docs.map((doc) {
      final data = doc.data();
      return Item(
        id: data['id'],
        name: data['name'],
        category: data['category'],
        price: data['price'],
      );
    }).toList();
  }

  Future<void> addItem(String name, String category,String price) async {
    await _firestore.collection('items').add({
      'id': idCounter.value,
      'name': name,
      'category': category,
      'price':price,
    });
    items.add(Item(id: idCounter.value++, name: name, category: category,price: price));
  }

  Future<void> updateItem(int id, String name, String category, String price) async {
    try {
      await _firestore.collection('items').doc(id as String?).update({
        'name': name,
        'category': category,
        'price': price, // Store as string
      });

      // Update the local item list
      final index = items.indexWhere((item) => item.id == id);
      if (index != -1) {
        items[index] = Item(id: id, name: name, category: category, price: price);
        update(); // Notify the UI to refresh
      }
    } catch (e) {
      print('Error updating item: $e');
      Get.snackbar('Error', 'Failed to update item.');
    }
  }

  Future<void> deleteItem(String id) async {
    try {
      await _firestore.collection('items').doc(id).delete();
      items.removeWhere((item) => item.id == id);
      update(); // Notify the UI to refresh
    } catch (e) {
      print('Error deleting item: $e');
      Get.snackbar('Error', 'Failed to delete item.');
    }
  }

}
