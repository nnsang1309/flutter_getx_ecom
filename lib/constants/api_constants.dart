class ApiConstants {
  // Base URL
  static const String baseUrl = 'https://dummyjson.com';

  // API Endpoints
  static const String products = '$baseUrl/products';
  static const String categories = '$baseUrl/products/categories';

  // Helper method để lấy URL sản phẩm theo danh mục
  static String productsByCategory(String categorySlug) =>
      '$baseUrl/products/category/$categorySlug';
}
