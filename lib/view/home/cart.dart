import 'package:fakestore/controller/cart.dart';
import 'package:fakestore/widgets/custom_appbar.dart';
import 'package:fakestore/widgets/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyShoppingCart extends StatefulWidget {
  const MyShoppingCart({super.key});

  @override
  State<MyShoppingCart> createState() => _MyShoppingCartState();
}

class _MyShoppingCartState extends State<MyShoppingCart> {
  /// QUANTITY LIST
  List<int> quantities = [];

  @override
  void initState() {
    super.initState();

    Future.microtask(() async {
      await Provider.of<CartProvider>(
        context,
        listen: false,
      ).fetchCartProducts();

      final provider = Provider.of<CartProvider>(context, listen: false);

      setState(() {
        quantities = List.generate(provider.cartProducts.length, (index) => 1);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CartProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: CustomAppbar(
        color: Colors.green,

        title: "My Cart",

        leading: GestureDetector(
          onTap: () => Navigator.pop(context),

          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),

      body: provider.isLoading
          ? const CustomLoader(text: 'Loading Cart')
          : provider.cartProducts.isEmpty
          ? const Center(child: Text('Cart is Empty'))
          : Column(
              children: [
                /// CART PRODUCTS
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12),

                    itemCount: provider.cartProducts.length,

                    itemBuilder: (context, index) {
                      final product = provider.cartProducts[index];

                      /// SAFE QUANTITY
                      final quantity = index < quantities.length
                          ? quantities[index]
                          : 1;

                      /// TOTAL PRICE
                      double totalPrice = product.price * quantity;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),

                        padding: const EdgeInsets.all(12),

                        decoration: BoxDecoration(
                          color: Colors.white,

                          borderRadius: BorderRadius.circular(22),

                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),

                              blurRadius: 10,

                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Column(
                          children: [
                            /// TOP SECTION
                            Row(
                              children: [
                                /// IMAGE
                                Container(
                                  height: 100,
                                  width: 100,

                                  padding: const EdgeInsets.all(10),

                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,

                                    borderRadius: BorderRadius.circular(18),
                                  ),

                                  child: Image.network(
                                    product.image,

                                    fit: BoxFit.contain,
                                  ),
                                ),

                                const SizedBox(width: 15),

                                /// DETAILS
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,

                                    children: [
                                      Text(
                                        product.title,

                                        maxLines: 2,

                                        overflow: TextOverflow.ellipsis,

                                        style: const TextStyle(
                                          fontSize: 16,

                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      const SizedBox(height: 8),

                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 10,

                                          vertical: 4,
                                        ),

                                        decoration: BoxDecoration(
                                          color: Colors.green.shade50,

                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                        ),

                                        child: Text(
                                          product.category,

                                          style: TextStyle(
                                            color: Colors.green.shade700,

                                            fontSize: 12,

                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 12),

                                      Text(
                                        '\$${totalPrice.toStringAsFixed(2)}',

                                        style: const TextStyle(
                                          fontSize: 22,

                                          fontWeight: FontWeight.bold,

                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 15),

                            /// QUANTITY SECTION
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,

                              children: [
                                const Text(
                                  'Quantity',

                                  style: TextStyle(
                                    fontSize: 16,

                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade100,

                                    borderRadius: BorderRadius.circular(15),
                                  ),

                                  child: Row(
                                    children: [
                                      /// MINUS
                                      IconButton(
                                        onPressed: () async {
                                          if (quantity > 1) {
                                            setState(() {
                                              quantities[index] = quantity - 1;
                                            });
                                          } else {
                                            /// DELETE
                                            await provider.deleteCartProduct(
                                              index,
                                            );

                                            /// REMOVE QUANTITY
                                            if (index < quantities.length) {
                                              setState(() {
                                                quantities.removeAt(index);
                                              });
                                            }

                                            ScaffoldMessenger.of(
                                              context,
                                            ).showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  'Product removed from cart',
                                                ),
                                              ),
                                            );
                                          }
                                        },

                                        icon: const Icon(Icons.remove),
                                      ),

                                      /// QUANTITY
                                      Text(
                                        quantity.toString(),

                                        style: const TextStyle(
                                          fontSize: 18,

                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),

                                      /// PLUS
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            if (index < quantities.length) {
                                              quantities[index]++;
                                            }
                                          });
                                        },

                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                /// BOTTOM PAYMENT SECTION
                Container(
                  padding: const EdgeInsets.all(20),

                  decoration: BoxDecoration(
                    color: Colors.white,

                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(30),

                      topRight: Radius.circular(30),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),

                        blurRadius: 10,

                        offset: const Offset(0, -4),
                      ),
                    ],
                  ),

                  child: Column(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      /// TOTAL
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,

                        children: [
                          const Text(
                            'Total Amount',

                            style: TextStyle(
                              fontSize: 18,

                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          Text(
                            '\$${provider.cartProducts.asMap().entries.fold<double>(0, (sum, entry) {
                              final index = entry.key;

                              final item = entry.value;

                              return sum + (item.price * (index < quantities.length ? quantities[index] : 1));
                            }).toStringAsFixed(2)}',

                            style: const TextStyle(
                              fontSize: 24,

                              fontWeight: FontWeight.bold,

                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      /// PAY BUTTON
                      SizedBox(
                        width: double.infinity,

                        height: 55,

                        child: ElevatedButton(
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Proceeding to payment...'),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,

                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),

                          child: const Text(
                            'Proceed To Pay',

                            style: TextStyle(
                              fontSize: 18,

                              fontWeight: FontWeight.bold,

                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}
