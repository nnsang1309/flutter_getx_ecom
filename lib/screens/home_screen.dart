import 'package:flutter/material.dart';
import 'package:flutter_getx_ecom/screens/product/product_gird.dart';
import '../components/bottom_nav_bar.dart';
import '../controllers/auth_controller.dart';
import '../controllers/product_controller.dart';
import '../routes/app_routes.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  final AuthController authController = Get.find<AuthController>();
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          title: Center(child: Text('FluxStore')),
          actions: [
            // stack notification
            Stack(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.notifications_outlined),
                ),
                Positioned(
                  top: 14,
                  right: 14,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 8,
                      minHeight: 8,
                    ),
                  ),
                ),
              ],
            ),

            // logout button
            IconButton(
              onPressed: () {
                authController.logout();
                Get.offAllNamed(AppRoutes.login);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // info user
                  Center(
                    child: Obx(
                      () => authController.isAuth.value
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    'Welcome, ${authController.currentUser.value.users.first.firstName}'),
                                // Text('Email: ${authController.currentUser.value.users.first.email}'),
                              ],
                            )
                          : Text('Please login to continue'),
                    ),
                  ),

                  const SizedBox(height: 10),

                  // categories
                  _buildCategories(context),

                  // products
                  ProductGrid(),
                ],
              ),
            ),
          ),
        ),

        // bottom navigation bar
        bottomNavigationBar: const BottomNavBar(currentIndex: 0));
  }

  // build categories
  Widget _buildCategories(BuildContext context) {
    final Map<String, IconData> categoryIcons = {
      'beauty': Icons.face_outlined,
      'fragrances': Icons.sunny,
      'furniture': Icons.chair_outlined,
      'groceries': Icons.shopping_basket,
    };

    final Map<String, String> categoryNames = {
      'fragrances': 'Nước hoa',
      'groceries': 'Tạp hóa',
      'furniture': 'Nội thất',
      'beauty': 'Làm đẹp'
    };

    return Obx(() {
      if (productController.categories.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: productController.categories.map((category) {
            final bool isSelected = productController.selectedCategory.value == category;
            final bool isLoading = productController.loadingCategorySlug.value == category;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: Icon(
                        categoryIcons[category] ?? Icons.category,
                      ),
                      onPressed:
                          isLoading ? null : () => productController.selectCategory(category),
                      color: isSelected ? Colors.blue : Colors.black,
                      style: IconButton.styleFrom(
                        backgroundColor:
                            isSelected ? Colors.blue.withOpacity(0.1) : Colors.grey[100],
                        shape: const CircleBorder(),
                      ),
                    ),
                    if (isLoading)
                      const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  categoryNames[category] ?? category,
                  style: TextStyle(
                    fontSize: 12,
                    color: isSelected ? Colors.blue : Colors.black,
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      );
    });
  }

  // build bottom navigation bar
  Widget _buildBottomNavigationBar() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: 0,
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
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shopping_cart),
          label: 'Cart',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
    );
  }
}
