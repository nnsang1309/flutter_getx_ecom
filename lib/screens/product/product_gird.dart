import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/product_controller.dart';
import 'product_card.dart';

class ProductGrid extends GetView<ProductController> {
  const ProductGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        height: 600,
        child: Obx(() {
          // Kiểm tra xem đang tải dữ liệu hay không
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Lọc sản phẩm dựa trên danh mục đã chọn
          final displayProducts = controller.selectedCategory.value.isEmpty
              ? controller.products
              : controller.products
                  .where((product) =>
                      product.category.name.toLowerCase() ==
                      controller.selectedCategory.value.toLowerCase())
                  .toList();

          if (displayProducts.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // Tạo lưới sản phẩm sử dụng GridView.builder
          return GridView.builder(
            padding: const EdgeInsets.all(10),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            itemCount: displayProducts.length,
            itemBuilder: (context, index) {
              final product = displayProducts[index];
              return ProductCard(product: product);
            },
          );
        }),
      ),
    );
  }
}
