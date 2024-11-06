import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';
import 'login.dart';

class Signup extends StatelessWidget {
  // static route name
  static String routeName = "/signup";

  // text controller
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

                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(
                    hintText: "Enter your name",
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintText: "Email address",
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Password",
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                  ),
                ),
                SizedBox(height: 24.0),
                ElevatedButton(
                  onPressed: () {
                    // Handle sign up logic
                  },
                  child: Text("SIGN UP"),
                ),
                SizedBox(height: 16.0),

                // sign up with
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text("or sign up with"),
                //     SizedBox(width: 8.0),
                //     IconButton(
                //       onPressed: () {
                //         // Handle Apple sign up
                //       },
                //       icon: Image.asset("assets/apple_logo.png"),
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         // Handle Google sign up
                //       },
                //       icon: Image.asset("assets/google_logo.png"),
                //     ),
                //     IconButton(
                //       onPressed: () {
                //         // Handle Facebook sign up
                //       },
                //       icon: Image.asset("assets/facebook_logo.png"),
                //     ),
                //   ],
                // ),

                SizedBox(height: 16.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have account?"),
                    SizedBox(width: 8.0),
                    GestureDetector(
                      onTap: () {
                        // Navigate to login screen

                        Get.toNamed(AppRoutes.login);
                      },
                      child: Text(
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
