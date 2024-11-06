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
            if (controller.cartItems.isEmpty) {
              return const Center(child: Text('No items in cart'));
            }
            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.cartItems.length,
                    itemBuilder: (context, index) {
                      final cartItem = controller.cartItems[index];
                      return CartItemTile(item: cartItem);
                    },
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Total:',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                          Text(
                            '\$${controller.total.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      ElevatedButton(
                          onPressed: () => controller.checkout(),
                          child: Text('Checkout',
                              style: TextStyle(
                                color: Get.theme.colorScheme.onPrimary,
                              )),
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(double.infinity, 60),
                            backgroundColor: Get.theme.colorScheme.primary,
                          )),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
        // bottom navigation bar
        bottomNavigationBar: const BottomNavBar(currentIndex: 2));
  }
}
