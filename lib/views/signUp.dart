import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../global/auth_controller.dart';
import '../service/auth_services.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w500,
              letterSpacing: 1.5,
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Get.back(result: '/signIn');
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.blue.shade100,
          ),
          child: AlertDialog(
            shadowColor: Colors.black,
            title: const Center(
                child: Text(
              'Create an Account',
              style: TextStyle(color: Colors.black),
            )),
            content: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: controller.txtName,
                      decoration: const InputDecoration(
                        labelText: "Name",
                        labelStyle: TextStyle(color: Colors.black54),
                      ),
                      style: const TextStyle(color: Colors.black),
                    ),
                    TextField(
                      controller: controller.txtEmail,
                      decoration: const InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(color: Colors.black54)),
                      style: const TextStyle(color: Colors.black),
                    ),
                    TextField(
                      controller: controller.txtPhone,
                      decoration: const InputDecoration(
                          labelText: "Phone Number",
                          labelStyle: TextStyle(color: Colors.black54)),
                      style: const TextStyle(color: Colors.black),
                    ),
                    TextField(
                      controller: controller.txtPassword,
                      decoration: const InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(color: Colors.black54)),
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                    ),
                    TextField(
                      controller: controller.txtConfirmPassword,
                      decoration: const InputDecoration(
                          labelText: "Confirm Password",
                          labelStyle: TextStyle(color: Colors.black54)),
                      style: const TextStyle(color: Colors.black),
                      obscureText: true,
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      onPressed: () {
                        Get.back();
                        controller.txtEmail.clear();
                        controller.txtPassword.clear();
                      },
                      child: const Text(
                        "Already have an account? Sign In",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(Colors.white)),
                      onPressed: () async {
                        if (controller.txtPassword.text ==
                            controller.txtConfirmPassword.text) {
                          await AuthService.authService
                              .createAccountWithEmailAndPassword(
                            controller.txtEmail.text,
                            controller.txtPassword.text,
                          );

                          Get.back();

                          controller.txtName.clear();
                          controller.txtEmail.clear();
                          controller.txtPhone.clear();
                          controller.txtPassword.clear();
                          controller.txtConfirmPassword.clear();

                        }
                      },
                      child: const Text(
                        'Sign Up',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
