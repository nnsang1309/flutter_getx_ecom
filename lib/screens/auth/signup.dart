import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

class Signup extends StatelessWidget {
  // static route name
  static String routeName = "/signup";

  // Khai báo các controller cho các trường nhập liệu
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50.0),
                const Text(
                  "Create your account",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 50.0),
                // Name
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                  ),
                ),
                const SizedBox(height: 16.0),
                // Email
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    hintText: "Email address",
                  ),
                ),
                const SizedBox(height: 16.0),
                // Password
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Password",
                  ),
                ),
                const SizedBox(height: 16.0),
                // Confirm password
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    hintText: "Confirm password",
                  ),
                ),
                const SizedBox(height: 24.0),
                // Nút đăng ký
                ElevatedButton(
                  onPressed: () {
                    // Xử lý logic đăng ký
                  },
                  child: const Text("SIGN UP"),
                ),
                const SizedBox(height: 16.0),
                const SizedBox(height: 16.0),
                // Phần chuyển hướng đến trang đăng nhập
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have account?"),
                    const SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        // Chuyển hướng đến màn hình đăng nhập
                        Get.toNamed(AppRoutes.login);
                      },
                      child: const Text(
                        "Log In",
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
