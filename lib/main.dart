import 'package:flutter/material.dart';
import 'package:flutter_getx_ecom/controllers/auth_controller.dart';
import 'package:flutter_getx_ecom/controllers/cart_controller.dart';
import 'package:get/get.dart';

import 'routes/app_pages.dart';
import 'routes/app_routes.dart';
import 'screens/home_screen.dart';
import 'screens/auth/login.dart';
import 'themes/light_mode.dart';

void main() {
  Get.put(CartController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: lightMode,
      home: Obx(() {
        // Sử dụng Obx để theo dõi trạng thái đăng nhập
        final AuthController authController = Get.put(AuthController());
        return authController.isAuth.value ? HomeScreen() : Login();
      }),
      // Route ban đầu
      initialRoute: AppRoutes.initial,
      // Các route của ứng dụng
      getPages: AppPages.routes,
    );
  }
}
