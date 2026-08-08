import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================
// CHECKOUT PAGE
// ============================================================
class CheckoutPage extends ConsumerStatefulWidget {
  const CheckoutPage({super.key});

  @override
  ConsumerState<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends ConsumerState<CheckoutPage> {
  String _selectedPaymentMethod = 'telebirr';
  bool _isProcessing = false;

  // Sample order data - replace with actual cart data
  final Map<String, dynamic> orderData = {
    'items': 3,
    'subtotal': 7850.00,
    'shipping': 150.00,
    'tax': 170.75,
    'total': 8170.75,
    'address': {
      'name': 'Abebe Kebede',
      'street': 'Bole Medhanialem, Near Edna Mall',
      'city': 'Addis Ababa, Ethiopia',
      'phone': '+251 911 234 567',
    },
  };

  final List<Map<String, dynamic>> paymentMethods = [
    {
      'id': 'telebirr',
      'name': 'Telebirr Wallet',
      'description': 'Pay instantly via Telebirr app',
      'icon': 'Tb',
      'color': const Color(0xFF005CB9),
    },
    {
      'id': 'cbebirr',
      'name': 'CBE Birr',
      'description': 'Mobile banking',
      'icon': 'CB',
      'color': const Color(0xFF72328D),
    },
    {
      'id': 'card',
      'name': 'Credit/Debit Card',
      'description': 'Visa, Mastercard',
      'icon': Icons.credit_card,
      'color': const Color(0xFF4E4639),
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1C1D) : const Color(0xFFF8F9FA),
      appBar: _buildAppBar(isDark),
      body: Column(
        children: [
          // Main Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Delivery Address Section
                  _buildDeliveryAddressSection(isDark),
                  
                  // Divider
                  _buildDivider(isDark),
                  
                  // Order Summary Section
                  _buildOrderSummarySection(isDark),
                  
                  // Divider
                  _buildDivider(isDark),
                  
                  // Payment Method Section
                  _buildPaymentMethodSection(isDark),
                  
                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
          
          // Bottom Action Area
          _buildBottomActionArea(isDark),
        ],
      ),
    );
  }

  // ============================================================
  // APP BAR
  // ============================================================
  PreferredSizeWidget _buildAppBar(bool isDark) {
    return AppBar(
      backgroundColor: isDark ? const Color(0xFF1A1C1D) : const Color(0xFFF8F9FA),
      elevation: 0,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back,
          color: isDark ? Colors.white : const Color(0xFF4E4639),
        ),
      ),
      title: Text(
        'Checkout',
        style: GoogleFonts.montserrat(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: isDark ? Colors.white : const Color(0xFF191C1D),
        ),
      ),
      centerTitle: true,
      toolbarHeight: 64,
    );
  }

  // ============================================================
  // DELIVERY ADDRESS SECTION
  // ============================================================
  Widget _buildDeliveryAddressSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(top: 8),
      color: isDark ? const Color(0xFF2E3132) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on,
                    color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                    size: 20,
                    weight: 700,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Delivery Address',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF191C1D),
                    ),
                  ),
                ],
              ),
              TextButton(
                onPressed: () {
                  // Navigate to edit address
                },
                style: TextButton.styleFrom(
                  foregroundColor: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(40, 40),
                ),
                child: const Text('Edit'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF3E4142) : const Color(0xFFF8F9FA),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isDark 
                    ? const Color(0xFF4E4142) 
                    : const Color(0xFFD1C5B4).withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderData['address']['name'],
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : const Color(0xFF191C1D),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        orderData['address']['street'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                          height: 1.5,
                        ),
                      ),
                      Text(
                        orderData['address']['city'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                          height: 1.5,
                        ),
                      ),
                      Text(
                        orderData['address']['phone'],
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // DIVIDER
  // ============================================================
  Widget _buildDivider(bool isDark) {
    return Container(
      height: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF4E4142) : const Color(0xFFD1C5B4),
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }

  // ============================================================
  // ORDER SUMMARY SECTION
  // ============================================================
  Widget _buildOrderSummarySection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: isDark ? const Color(0xFF2E3132) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.receipt_long,
                color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                size: 20,
                weight: 700,
              ),
              const SizedBox(width: 8),
              Text(
                'Order Summary',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF191C1D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _buildSummaryRow(
            'Subtotal (${orderData['items']} items)',
            'ETB ${orderData['subtotal'].toStringAsFixed(2)}',
            isDark,
          ),
          _buildSummaryRow(
            'Shipping Fee',
            'ETB ${orderData['shipping'].toStringAsFixed(2)}',
            isDark,
          ),
          _buildSummaryRow(
            'Tax (VAT 15%)',
            'ETB ${orderData['tax'].toStringAsFixed(2)}',
            isDark,
          ),
          const SizedBox(height: 12),
          Container(
            height: 1,
            color: isDark 
                ? const Color(0xFF4E4142) 
                : const Color(0xFFD1C5B4).withValues(alpha: 0.5),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF191C1D),
                ),
              ),
              Text(
                'ETB ${orderData['total'].toStringAsFixed(2)}',
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFFF6B6B) : const Color(0xFFAC322E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white : const Color(0xFF191C1D),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // PAYMENT METHOD SECTION
  // ============================================================
  Widget _buildPaymentMethodSection(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      color: isDark ? const Color(0xFF2E3132) : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.account_balance_wallet,
                color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                size: 20,
                weight: 700,
              ),
              const SizedBox(width: 8),
              Text(
                'Payment Method',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : const Color(0xFF191C1D),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...paymentMethods.map((method) {
            return _buildPaymentOption(method, isDark);
          }),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(Map<String, dynamic> method, bool isDark) {
    final isSelected = _selectedPaymentMethod == method['id'];
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedPaymentMethod = method['id'];
          });
        },
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF3E4142) : const Color(0xFFF8F9FA),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19))
                  : (isDark ? const Color(0xFF4E4142) : const Color(0xFFD1C5B4)),
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Row(
            children: [
              // Icon/Logo
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: method['id'] == 'card'
                      ? (isDark ? const Color(0xFF4E4142) : const Color(0xFFE1E3E4))
                      : (method['color'] as Color).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: method['id'] == 'card'
                      ? Icon(
                          method['icon'] as IconData,
                          color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                          size: 24,
                        )
                      : Text(
                          method['icon'] as String,
                          style: TextStyle(
                            color: method['color'] as Color,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                ),
              ),
              const SizedBox(width: 12),
              // Method details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      method['name'],
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xFF191C1D),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      method['description'],
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                      ),
                    ),
                  ],
                ),
              ),
              // Radio button
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19))
                        : (isDark ? const Color(0xFF4E4142) : const Color(0xFFD1C5B4)),
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isSelected
                          ? (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19))
                          : Colors.transparent,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ============================================================
  // BOTTOM ACTION AREA
  // ============================================================
  Widget _buildBottomActionArea(bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2E3132) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, -8),
          ),
        ],
        border: Border(
          top: BorderSide(
            color: isDark 
                ? const Color(0xFF4E4142) 
                : const Color(0xFFD1C5B4).withValues(alpha: 0.2),
          ),
        ),
      ),
      child: SizedBox(
        width: double.infinity,
        height: 48,
        child: ElevatedButton(
          onPressed: _isProcessing ? null : _processPayment,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
            foregroundColor: isDark ? const Color(0xFF191C1D) : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            elevation: 8,
            shadowColor: (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19)).withValues(alpha: 0.25),
            disabledBackgroundColor: (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19)).withValues(alpha: 0.6),
          ),
          child: _isProcessing
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.lock,
                      color: isDark ? const Color(0xFF191C1D) : Colors.white,
                      size: 20,
                      weight: 700,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Pay ETB ${orderData['total'].toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: isDark ? const Color(0xFF191C1D) : Colors.white,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  // ============================================================
  // PROCESS PAYMENT
  // ============================================================
  void _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate payment processing
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      setState(() {
        _isProcessing = false;
      });

      // Show success dialog
      _showPaymentSuccessDialog();
    }
  }

  void _showPaymentSuccessDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2E3132) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.check_circle,
                color: Colors.green,
                size: 48,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Payment Successful!',
              style: GoogleFonts.montserrat(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isDark ? Colors.white : const Color(0xFF191C1D),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been confirmed.\nThank you for shopping with us!',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context); // Go back to cart or home
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                  foregroundColor: isDark ? const Color(0xFF191C1D) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}