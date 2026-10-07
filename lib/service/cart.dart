import 'dart:convert';

import 'package:fakestore/core/constant/api_urls.dart';
import 'package:fakestore/model/cart/cart_model.dart';
import 'package:fakestore/model/products/single_product.dart';
import 'package:http/http.dart' as http;

class CartProductsService {
  /// ADD TO CART
  Future<bool> addToCart({required int userId, required int productId}) async {
    final cart = {
      "userId": userId,

      "products": [
        {"id": productId},
      ],
    };

    final response = await http.post(
      Uri.parse(APIUrls.addToCart),

      headers: {'Content-Type': 'application/json'},

      body: jsonEncode(cart),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      final data = jsonDecode(response.body);

      print('Cart Response: $data');

      return true;
    } else {
      throw Exception('Failed to add cart');
    }
  }

  /// GET ALL CARTS
  Future<List<CartModel>> getAllCartProducts() async {
    final response = await http.get(Uri.parse(APIUrls.addToCart));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return List<CartModel>.from(data.map((e) => CartModel.fromJson(e)));
    } else {
      throw Exception('Failed to load cart');
    }
  }

  /// FETCH SINGLE PRODUCT
  Future<SingleProductModel> fetchCartProductDetails(int productId) async {
    final response = await http.get(
      Uri.parse('${APIUrls.singleProduct}$productId'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return SingleProductModel.fromJson(data);
    } else {
      throw Exception('Failed to fetch product');
    }
  }

  /// DELETE CART PRODUCT
  Future<bool> deleteCartProduct(int cartId) async {
    final response = await http.delete(
      Uri.parse('${APIUrls.deleteCartProduct}$cartId'),
    );

    if (response.statusCode == 200) {
      print('Product Deleted');

      return true;
    } else {
      throw Exception('Failed to delete cart');
    }
  }
}
