import 'package:get/get.dart';

import '../models/products_model.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  double get total => cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  void addToCart(Product product) {
    final existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }

    Get.snackbar('Added to Cart', '${product.title} added to cart successfully');
  }

  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    Get.snackbar('Removed from Cart', '${product.title} removed from cart successfully');
  }

  void increaseQuantity(Product product) {
    final item = cartItems.firstWhere((item) => item.product.id == product.id);
    item.quantity++;
    cartItems.refresh();
  }

  void decreaseQuantity(Product product) {
    final item = cartItems.firstWhere((item) => item.product.id == product.id);
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(product);
    }
  }

  void checkout() {
    cartItems.clear();
    Get.snackbar('Checkout', 'Checkout successful');
    Get.back();
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
