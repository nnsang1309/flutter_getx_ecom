import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/cart_controller.dart';
import '../../models/products_model.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final cartController = Get.put(CartController());
  ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị hình ảnh sản phẩm
          Expanded(
            child: Stack(
              children: [
                Image.network(
                  product.thumbnail,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          // Hiển thị thông tin sản phẩm
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Hiển thị tên sản phẩm
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // Hiển thị giá sản phẩm
                Text(
                  '\$${product.price}',
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                // Nút "Add to Cart" với hiệu ứng gợn sóng
                Material(
                  color: Get.theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(4),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(4),
                    onTap: () => cartController.addToCart(product),
                    child: Container(
                      width: double.infinity,
                      height: 36,
                      alignment: Alignment.center,
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          color: Get.theme.colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
