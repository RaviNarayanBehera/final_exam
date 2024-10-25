import 'package:final_exam/service/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/shop_item_controller.dart';
import '../modal/shop_modal.dart';

class HomePage extends StatelessWidget {
  final ItemController itemController = Get.put(ItemController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  void showEditDialog(BuildContext context, Item item) {
    nameController.text = item.name;
    categoryController.text = item.category;
    priceController.text = item.price.toString();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: categoryController,
                decoration: const InputDecoration(labelText: 'Category'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                String name = nameController.text;
                String category = categoryController.text;
                String price = priceController.text;

                if (name.isNotEmpty &&
                    category.isNotEmpty &&
                    price.isNotEmpty) {
                  itemController.updateItem(item.id, name, category, price);
                  nameController.clear();
                  categoryController.clear();
                  priceController.clear();
                  Navigator.of(context).pop();
                } else {
                  Get.snackbar('Error', 'Please fill all fields correctly.');
                }
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void confirmDelete(BuildContext context, String id) {
    Get.defaultDialog(
      title: 'Confirm Delete',
      middleText: 'Are you sure you want to delete this item?',
      confirm: TextButton(
        onPressed: () {
          itemController.deleteItem(id as int);
          Navigator.of(context).pop();
        },
        child: const Text('Delete'),
      ),
      cancel: TextButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text('Cancel'),
      ),
    );
  }

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping App'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.authService.signOutUser();
              User? user = AuthService.authService.getCurrentUser();
              if (user == null) {
                Get.offAndToNamed('/signIn');
              }
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      body: Obx(() {
        return ListView.builder(
          itemCount: itemController.items.length,
          itemBuilder: (context, index) {
            final item = itemController.items[index];
            return ListTile(
              leading:
                  Text('${item.id}.', style: const TextStyle(fontSize: 20)),
              title: Text(item.name),
              subtitle: Text(item.category),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('₹ ${item.price}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w400)),
                  const SizedBox(width: 15),
                  IconButton(
                    onPressed: () {
                      showEditDialog(context, item);
                    },
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      confirmDelete(context, item.id as String);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Add Item'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'Name'),
                    ),
                    TextField(
                      controller: categoryController,
                      decoration: const InputDecoration(labelText: 'Category'),
                    ),
                    TextField(
                      controller: priceController,
                      decoration: const InputDecoration(labelText: 'Price'),
                      keyboardType:
                          TextInputType.number,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      String name = nameController.text;
                      String category = categoryController.text;
                      String price = priceController.text;

                      if (name.isNotEmpty &&
                          category.isNotEmpty &&
                          price.isNotEmpty) {
                        itemController.addItem(name, category, price);
                        nameController.clear();
                        categoryController.clear();
                        priceController.clear();
                        Navigator.of(context).pop();
                      } else {
                        Get.snackbar(
                            'Error', 'Please fill all fields correctly.');
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
