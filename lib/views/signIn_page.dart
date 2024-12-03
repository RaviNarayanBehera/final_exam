import 'package:final_exam/controller/auth_controller.dart';
import 'package:final_exam/service/auth_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignIn extends StatelessWidget {
  const SignIn({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AttendanceController());
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'SignIn',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller.txtEmail,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: controller.txtPassword,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            const SizedBox(
              height: 30,
            ),
            TextButton(
                onPressed: () {
                  Get.toNamed('/signUp');
                },
                child: const Text('Do not have an account')),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
                onPressed: () async {
                  String response = await AuthService.authService
                      .signInWithEmailAndPassword(controller.txtEmail.text,
                          controller.txtPassword.text);
                  User? user = AuthService.authService.getCurrentUser();
                  if (user != null && response == 'Login Success') {
                    await Get.offAndToNamed('/home');
                  } else {
                    Get.snackbar('Sign In Failed', response);
                  }
                  controller.txtEmail.clear();
                  controller.txtPassword.clear();
                },
                child: const Text('Sign In'))
          ],
        ),
      ),
    );
  }
}
