import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';
// Remove: import '../../domain/models/product_model.dart';
import '../../domain/models/cart_item_model.dart';
import 'categories_page.dart';

class CartPage extends ConsumerWidget {
  const CartPage({super.key});

  static const Color primary = Color(0xFF775A19);
  static const Color primaryContainer = Color(0xFFC5A059);
  static const Color secondary = Color(0xFFAC322E);
  static const Color background = Color(0xFFF8F9FA);
  static const Color surfaceContainer = Color(0xFFEDF0F1);
  static const Color surfaceContainerHigh = Color(0xFFE7E8E9);
  static const Color outlineVariant = Color(0xFFD1C5B4);
  static const Color textColor = Color(0xFF191C1D);
  static const Color mutedText = Color(0xFF4E4639);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    
    // Calculate totals from cart items
    final subtotal = cartItems.fold(
      0.0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
    
    final estimatedTax = subtotal * 0.015;
    final total = subtotal + estimatedTax;
    
    final totalItems = cartItems.fold(
      0,
      (sum, item) => sum + item.quantity,
    );

    String formatPrice(double price) {
      return 'ETB ${price.toStringAsFixed(2)}';
    }

    void updateQuantity(int index, int change) {
      final currentItem = cartItems[index];
      final newQuantity = currentItem.quantity + change;
      
      if (newQuantity <= 0) {
        ref.read(cartProvider.notifier).removeProduct(currentItem.product);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${currentItem.product.title} removed from cart'),
            backgroundColor: secondary,
          ),
        );
      } else if (change > 0) {
        ref.read(cartProvider.notifier).increaseQuantity(currentItem.product);
      } else {
        ref.read(cartProvider.notifier).decreaseQuantity(currentItem.product);
      }
    }

    void removeItem(int index) {
      final removedItem = cartItems[index];
      ref.read(cartProvider.notifier).removeProduct(removedItem.product);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${removedItem.product.title} removed from cart'),
          backgroundColor: secondary,
        ),
      );
    }

    void continueShopping() {
      Navigator.pop(context);
    }

    void goToCategoriesPage() {
      // Navigate to categories page with a default selected category
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const CategoriesPage(
            selectedCategory: 'All', // Add the required parameter
          ),
        ),
      );
    }

    void proceedToCheckout() {
      if (cartItems.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Your cart is empty'),
          ),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Proceeding to checkout...'),
          backgroundColor: primary,
        ),
      );
    }

    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        elevation: 1,
        shadowColor: Colors.black12,
        centerTitle: true,
        leading: const Icon(
          Icons.location_on_outlined,
          color: primary,
        ),
        title: const Text(
          'Habesha Mart',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: primary,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: mutedText,
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: cartItems.isEmpty
            ? _buildEmptyCart(goToCategoriesPage)
            : SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(
                  20,
                  24,
                  20,
                  120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildCartHeader(totalItems),
                    const SizedBox(height: 24),
                    
                    // Cart Items
                    ...List.generate(
                      cartItems.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: _buildCartItem(
                          cartItems[index],
                          index,
                          updateQuantity,
                          removeItem,
                          formatPrice,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    Container(
                      height: 1,
                      width: double.infinity,
                      color: outlineVariant.withValues(alpha: 0.3),
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Continue Shopping
                    SizedBox(
                      width: double.infinity,
                      child: TextButton.icon(
                        onPressed: continueShopping,
                        icon: const Icon(
                          Icons.arrow_back,
                          color: primary,
                        ),
                        label: const Text(
                          'Continue Shopping',
                          style: TextStyle(
                            color: primary,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: TextButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                    
                    // Order Summary
                    _buildOrderSummary(
                      context,
                      subtotal,
                      estimatedTax,
                      total,
                      formatPrice,
                      proceedToCheckout,
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // Express Delivery
                    _buildExpressDelivery(),
                  ],
                ),
              ),
      ),
    );
  }

  Widget _buildCartHeader(int totalItems) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Your Cart',
          style: TextStyle(
            fontFamily: 'Montserrat',
            fontSize: 28,
            height: 1.3,
            fontWeight: FontWeight.w700,
            color: textColor,
          ),
        ),
        Text(
          '$totalItems Items',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(
    CartItem item,
    int index,
    void Function(int, int) updateQuantity,
    void Function(int) removeItem,
    String Function(double) formatPrice,
  ) {
    final double itemTotal = item.product.price * item.quantity;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: outlineVariant.withValues(alpha: 0.3),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 20,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: 96,
                  height: 96,
                  child: Image.network(
                    item.product.image,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: surfaceContainerHigh,
                        child: const Icon(
                          Icons.image_not_supported_outlined,
                          color: Colors.grey,
                          size: 32,
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(width: 16),
              
              // Product Information
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.product.category,
                      style: const TextStyle(
                        color: primary,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item.product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 17,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                        color: textColor,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.product.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: mutedText,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      formatPrice(itemTotal),
                      style: const TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: secondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Quantity + Remove
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildQuantitySelector(
                item.quantity,
                index,
                updateQuantity,
              ),
              TextButton.icon(
                onPressed: () {
                  removeItem(index);
                },
                icon: const Icon(
                  Icons.delete_outline,
                  color: secondary,
                  size: 18,
                ),
                label: const Text(
                  'Remove',
                  style: TextStyle(
                    color: secondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuantitySelector(
    int quantity,
    int index,
    void Function(int, int) updateQuantity,
  ) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
        color: surfaceContainer,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: outlineVariant.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: () {
              updateQuantity(index, -1);
            },
            icon: const Icon(
              Icons.remove,
              size: 18,
              color: textColor,
            ),
          ),
          SizedBox(
            width: 24,
            child: Text(
              '$quantity',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              updateQuantity(index, 1);
            },
            icon: const Icon(
              Icons.add,
              size: 18,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(
    BuildContext context,
    double subtotal,
    double estimatedTax,
    double total,
    String Function(double) formatPrice,
    VoidCallback proceedToCheckout,
  ) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F4F5),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: outlineVariant.withValues(alpha: 0.2),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Order Summary',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
          const SizedBox(height: 24),
          _buildSummaryRow(
            'Subtotal',
            formatPrice(subtotal),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Shipping (Addis Ababa)',
            'FREE',
            valueColor: const Color(0xFF304C46),
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Estimated Tax',
            formatPrice(estimatedTax),
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            width: double.infinity,
            color: outlineVariant.withValues(alpha: 0.3),
          ),
          const SizedBox(height: 20),
          _buildSummaryRow(
            'Total',
            formatPrice(total),
            isTotal: true,
          ),
          const SizedBox(height: 24),
          
          // Promo Code
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Promo Code',
                    hintStyle: const TextStyle(
                      color: mutedText,
                      fontSize: 14,
                    ),
                    filled: true,
                    fillColor: surfaceContainerHigh.withValues(alpha: 0.5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: outlineVariant.withValues(alpha: 0.5),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                        color: outlineVariant.withValues(alpha: 0.5),
                      ),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Promo code applied'),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: mutedText,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Apply',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Checkout Button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: proceedToCheckout,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                elevation: 3,
                shadowColor: primaryContainer.withValues(alpha: 0.3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Proceed to Checkout',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 12),
                  Icon(
                    Icons.chevron_right,
                    size: 22,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          
          // Payment Icons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.payments_outlined,
                size: 28,
                color: mutedText.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 24),
              Icon(
                Icons.account_balance_outlined,
                size: 28,
                color: mutedText.withValues(alpha: 0.6),
              ),
              const SizedBox(width: 24),
              Icon(
                Icons.lock_outline,
                size: 28,
                color: mutedText.withValues(alpha: 0.6),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'Secure checkout powered by Telebirr & CBE',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: mutedText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(
    String title,
    String value, {
    Color? valueColor,
    bool isTotal = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: isTotal ? 'Montserrat' : null,
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            color: isTotal ? textColor : mutedText,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: isTotal ? 'Montserrat' : null,
            fontSize: isTotal ? 20 : 14,
            fontWeight: isTotal ? FontWeight.w600 : FontWeight.w600,
            color: valueColor ?? (isTotal ? secondary : textColor),
          ),
        ),
      ],
    );
  }

  Widget _buildExpressDelivery() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: primaryContainer.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: primaryContainer.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.local_shipping_outlined,
            color: primary,
            size: 28,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Express Delivery',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF4E3700),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Available in Addis Ababa. Get your items within 2-4 hours.',
                  style: TextStyle(
                    fontSize: 12,
                    height: 1.4,
                    color: const Color(0xFF4E3700).withValues(alpha: 0.8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCart(VoidCallback goToCategories) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: surfaceContainer,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.shopping_basket_outlined,
                  size: 80,
                  color: primary,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Your cart is empty',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 24,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Looks like you haven't added any treasures to your cart yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.5,
                color: mutedText,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: goToCategories,
              style: ElevatedButton.styleFrom(
                backgroundColor: primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 14,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Start Shopping',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}