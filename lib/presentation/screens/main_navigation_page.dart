import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/cart_provider.dart';
import 'home_page.dart';
import 'categories_page.dart';
import 'cart_page.dart';
import 'profile_page.dart';

class MainNavigationPage extends ConsumerStatefulWidget {
  final int initialIndex;

  const MainNavigationPage({
    super.key,
    this.initialIndex = 0,
  });

  @override
  ConsumerState<MainNavigationPage> createState() =>
      MainNavigationPageState();
}

class MainNavigationPageState
    extends ConsumerState<MainNavigationPage> {
  late int _currentIndex;

  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();

    // Use the requested starting tab.
    _currentIndex = widget.initialIndex.clamp(0, 3);

    _pages = [
      const HomePage(),

      const CategoriesPage(
        selectedCategory: 'All',
      ),

      const CartPage(),

      const ProfilePage(),
    ];
  }

  /// Allows another page to switch the selected tab.
  void changeTab(int index) {
    if (index < 0 || index >= _pages.length) {
      return;
    }

    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);

    final cartItemCount = cartItems.fold<int>(
      0,
      (sum, item) => sum + item.quantity,
    );

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: SafeArea(
        child: Container(
          height: 75,
          decoration: BoxDecoration(
            color: const Color(0xFFF8F9FA),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 15,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                icon: Icons.home_rounded,
                label: 'Home',
                index: 0,
              ),

              _buildNavItem(
                icon: Icons.grid_view_rounded,
                label: 'Categories',
                index: 1,
              ),

              _buildNavItem(
                icon: Icons.shopping_cart_rounded,
                label: 'Cart',
                index: 2,
                badge: cartItemCount > 0
                    ? cartItemCount.toString()
                    : null,
              ),

              _buildNavItem(
                icon: Icons.person_rounded,
                label: 'Profile',
                index: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    String? badge,
  }) {
    final bool isSelected = _currentIndex == index;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        changeTab(index);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 7,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFFC5A059)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 24,
                  color: isSelected
                      ? const Color(0xFF4E3700)
                      : const Color(0xFF4E4639),
                ),

                const SizedBox(height: 3),

                Text(
                  label,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? const Color(0xFF4E3700)
                        : const Color(0xFF4E4639),
                  ),
                ),
              ],
            ),

            if (badge != null && badge.isNotEmpty)
              Positioned(
                right: -5,
                top: -5,
                child: Container(
                  width: 18,
                  height: 18,
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: Color(0xFFAC322E),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    badge,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}