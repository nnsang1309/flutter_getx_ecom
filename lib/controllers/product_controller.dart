import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/products_model.dart';
import '../constants/api_constants.dart';

class ProductController extends GetxController {
  // Tối ưu khai báo biến
  final products = <Product>[].obs;
  final isLoading = true.obs;
  final categories = <String>[].obs;
  final selectedCategory = ''.obs;
  final filteredProducts = <Product>[].obs;
  final loadingCategorySlug = ''.obs;

  // Thêm constant cho category names
  static const Map<String, String> categoryNames = {
    'fragrances': 'Nước hoa',
    'groceries': 'Tạp hóa',
    'furniture': 'Nội thất',
    'beauty': 'Làm đẹp'
  };

  @override
  void onInit() {
    super.onInit();
    // Khởi tạo dữ liệu
    fetchProducts();
    fetchCategories();
    // Lắng nghe thay đổi danh mục được chọn
    ever(selectedCategory, (_) => filterProducts());
    // Khởi tạo filteredProducts khi products thay đổi
    ever(products, (_) => initializeFilteredProducts());
  }

  // Khởi tạo danh sách sản phẩm đã lọc
  void initializeFilteredProducts() {
    if (selectedCategory.value.isEmpty) {
      filteredProducts.value = products;
    }
  }

  // Lấy danh sách sản phẩm từ API
  Future<void> fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(ApiConstants.products));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        products.value = List<Product>.from(data['products'].map((item) => Product.fromJson(item)));
        // Cập nhật filteredProducts ngay sau khi lấy products
        filteredProducts.value = products;
      } else {
        Get.snackbar('Lỗi', 'Không thể tải sản phẩm');
      }
    } catch (e) {
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi tải sản phẩm');
    } finally {
      isLoading(false);
    }
  }

  // Lấy danh sách danh mục từ API
  void fetchCategories() async {
    try {
      var response = await http.get(Uri.parse('https://dummyjson.com/products/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> categoriesJson = jsonDecode(response.body);
        final Map<String, String> categoryNames = {
          'fragrances': 'Nước hoa',
          'groceries': 'Tạp hóa',
          'furniture': 'Nội thất',
          'beauty': 'Làm đẹp'
        };

        // Lọc và lấy chỉ những category có trong categoryNames
        categories.value = categoryNames.keys.toList();
      }
    } catch (e) {
      print('Lỗi khi lấy danh mục: $e');
      Get.snackbar('Lỗi', 'Không thể tải danh mục sản phẩm');
    }
  }

  // Lọc sản phẩm theo danh mục được chọn
  void filterProducts() {
    if (selectedCategory.value == '') {
      filteredProducts.value = products;
    } else {
      filteredProducts.value = products
          .where((product) => product.category.name.toLowerCase() == selectedCategory.value)
          .toList();
    }
  }

  // Chọn danh mục và tải sản phẩm theo danh mục
  void selectCategory(String category) async {
    try {
      loadingCategorySlug.value = category;
      if (selectedCategory.value == category) {
        // Nếu chọn lại category đang active, reset về hiển thị tất cả
        selectedCategory.value = '';
        await fetchProducts(); // Lấy lại tất cả sản phẩm
      } else {
        selectedCategory.value = category;
        await fetchProductsByCategory(category);
      }
    } finally {
      loadingCategorySlug.value = '';
    }
  }

  // Lấy sản phẩm theo danh mục từ API
  Future<void> fetchProductsByCategory(String categorySlug) async {
    try {
      var response =
          await http.get(Uri.parse('https://dummyjson.com/products/category/$categorySlug'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['products'] != null && data['products'].isNotEmpty) {
          products.value = List<Product>.from(
            data['products']
                .map((item) {
                  try {
                    return Product.fromJson(item);
                  } catch (e) {
                    print('Lỗi khi phân tích sản phẩm: $e');
                    return null;
                  }
                })
                .where((item) => item != null)
                .toList(),
          );
        } else {
          products.value = [];
          Get.snackbar('Thông báo', 'Không có sản phẩm trong danh mục này');
        }
      } else {
        Get.snackbar('Lỗi', 'Không thể tải sản phẩm');
      }
    } catch (e) {
      print('Error fetching products by category: $e');
      Get.snackbar('Lỗi', 'Đã xảy ra lỗi khi tải sản phẩm');
    }
  }
}
