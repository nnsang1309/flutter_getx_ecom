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
    GetPage(
      name: AppRoutes.initial,
      page: () => const InitialPage(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => Login(),
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: AppRoutes.signup,
      page: () => Signup(),
      transition: Transition.fadeIn,
    ),
    GetPage(name: AppRoutes.home, page: () => HomeScreen()),
    GetPage(name: AppRoutes.search, page: () => SearchScreen()),
    GetPage(name: AppRoutes.cart, page: () => CartScreen()),
    GetPage(name: AppRoutes.profile, page: () => ProfileScreen()),
  ];
}
