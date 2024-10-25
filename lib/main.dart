import 'package:final_exam/views/home_page.dart';
import 'package:final_exam/views/signIn_page.dart';
import 'package:final_exam/views/signUp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'auth_manager.dart';
import 'firebase_options.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            // GetPage(
            //   name: '/',
            //   page: () => const SplashScreen(),
            // ),
            // GetPage(
            //   name: '/',
            //   page: () =>  const AuthManager(),
            // ),
            GetPage(
              name: '/',
              page: () => const SignInPage(),
            ),
            GetPage(
              name: '/signUp',
              page: () => const SignUpPage(),
            ),
            GetPage(
              name: '/home',
              page: () =>  HomePage(),
            ),
          ],
    );
  }
}

// 11:58
