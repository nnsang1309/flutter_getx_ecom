import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/user.dart';

class AuthController extends GetxController {
  // Observable để theo dõi trạng thái đăng nhập
  var isAuth = false.obs;

  // Observable lưu thông tin user hiện tại, khởi tạo rỗng
  var currentUser = User(users: [], total: 0, skip: 0, limit: 0).obs;

  // GetStorage để lưu trữ locally
  final store = GetStorage();

  /// Xử lý đăng nhập
  void login(String email, String password) async {
    // Gọi API đăng nhập
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
      // Lưu token vào storage
      store.write('token', data['token']);

      // Cập nhật thông tin user hiện tại
      _updateCurrentUser(data);
      // Cập nhật trạng thái đăng nhập
      isAuth.value = true;
      Get.snackbar('Success', 'Login successful');
      // In thông tin user
      printCurrentUser();
    } else {
      Get.snackbar('Error', 'Invalid email or password');
    }
  }

  // Xử lý đăng xuất
  void logout() {
    // Xóa token
    store.remove('token');
    // Reset thông tin user về rỗng
    currentUser.value = User(users: [], total: 0, skip: 0, limit: 0);
    // Cập nhật trạng thái đăng nhập
    isAuth.value = false;
    Get.snackbar('Success', 'Logout successful');
  }

  // Kiểm tra trạng thái đăng nhập khi khởi động app
  void checkAuth() {
    var token = store.read('token');
    if (token != null) {
      isAuth.value = true;
      // Lấy thông tin user nếu có token
      fetchCurrentUser();
    } else {
      isAuth.value = false;
    }
  }

  // Lấy thông tin user hiện tại từ API
  void fetchCurrentUser() async {
    var token = store.read('token');
    if (token != null) {
      final response = await http.get(
        Uri.parse('https://dummyjson.com/auth/me'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        // Cập nhật thông tin user với dữ liệu trực tiếp từ response
        _updateCurrentUser(data);
      } else {
        Get.snackbar('Error', 'Failed to fetch current user');
      }
    }
  }

  // In thông tin user
  void printCurrentUser() {
    print('Current User: ${currentUser.value.users.first.firstName}');
  }

  // auto login
  void autoLogin() {
    login('emilys', 'emilyspass');
  }

  // kiểm tra auth khi khởi tạo controller
  @override
  void onInit() {
    super.onInit();
    checkAuth();
    // auto login
    // if (!isAuth.value) {
    //   autoLogin();
    // }
  }

  // Thêm phương thức mới để cập nhật user
  void _updateCurrentUser(dynamic userData) {
    currentUser.value = User.fromJson({
      'users': [userData],
      'total': 1,
      'skip': 0,
      'limit': 1
    });
    printCurrentUser();
  }
}
