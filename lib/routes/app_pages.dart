import 'package:flutter_getx_ecom/screens/home_screen.dart';
import 'package:get/get.dart';

import '../screens/auth/login.dart';
import '../screens/auth/signup.dart';
import '../screens/initial_page.dart';
import '../screens/search/search_screen.dart';
import '../screens/profile/profile_screen.dart';
import 'app_routes.dart';
import '../screens/cart/cart_screen.dart';

class AppPages {
  static final routes = [
    // Trang khởi đầu
    GetPage(
      name: AppRoutes.initial,
      page: () => const InitialPage(),
    ),
    // Trang đăng nhập
    GetPage(
      name: AppRoutes.login,
      page: () => Login(),
      transition: Transition.fadeIn,
    ),
    // Trang đăng ký
    GetPage(
      name: AppRoutes.signup,
      page: () => Signup(),
      transition: Transition.fadeIn,
    ),
    // Trang chủ
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    // Trang tìm kiếm
    GetPage(name: AppRoutes.search, page: () => SearchScreen()),
    // Trang giỏ hàng
    GetPage(name: AppRoutes.cart, page: () => CartScreen()),
    // Trang hồ sơ người dùng
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
  ];
}
