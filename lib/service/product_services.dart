import 'dart:convert';

import 'package:fakestore/model/products/all_products.dart';
import 'package:fakestore/core/constant/api_urls.dart';
import 'package:fakestore/model/products/single_product.dart';

import 'package:http/http.dart' as http;

class ProductService {
  List<ProductModel> products = [];

  Future<List<ProductModel>> fetchProducts() async {
    final response = await http.get(Uri.parse(APIUrls.products));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      List<ProductModel> products = (data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      print('Products : ${products}');

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<SingleProductModel> fetchSingleProduct(int id) async {
    final resposes = await http.get(Uri.parse('${APIUrls.singleProduct}${id}'));

    if (resposes.statusCode == 200) {
      final data = jsonDecode(resposes.body);

      SingleProductModel product = SingleProductModel.fromJson(data);

      print('Single Product : ${product.title}');

      return product;
    } else {
      throw Exception('Failed to load product');
    }
  }
}
