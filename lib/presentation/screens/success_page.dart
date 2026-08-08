import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

// ============================================================
// ORDER SUCCESS PAGE
// ============================================================
class OrderSuccessPage extends ConsumerStatefulWidget {
  final Map<String, dynamic>? orderData;
  
  const OrderSuccessPage({
    super.key,
    this.orderData,
  });

  @override
  ConsumerState<OrderSuccessPage> createState() => _OrderSuccessPageState();
}

class _OrderSuccessPageState extends ConsumerState<OrderSuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation1;
  late Animation<double> _fadeAnimation2;
  late Animation<double> _fadeAnimation3;

  // Default order data if none provided
  final Map<String, dynamic> _defaultOrderData = {
    'orderNumber': 'HM-8921',
    'total': 8170.75,
    'estimatedDelivery': 'Today, 1:30 PM',
    'items': 3,
  };

  @override
  void initState() {
    super.initState();
    
    // Initialize animations
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );
    
    _fadeAnimation1 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.2, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _fadeAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.3, 0.7, curve: Curves.easeOut),
      ),
    );
    
    _fadeAnimation3 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOut),
      ),
    );
    
    // Start animation
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final orderData = widget.orderData ?? _defaultOrderData;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1A1C1D) : const Color(0xFFF8F9FA),
      body: Stack(
        children: [
          // Background pattern
          _buildBackgroundPattern(isDark),
          
          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Success Icon with Pulse Animation
                    _buildSuccessIcon(isDark),
                    
                    const SizedBox(height: 24),
                    
                    // Headline & Subtext
                    _buildHeadline(orderData, isDark),
                    
                    const SizedBox(height: 40),
                    
                    // Order Details Card
                    _buildOrderDetailsCard(orderData, isDark),
                    
                    const SizedBox(height: 40),
                    
                    // Action Buttons
                    _buildActionButtons(isDark),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BACKGROUND PATTERN
  // ============================================================
  Widget _buildBackgroundPattern(bool isDark) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              isDark 
                  ? const Color(0xFF1A1C1D) 
                  : const Color(0xFFF8F9FA),
              isDark 
                  ? const Color(0xFF2E3132) 
                  : const Color(0xFFF3F4F5),
            ],
          ),
        ),
        child: CustomPaint(
          painter: _TiletPatternPainter(
            color: isDark 
                ? const Color(0xFFE9C176).withValues(alpha: 0.03) 
                : const Color(0xFF775A19).withValues(alpha: 0.05),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // SUCCESS ICON
  // ============================================================
  Widget _buildSuccessIcon(bool isDark) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      child: Container(
        width: 128,
        height: 128,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19))
                  .withValues(alpha: 0.3),
              blurRadius: 24,
              spreadRadius: 8,
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Pulse ring
            TweenAnimationBuilder(
              duration: const Duration(seconds: 2),
              tween: Tween<double>(begin: 1.0, end: 1.5),
              builder: (context, value, child) {
                return Container(
                  width: 128 * value,
                  height: 128 * value,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19))
                          .withValues(alpha: 0.3 - (value - 1) * 0.6),
                      width: 2,
                    ),
                  ),
                );
              },
              onEnd: () {
                // Restart animation after completion
                if (mounted) {
                  setState(() {});
                }
              },
            ),
            
            // Main icon
            Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: isDark 
                    ? const Color(0xFFE9C176).withValues(alpha: 0.2) 
                    : const Color(0xFFC5A059).withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                size: 48,
                weight: 700,
              ),
            ),
          ],
        ),
      ),
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
    );
  }

  // ============================================================
  // HEADLINE
  // ============================================================
  Widget _buildHeadline(Map<String, dynamic> orderData, bool isDark) {
    return FadeTransition(
      opacity: _fadeAnimation1,
      child: Column(
        children: [
          Text(
            'Order Placed Successfully!',
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your order #${orderData['orderNumber']} is being prepared.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 16,
              color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER DETAILS CARD
  // ============================================================
  Widget _buildOrderDetailsCard(Map<String, dynamic> orderData, bool isDark) {
    return FadeTransition(
      opacity: _fadeAnimation2,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF2E3132) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark 
                ? const Color(0xFF3E4142) 
                : const Color(0xFFE1E3E4),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            // Total
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                  ),
                ),
                Text(
                  'ETB ${orderData['total'].toStringAsFixed(2)}',
                  style: GoogleFonts.montserrat(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xFF191C1D),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Divider
            Container(
              height: 1,
              color: isDark 
                  ? const Color(0xFF3E4142) 
                  : const Color(0xFFE1E3E4),
            ),
            
            const SizedBox(height: 16),
            
            // Estimated Delivery
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isDark 
                        ? const Color(0xFF3E4142) 
                        : const Color(0xFFF3F4F5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.local_shipping,
                    color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Estimated Delivery',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : const Color(0xFF191C1D),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        orderData['estimatedDelivery'],
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // ACTION BUTTONS
  // ============================================================
  Widget _buildActionButtons(bool isDark) {
    return FadeTransition(
      opacity: _fadeAnimation3,
      child: Column(
        children: [
          // Track Order Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton.icon(
              onPressed: () {
                // Navigate to order tracking
                _showOrderTrackingDialog(isDark);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                foregroundColor: isDark ? const Color(0xFF191C1D) : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 8,
                shadowColor: (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19))
                    .withValues(alpha: 0.2),
              ),
              icon: const Icon(Icons.arrow_forward, size: 20),
              label: Text(
                'Track My Order',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFF191C1D) : Colors.white,
                ),
              ),
              iconAlignment: IconAlignment.end,
            ),
          ),
          
          const SizedBox(height: 12),
          
          // Continue Shopping Button
          SizedBox(
            width: double.infinity,
            height: 48,
            child: OutlinedButton(
              onPressed: () {
                // Navigate back to home
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                side: BorderSide(
                  color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Continue Shopping',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ORDER TRACKING DIALOG
  // ============================================================
  void _showOrderTrackingDialog(bool isDark) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? const Color(0xFF2E3132) : Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Text(
          'Order Tracking',
          style: GoogleFonts.montserrat(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: isDark ? Colors.white : const Color(0xFF191C1D),
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTrackingStep('Order Confirmed', true, isDark),
            _buildTrackingStep('Being Prepared', true, isDark),
            _buildTrackingStep('Out for Delivery', false, isDark),
            _buildTrackingStep('Delivered', false, isDark),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(
                color: isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingStep(String label, bool isComplete, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isComplete
                  ? (isDark ? const Color(0xFFE9C176) : const Color(0xFF775A19))
                  : (isDark ? const Color(0xFF3E4142) : const Color(0xFFE1E3E4)),
            ),
            child: isComplete
                ? Icon(
                    Icons.check,
                    color: isDark ? const Color(0xFF191C1D) : Colors.white,
                    size: 16,
                  )
                : null,
          ),
          const SizedBox(width: 12),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: isComplete ? FontWeight.w600 : FontWeight.w400,
              color: isComplete
                  ? (isDark ? Colors.white : const Color(0xFF191C1D))
                  : (isDark ? const Color(0xFFB0B0B0) : const Color(0xFF4E4639)),
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// TILET PATTERN PAINTER
// ============================================================
class _TiletPatternPainter extends CustomPainter {
  final Color color;

  _TiletPatternPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
    
    const spacing = 16.0;
    const dotSize = 2.0;
    
    for (double x = 0; x < size.width; x += spacing) {
      for (double y = 0; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), dotSize, paint);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

// ============================================================
// NAVIGATION EXAMPLE - HOW TO USE
// ============================================================
/*
// Navigate to order success page after successful payment:
Navigator.pushReplacement(
  context,
  MaterialPageRoute(
    builder: (_) => OrderSuccessPage(
      orderData: {
        'orderNumber': 'HM-8921',
        'total': 8170.75,
        'estimatedDelivery': 'Today, 1:30 PM',
        'items': 3,
      },
    ),
  ),
);

// Or from checkout page after payment:
void _processPayment() async {
  // Process payment logic...
  
  // On success:
  if (mounted) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => OrderSuccessPage(
          orderData: orderData,
        ),
      ),
    );
  }
}
*/