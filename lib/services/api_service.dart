import 'package:dio/dio.dart';

import '../models/products_model.dart';

class ApiService {
  final Dio _dio;

  ApiService(this._dio);

  Future<List<Product>> fetchProductsByCategory(String categorySlug) async {
    try {
      print('API call for category: $categorySlug'); // Debug log 8
      final response = await _dio.get('/products/category/$categorySlug');
      print('Raw API response: ${response.data}'); // Debug log 9
      return (response.data as List).map((item) => Product.fromJson(item)).toList();
    } catch (e) {
      print('API Service Error: $e'); // Debug log 10
      throw e;
    }
  }
}
