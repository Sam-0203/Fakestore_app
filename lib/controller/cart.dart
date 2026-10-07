import 'package:fakestore/model/cart/cart_model.dart';
import 'package:fakestore/model/products/single_product.dart';
import 'package:fakestore/service/cart.dart';
import 'package:flutter/material.dart';

class CartProvider extends ChangeNotifier {
  final CartProductsService cartService = CartProductsService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  /// RAW CARTS
  List<CartModel> _cartItems = [];

  List<CartModel> get cartItems => _cartItems;

  /// FULL PRODUCTS
  List<SingleProductModel> _cartProducts = [];

  List<SingleProductModel> get cartProducts => _cartProducts;

  /// ADD TO CART
  Future<bool> addToCart({required int userId, required int productId}) async {
    _isLoading = true;

    notifyListeners();

    try {
      final response = await cartService.addToCart(
        userId: userId,
        productId: productId,
      );

      return response;
    } catch (e) {
      print('Cart Error: $e');

      return false;
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  /// FETCH CART PRODUCTS
  Future<void> fetchCartProducts() async {
    _isLoading = true;

    notifyListeners();

    try {
      /// GET ALL CARTS
      _cartItems = await cartService.getAllCartProducts();

      /// CLEAR OLD PRODUCTS
      _cartProducts.clear();

      /// LOOP CARTS
      for (var cart in _cartItems) {
        /// LOOP PRODUCTS
        for (var product in cart.products) {
          final item = await cartService.fetchCartProductDetails(
            product.productId,
          );

          _cartProducts.add(item);
        }
      }
    } catch (e) {
      print('Fetch Cart Error: $e');
    } finally {
      _isLoading = false;

      notifyListeners();
    }
  }

  /// DELETE PRODUCT
  Future<void> deleteCartProduct(int index) async {
    try {
      final cartId = _cartItems[index].id;

      final success = await cartService.deleteCartProduct(cartId);

      if (success) {
        _cartItems.removeAt(index);

        _cartProducts.removeAt(index);

        notifyListeners();
      }
    } catch (e) {
      print('Delete Error: $e');
    }
  }
}
