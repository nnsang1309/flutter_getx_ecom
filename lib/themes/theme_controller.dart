import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'dark_mode.dart';
import 'light_mode.dart';

class ThemeController extends GetxController {
  // Sử dụng Rx để theo dõi thay đổi
  final _themeData = lightMode.obs;

  // Getter cho theme hiện tại
  ThemeData get themeData => _themeData.value;

  // Kiểm tra có phải dark mode không
  bool get isDarkMode => _themeData.value == darkMode;

  // Cập nhật theme
  void setTheme(ThemeData theme) {
    _themeData.value = theme;
  }

  // Chuyển đổi giữa dark và light mode
  void toggleTheme() {
    _themeData.value = isDarkMode ? lightMode : darkMode;
  }
}
