import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/auth_controller.dart';
import '../../routes/app_routes.dart';

class Login extends StatelessWidget {
  static String routeName = "/login";

  // Khởi tạo AuthController
  final AuthController authController = Get.put(AuthController());

  // text controller
  final TextEditingController usernameController = TextEditingController(text: 'emilys');
  final TextEditingController passwordController = TextEditingController(text: 'emilyspass');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0),
                const Text(
                  "Log into your account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50.0),

                // username
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                  ),
                ),
                const SizedBox(height: 16.0),

                // password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 24.0),

                // login button
                ElevatedButton(
                  onPressed: () {
                    // Xử lý logic đăng nhập
                    authController.login(
                      usernameController.text,
                      passwordController.text,
                    );
                    Get.offAllNamed(AppRoutes.home);
                  },
                  child: const Text("Log In"),
                ),
                // Phần chuyển hướng đến trang đăng ký
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account?"),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        // Chuyển hướng đến màn hình đăng ký
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
