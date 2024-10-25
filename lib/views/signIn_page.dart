import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/auth_controller.dart';
import '../service/auth_services.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('SingIn Page'),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue.shade100),
        child: AlertDialog(
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Center(
              child: Text(
            'Welcome Back',
            style: TextStyle(color: Colors.black),
          )),
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: controller.txtEmail,
                    decoration: const InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: Colors.black54)),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  TextField(
                    controller: controller.txtPassword,
                    decoration: const InputDecoration(
                        labelText: "Password",
                        labelStyle: TextStyle(color: Colors.black54)),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 25),
                  TextButton(
                    onPressed: () {
                      Get.toNamed('/signUp');
                      controller.txtEmail.clear();
                      controller.txtPassword.clear();
                    },
                    child: const Center(
                      child: Text(
                        "Don't have an account? Sign Up        ",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 13,
                            letterSpacing: 0.8,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.white)),
                    onPressed: () async {
                      String response = await AuthService.authService
                          .signInWithEmailAndPassword(
                        controller.txtEmail.text,
                        controller.txtPassword.text,
                      );

                      Get.offAndToNamed('/home');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
