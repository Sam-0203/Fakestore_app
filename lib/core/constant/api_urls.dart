class APIUrls {
  // baseurl
  static const String baseUrl = 'https://fakestoreapi.com';

  // users
  static const String login = '$baseUrl/auth/login';
  static const String users = '$baseUrl/users';
  static const String singleUser = '$baseUrl/users/';

  // Products
  static const String products = '$baseUrl/products';
  static const String singleProduct = '$baseUrl/products/';

  // Add to cart
  static const String addToCart = '$baseUrl/carts';
  static const String allCartProducts = '$baseUrl/carts';
  static const String deleteCartProduct = '$baseUrl/carts/';
}
