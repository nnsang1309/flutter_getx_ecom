import 'package:get/get.dart';

import '../models/products_model.dart';

class CartController extends GetxController {
  // Danh sách các mặt hàng trong giỏ hàng, sử dụng RxList để có thể quan sát được
  RxList<CartItem> cartItems = <CartItem>[].obs;

  // Tính tổng giá trị của giỏ hàng
  double get total => cartItems.fold(0, (sum, item) => sum + item.product.price * item.quantity);

  // Thêm sản phẩm vào giỏ hàng
  void addToCart(Product product) {
    final existingItem = cartItems.firstWhereOrNull((item) => item.product.id == product.id);
    if (existingItem != null) {
      existingItem.quantity++;
    } else {
      cartItems.add(CartItem(product: product, quantity: 1));
    }

    // Hiển thị thông báo khi thêm sản phẩm thành công
    // Get.snackbar('Added to Cart', '${product.title} added to cart successfully');
  }

  // Xóa sản phẩm khỏi giỏ hàng
  void removeFromCart(Product product) {
    cartItems.removeWhere((item) => item.product.id == product.id);
    // Hiển thị thông báo khi xóa sản phẩm thành công
    // Get.snackbar('Removed from Cart', '${product.title} removed from cart successfully');
  }

  // Tăng số lượng sản phẩm trong giỏ hàng
  void increaseQuantity(Product product) {
    final item = cartItems.firstWhere((item) => item.product.id == product.id);
    item.quantity++;
    cartItems.refresh();
  }

  // Giảm số lượng sản phẩm trong giỏ hàng
  void decreaseQuantity(Product product) {
    final item = cartItems.firstWhere((item) => item.product.id == product.id);
    if (item.quantity > 1) {
      item.quantity--;
      cartItems.refresh();
    } else {
      removeFromCart(product);
    }
  }

  // Xử lý thanh toán
  void checkout() {
    cartItems.clear();
    Get.snackbar(
      'Thành công',
      'Thanh toán thành công',
      duration: const Duration(seconds: 2),
      snackPosition: SnackPosition.TOP,
    );

    // Delay trước khi đóng màn hình
    Future.delayed(const Duration(seconds: 1), () {
      Get.back();
    });
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
