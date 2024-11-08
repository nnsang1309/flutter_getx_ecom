import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_routes.dart';
import '../controllers/cart_controller.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;

  const BottomNavBar({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartController>(
        init: CartController(),
        builder: (cartController) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentIndex,
            // Xử lý sự kiện khi tab được chọn
            onTap: (index) {
              switch (index) {
                case 0:
                  Get.toNamed(AppRoutes.home);
                  break;
                case 1:
                  Get.toNamed(AppRoutes.search);
                  break;
                case 2:
                  Get.toNamed(AppRoutes.cart);
                  break;
                case 3:
                  Get.toNamed(AppRoutes.profile);
                  break;
              }
            },
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
              // Item Cart với badge hiển thị số lượng sản phẩm
              BottomNavigationBarItem(
                icon: Stack(
                  children: [
                    const Icon(Icons.shopping_cart),
                    // Hiển thị badge khi có sản phẩm trong giỏ hàng
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Obx(() => cartController.cartItems.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              constraints: const BoxConstraints(
                                minWidth: 14,
                                minHeight: 14,
                              ),
                              child: Text(
                                '${cartController.cartItems.length}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            )
                          : Container()),
                    ),
                  ],
                ),
                label: 'Cart',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          );
        });
  }
}
