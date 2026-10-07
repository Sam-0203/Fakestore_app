import 'package:fakestore/controller/cart.dart';
import 'package:fakestore/controller/product_provider.dart';
import 'package:fakestore/core/utils/token_save.dart';
import 'package:fakestore/widgets/custom_appbar.dart';
import 'package:fakestore/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProducttDetails extends StatefulWidget {
  final int id;

  const SingleProducttDetails({super.key, required this.id});

  @override
  State<SingleProducttDetails> createState() => _SingleProducttDetailsState();
}

class _SingleProducttDetailsState extends State<SingleProducttDetails> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final productsList = Provider.of<ProductProvider>(context, listen: false);

      productsList.fetchSingleProduct(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    final product = provider.singleProduct;

    return Scaffold(
      backgroundColor: Colors.white,

      appBar: CustomAppbar(
        title: product?.title ?? '',

        color: Colors.green,

        leading: GestureDetector(
          onTap: () => Navigator.pop(context),

          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),

      body: provider.isLoading || product == null
          ? CustomLoader(text: 'Loading Product details')
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// PRODUCT IMAGE
                  Container(
                    height: 320,
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),

                    decoration: BoxDecoration(color: Colors.grey.shade100),

                    child: Image.network(product.image, fit: BoxFit.contain),
                  ),

                  /// DETAILS
                  Padding(
                    padding: const EdgeInsets.all(20),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// CATEGORY
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),

                          decoration: BoxDecoration(
                            color: Colors.green.shade50,

                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            product.category,

                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// TITLE
                        Text(
                          product.title,

                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 18),

                        /// PRICE + RATING
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,

                          children: [
                            Text(
                              '\$${product.price.toStringAsFixed(2)}',

                              style: const TextStyle(
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.orange.shade50,

                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orange,
                                    size: 20,
                                  ),

                                  const SizedBox(width: 5),

                                  Text(
                                    '${product.rating.rate}',

                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  Text(
                                    ' (${product.rating.count})',

                                    style: TextStyle(
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 25),

                        /// DESCRIPTION TITLE
                        const Text(
                          'Description',

                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        /// DESCRIPTION
                        Text(
                          product.description,

                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade700,
                            height: 1.7,
                          ),
                        ),

                        const SizedBox(height: 35),

                        /// ADD TO CART BUTTON
                        SizedBox(
                          width: double.infinity,
                          height: 55,

                          child: ElevatedButton(
                            onPressed: () async {
                              final userId = await SaveToken.getUserId();

                              if (userId == null) return;

                              final success =
                                  await Provider.of<CartProvider>(
                                    context,
                                    listen: false,
                                  ).addToCart(
                                    userId: userId,
                                    productId: product.id,
                                  );

                              if (success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Added to cart'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to add cart'),
                                  ),
                                );
                              }
                            },

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,

                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                            ),

                            child: const Text(
                              'Add To Cart',

                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
