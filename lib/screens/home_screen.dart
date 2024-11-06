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
              padding: const EdgeInsets.all(20.0),
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

                  // categories
                  _buildCategories(),

                  // products
                  // _buildProducts(),
                  ProductGrid()
                ],
              ),
            ),
          ),
        ),

        // bottom navigation bar
        bottomNavigationBar: const BottomNavBar(currentIndex: 0));
  }

  // build categories
  Widget _buildCategories() {
    final categories = [
      {'icon': Icons.food_bank_outlined, 'label': 'Groceries'}, // Thực phẩm
      {'icon': Icons.chair_outlined, 'label': 'Furniture'}, // Nội thất
      {'icon': Icons.sunny, 'label': 'Fragrances'}, // Nước hoa
      {'icon': Icons.face_outlined, 'label': 'Beauty'}, // Chăm sóc sắc đẹp
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: categories.map((category) {
          return Column(
            children: [
              IconButton(
                icon: Icon(category['icon'] as IconData),
                onPressed: () {},
                color: Colors.black,
                padding: const EdgeInsets.all(10),
                style: IconButton.styleFrom(
                  backgroundColor: Colors.grey[100],
                  shape: const CircleBorder(),
                ),
              ),
              const SizedBox(height: 5),
              Text(
                category['label'] as String,
                style: const TextStyle(fontSize: 12),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  // build products
  Widget _buildProducts() {
    return Obx(() {
      if (productController.isLoading.value) {
        return Center(child: CircularProgressIndicator());
      } else if (productController.products.isEmpty) {
        return Center(child: Text('No products found'));
      } else {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.6,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
          ),
          itemCount: productController.products.length,
          itemBuilder: (context, index) {
            final product = productController.products[index];
            return Card(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.network(
                      product.thumbnail,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(product.title),
                  ),
                ],
              ),
            );
          },
        );
      }
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
