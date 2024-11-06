import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class AuthController extends GetxController {
  var isAuth = false.obs;
  var currentUser = User(users: [], total: 0, skip: 0, limit: 0).obs;
  final store = GetStorage();

  // login
  void login(String email, String password) async {
    final response = await http.post(
      Uri.parse('https://dummyjson.com/auth/login'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      store.write('token', data['token']);

      // save current user data
      currentUser.value = User.fromJson({
        'users': [data],
        'total': 1,
        'skip': 0,
        'limit': 1
      });
      isAuth.value = true;
      Get.snackbar('Success', 'Login successful');
      // print current user ra log
      printCurrentUser();
    } else {
      Get.snackbar('Error', 'Invalid email or password');
    }
  }

  // logout
  void logout() {
    store.remove('token');
    currentUser.value = User(users: [], total: 0, skip: 0, limit: 0);
    isAuth.value = false;
    Get.snackbar('Success', 'Logout successful');
  }

  // checkAuth
  void checkAuth() {
    var token = store.read('token');
    if (token != null) {
      isAuth.value = true;
      // lấy thông tin user
      fetchCurrentUser();
    } else {
      isAuth.value = false;
    }
  }

  void fetchCurrentUser() async {
    var token = store.read('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/users/me'),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        currentUser.value = User.fromJson(jsonDecode(response.body));
        // print current user ra log
        printCurrentUser();
      } else {
        Get.snackbar('Error', 'Failed to fetch current user');
      }
    }
  }

  void printCurrentUser() {
    print('Current User: ${currentUser.value.users.first.firstName}');
  }

  void autoLogin() {
    login('emilys', 'emilyspass');
  }

  @override
  void onInit() {
    super.onInit();
    checkAuth();
    // if (!isAuth.value) {
    //   autoLogin();
    // }
  }
}
