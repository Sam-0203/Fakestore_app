import 'package:fakestore/controller/product_provider.dart';
import 'package:fakestore/view/home/single_product_details.dart';
import 'package:fakestore/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  String selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);

    /// ALL CATEGORIES
    final categories = [
      'All',
      ...provider.allProducts.map((e) => e.category).toSet(),
    ];

    /// FILTER PRODUCTS
    final filteredProducts = selectedCategory == 'All'
        ? provider.allProducts
        : provider.allProducts
              .where((product) => product.category == selectedCategory)
              .toList();

    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      body: Column(
        children: [
          const SizedBox(height: 15),

          /// CATEGORY LIST
          SizedBox(
            height: 85,

            child: ListView.separated(
              scrollDirection: Axis.horizontal,

              padding: const EdgeInsets.symmetric(horizontal: 12),

              itemCount: categories.length,

              separatorBuilder: (context, index) => const SizedBox(width: 10),

              itemBuilder: (context, index) {
                final category = categories[index];

                final isSelected = selectedCategory == category;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCategory = category;
                    });
                  },

                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),

                    width: 95,

                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 8,
                    ),

                    decoration: BoxDecoration(
                      color: isSelected ? Colors.green : Colors.white,

                      borderRadius: BorderRadius.circular(18),

                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),

                          blurRadius: 8,

                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [
                        Icon(
                          _getCategoryIcon(category),

                          size: 24,

                          color: isSelected ? Colors.white : Colors.green,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          category,

                          maxLines: 1,

                          overflow: TextOverflow.ellipsis,

                          textAlign: TextAlign.center,

                          style: TextStyle(
                            fontSize: 12,

                            fontWeight: FontWeight.w600,

                            color: isSelected ? Colors.white : Colors.black87,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 15),

          /// PRODUCTS GRID
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(12),

              itemCount: filteredProducts.length,

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,

                crossAxisSpacing: 12,

                mainAxisSpacing: 12,

                childAspectRatio: 0.62,
              ),

              itemBuilder: (context, index) {
                final product = filteredProducts[index];

                return ProductCard(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            SingleProducttDetails(id: product.id),
                      ),
                    );
                  },
                  image: product.image,

                  title: product.title,

                  category: product.category,

                  price: product.price,

                  rating: product.rating.rate,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// CATEGORY ICONS
  IconData _getCategoryIcon(String category) {
    switch (category) {
      case "men's clothing":
        return Icons.man;

      case "women's clothing":
        return Icons.woman;

      case "electronics":
        return Icons.devices;

      case "jewelery":
        return Icons.diamond;

      default:
        return Icons.category;
    }
  }
}
