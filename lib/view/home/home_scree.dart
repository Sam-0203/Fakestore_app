import 'dart:ui';
import 'package:fakestore/controller/product_provider.dart';
import 'package:fakestore/core/utils/token_save.dart';
import 'package:fakestore/view/authentication/login_screen.dart';
import 'package:fakestore/view/authentication/user_profile.dart';
import 'package:fakestore/view/home/cart.dart';
import 'package:fakestore/view/home/categories.dart';
import 'package:fakestore/view/home/single_product_details.dart';
import 'package:fakestore/widgets/custom_appbar.dart';
import 'package:fakestore/widgets/custom_loader.dart';
import 'package:fakestore/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String displayName = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      Provider.of<ProductProvider>(context, listen: false).fetchAllProducts();
    });
    _displayUserName();
  }

  Future<void> _displayUserName() async {
    final String? userName = await SaveToken.getUserName();

    setState(() {
      displayName = userName ?? 'NO';
    });
  }

  Future<void> _logout() async {
    //REMOVE TOKEN
    await SaveToken.removeToken();

    // NAVIGATE TO LOGIN
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginiScreen()),
      (route) => false,
    );
  }

  // ── Pages ──────────────────────────────────────────────────────────────────
  Widget _buildHomeTab() {
    final provider = Provider.of<ProductProvider>(context);
    return provider.isLoading
        ? const CustomLoader(text: 'Loading all Products')
        : GridView.builder(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 110),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.62,
            ),
            itemCount: provider.allProducts.length,
            itemBuilder: (context, index) {
              final product = provider.allProducts[index];
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
          );
  }

  Widget _buildPlaceholderTab(IconData icon, String label) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 64, color: Colors.green.withOpacity(0.5)),
          const SizedBox(height: 12),
          Text(
            label,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> get _pages => [_buildHomeTab(), Categories(), UserProfile()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.white,
      appBar: CustomAppbar(
        color: Colors.green,
        title: "Welcome to Fakestore",
        subTitle: displayName,

        // if(_selectedIndex == 2);
        action: _selectedIndex == 2
            ? [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () => _logout(),
                    icon: const Icon(
                      Icons.logout_outlined,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ]
            : [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyShoppingCart(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.green,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
              ],
      ),
      // ── AnimatedSwitcher swaps pages with a fade ──────────────────────────
      body: SafeArea(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          transitionBuilder: (child, animation) =>
              FadeTransition(opacity: animation, child: child),
          child: KeyedSubtree(
            key: ValueKey(_selectedIndex), // key change triggers animation
            child: _pages[_selectedIndex],
          ),
        ),
      ),
      bottomNavigationBar: _FloatingGlassNavBar(
        selectedIndex: _selectedIndex,
        onTap: (i) => setState(() => _selectedIndex = i),
      ),
    );
  }
}

// ── Floating Glass Nav Bar ───────────────────────────────────────────────────
class _FloatingGlassNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onTap;

  const _FloatingGlassNavBar({
    required this.selectedIndex,
    required this.onTap,
  });

  static const _items = [
    (icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    (
      icon: Icons.category_outlined,
      activeIcon: Icons.category_rounded,
      label: 'Categories',
    ),
    (
      icon: Icons.person_outline,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            height: 68,
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.18),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.35),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(_items.length, (i) {
                final item = _items[i];
                final isSelected = selectedIndex == i;

                return GestureDetector(
                  onTap: () => onTap(i),
                  behavior: HitTestBehavior.opaque,
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(end: isSelected ? 1.0 : 0.0),
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeInOut,
                    builder: (context, value, child) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withOpacity(0.22 * value),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Icon smoothly scales up when selected
                            Transform.scale(
                              scale: 1.0 + (0.15 * value),
                              child: Icon(
                                isSelected ? item.activeIcon : item.icon,
                                color: Color.lerp(
                                  Colors.black54,
                                  Colors.green,
                                  value,
                                ),
                                size: 22,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              item.label,
                              style: TextStyle(
                                fontSize: 10,
                                color: Color.lerp(
                                  Colors.black54,
                                  Colors.green,
                                  value,
                                ),
                                fontWeight: FontWeight.lerp(
                                  FontWeight.normal,
                                  FontWeight.w700,
                                  value,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
