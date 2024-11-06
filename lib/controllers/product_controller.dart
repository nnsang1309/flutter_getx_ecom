import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/products_model.dart';

class ProductController extends GetxController {
  var products = <Product>[].obs;
  var isLoading = true.obs;
  var categories = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
    fetchCategories();
  }

  // Fetch products
  void fetchProducts() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse('https://dummyjson.com/products'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        products.value = List<Product>.from(data['products'].map((item) => Product.fromJson(item)));
      } else {
        Get.snackbar('Error', 'Failed to load products');
      }
    } finally {
      isLoading(false);
    }
  }

  // Fetch categories
  void fetchCategories() async {
    try {
      var response = await http.get(Uri.parse('https://dummyjson.com/products/categories'));
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        categories.value = data.map((item) => item.toString()).toList();
      } else {
        Get.snackbar('Error', 'Failed to load categories');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load categories');
    }
  }
}
