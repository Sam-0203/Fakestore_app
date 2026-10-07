import 'package:fakestore/model/products/all_products.dart';
import 'package:fakestore/model/products/single_product.dart';
import 'package:fakestore/service/product_services.dart';
import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final ProductService productService = ProductService();

  List<ProductModel> _allProducts = [];
  bool _isLoading = false;

  SingleProductModel? _singleProductDetails;

  List<ProductModel> get allProducts => _allProducts;
  bool get isLoading => _isLoading;

  SingleProductModel? get singleProduct => _singleProductDetails;

  // Fetch all products
  Future<void> fetchAllProducts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _allProducts = await productService.fetchProducts();
    } catch (e) {
      print('Error fetching products: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> fetchSingleProduct(int id) async {
    _isLoading = true;
    notifyListeners();
    try {
      _singleProductDetails = await productService.fetchSingleProduct(id);
    } catch (e) {
      print('Error fetching single product: $e');
    }
    _isLoading = false;
    notifyListeners();
  }
}
