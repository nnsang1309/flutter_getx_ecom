import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/bottom_nav_bar.dart';
import '../../controllers/cart_controller.dart';
import 'cart_item_tile.dart';

class CartScreen extends GetView<CartController> {
  static String routeName = "/cart";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Obx(
          () {
            // Kiểm tra nếu giỏ hàng trống
            if (controller.cartItems.isEmpty) {
              return const Center(child: Text('No items in cart'));
            }
            // Hiển thị danh sách sản phẩm trong giỏ hàng
            return Column(
              children: [
                // Danh sách sản phẩm
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = controller.cartItems[index];
                      return CartItemTile(item: cartItem);
                    },
                  ),
                ),
                // Phần tổng cộng và nút thanh toán
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      // Hiển thị tổng tiền
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            '\$${controller.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Nút thanh toán
                      ElevatedButton(
                        onPressed: () => controller.checkout(),
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 60),
                          backgroundColor: Get.theme.colorScheme.primary,
                        ),
                        child: Text(
                          'Checkout',
                          style: TextStyle(
                            color: Get.theme.colorScheme.onPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        // Thanh điều hướng dưới cùng
        bottomNavigationBar: const BottomNavBar(currentIndex: 2));
  }
}
