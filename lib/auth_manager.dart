import 'package:final_exam/service/auth_services.dart';
import 'package:final_exam/views/signIn_page.dart';
import 'package:final_exam/views/signUp.dart';
import 'package:flutter/material.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return (AuthService.authService.getCurrentUser()==null)
    ? const SignInPage()
    : const SignUpPage();
  }
}
