import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import '../service/auth_services.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AttendanceController());
    return Scaffold(
      appBar: AppBar(title: Text('SignUp',),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(controller: controller.txtEmail,decoration: InputDecoration(labelText: 'Email'),),
            TextField(controller: controller.txtPassword,decoration: InputDecoration(labelText: 'Password'),),
            SizedBox(height: 30,),
            TextButton(onPressed: () {
              Get.back();
            }, child: Text('Already have an account')),
            SizedBox(height: 30,),
            ElevatedButton(onPressed: () {
              AuthService.authService.createAccountWithEmailAndPassword(controller.txtEmail.text, controller.txtPassword.text);

              Get.back();

              controller.txtEmail.clear();
              controller.txtPassword.clear();
            }, child: Text('Sign Up'))
          ],
        ),
      ),
    );
  }
}
