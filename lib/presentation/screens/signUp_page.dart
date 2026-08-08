import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_navigation_page.dart';
class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
  // Form controllers
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _identityController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  // Password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  
  // Terms agreement
  bool _agreeToTerms = false;
  
  // Loading state
  bool _isLoading = false;

  // Color scheme matching the HTML
  static const Color primaryColor = Color(0xFF775A19);
  static const Color primaryContainer = Color(0xFFC5A059);
  static const Color backgroundColor = Color(0xFFF8F9FA);
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color textColor = Color(0xFF191C1D);
  static const Color mutedColor = Color(0xFF4E4639);
  static const Color outlineColor = Color(0xFF7F7667);
  static const Color outlineVariant = Color(0xFFD1C5B4);
  static const Color surfaceContainerLow = Color(0xFFF3F4F5);

  @override
  void dispose() {
    _fullNameController.dispose();
    _identityController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body: Stack(
        children: [
          // Background decorative elements
          _buildBackgroundDecorations(),
          
          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: outlineVariant.withValues(alpha: 0.3),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Logo & Header
                        _buildHeader(),
                        
                        const SizedBox(height: 24),
                        
                        // Full Name Field
                        _buildFullNameField(),
                        
                        const SizedBox(height: 16),
                        
                        // Email/Phone Field
                        _buildIdentityField(),
                        
                        const SizedBox(height: 16),
                        
                        // Password Field
                        _buildPasswordField(),
                        
                        const SizedBox(height: 16),
                        
                        // Confirm Password Field
                        _buildConfirmPasswordField(),
                        
                        const SizedBox(height: 16),
                        
                        // Terms and Conditions
                        _buildTermsCheckbox(),
                        
                        const SizedBox(height: 20),
                        
                        // Sign Up Button
                        _buildSignUpButton(),
                        
                        const SizedBox(height: 24),
                        
                        // Social Divider
                        _buildSocialDivider(),
                        
                        const SizedBox(height: 16),
                        
                        // Social Sign-up Buttons
                        _buildSocialButtons(),
                        
                        const SizedBox(height: 20),
                        
                        // Footer Link
                        _buildFooterLink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // BACKGROUND DECORATIONS
  // ============================================================
  Widget _buildBackgroundDecorations() {
    return Stack(
      children: [
        // Tilet pattern (subtle dot pattern) - using CustomPaint
        CustomPaint(
          painter: _TiletPatternPainter(),
          size: Size.infinite,
        ),
        // Decorative circles
        Positioned(
          top: -96,
          right: -96,
          child: Container(
            width: 384,
            height: 384,
            decoration: BoxDecoration(
              color: const Color(0xFFFFDEA5).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -96,
          left: -96,
          child: Container(
            width: 384,
            height: 384,
            decoration: BoxDecoration(
              color: const Color(0xFFFE6D63).withValues(alpha: 0.05),
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // HEADER
  // ============================================================
  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: primaryContainer.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
                          Icons.shopping_basket_rounded,
                          size: 38,
                          color: Color(0xFF775A19),
                        ),
        ),
        const SizedBox(height: 12),
        Text(
          'Habesha Mart',
          style: GoogleFonts.montserrat(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: primaryColor,
            letterSpacing: -0.5,
          ),
        ),
        Text(
          'Join our heritage community',
          style: GoogleFonts.inter(
            fontSize: 16,
            color: mutedColor,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // FULL NAME FIELD
  // ============================================================
  Widget _buildFullNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Full Name',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: _fullNameController,
          style: GoogleFonts.inter(fontSize: 16),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.person_outline,
              color: outlineColor,
              size: 20,
            ),
            hintText: 'Abebe Bikila',
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              color: outlineColor,
            ),
            filled: true,
            fillColor: surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: outlineVariant,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your full name';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ============================================================
  // IDENTITY FIELD (Email/Phone)
  // ============================================================
  Widget _buildIdentityField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email or Phone Number',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: _identityController,
          style: GoogleFonts.inter(fontSize: 16),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.alternate_email,
              color: outlineColor,
              size: 20,
            ),
            hintText: 'example@email.com or +251...',
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              color: outlineColor,
            ),
            filled: true,
            fillColor: surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: outlineVariant,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email or phone number';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ============================================================
  // PASSWORD FIELD
  // ============================================================
  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: _passwordController,
          style: GoogleFonts.inter(fontSize: 16),
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock_outline,
              color: outlineColor,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
              icon: Icon(
                _obscurePassword ? Icons.visibility : Icons.visibility_off,
                color: outlineColor,
                size: 20,
              ),
            ),
            hintText: '••••••••',
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              color: outlineColor,
            ),
            filled: true,
            fillColor: surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: outlineVariant,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ============================================================
  // CONFIRM PASSWORD FIELD
  // ============================================================
  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: textColor,
          ),
        ),
        const SizedBox(height: 4),
        TextFormField(
          controller: _confirmPasswordController,
          style: GoogleFonts.inter(fontSize: 16),
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.format_align_left,
              color: outlineColor,
              size: 20,
            ),
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
              icon: Icon(
                _obscureConfirmPassword ? Icons.visibility : Icons.visibility_off,
                color: outlineColor,
                size: 20,
              ),
            ),
            hintText: '••••••••',
            hintStyle: GoogleFonts.inter(
              fontSize: 16,
              color: outlineColor,
            ),
            filled: true,
            fillColor: surfaceContainerLow,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: outlineVariant,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: primaryColor,
                width: 2,
              ),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 12,
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != _passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }

  // ============================================================
  // TERMS CHECKBOX
  // ============================================================
  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 24,
          width: 24,
          child: Checkbox(
            value: _agreeToTerms,
            onChanged: (value) {
              setState(() {
                _agreeToTerms = value ?? false;
              });
            },
            activeColor: primaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            side: BorderSide(
              color: outlineVariant,
              width: 2,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: RichText(
            text: TextSpan(
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: mutedColor,
              ),
              children: [
                const TextSpan(text: 'I agree to the '),
                TextSpan(
                  text: 'Terms of Service',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                  text: 'Privacy Policy',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                    decoration: TextDecoration.underline,
                  ),
                ),
                const TextSpan(text: ' of Habesha Mart.'),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SIGN UP BUTTON
  // ============================================================
  Widget _buildSignUpButton() {
    return ElevatedButton(
      onPressed: _isLoading ? null : _handleSignUp,
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 8,
        shadowColor: primaryColor.withValues(alpha: 0.3),
        disabledBackgroundColor: primaryColor.withValues(alpha: 0.6),
      ),
      child: _isLoading
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
                Text(
                  'Create Account',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ],
            ),
    );
  }

  // ============================================================
  // SOCIAL DIVIDER
  // ============================================================
  Widget _buildSocialDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'or sign up with',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: outlineColor,
              letterSpacing: 1.2,
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: outlineVariant.withValues(alpha: 0.5),
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SOCIAL BUTTONS
  // ============================================================
  Widget _buildSocialButtons() {
    return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 22,
                                height: 22,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: const Center(
                                  child: Text(
                                    'G',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                'Continue with Google',
                                style: GoogleFonts.inter(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF191C1D),
                                ),
                              ),
                            ],
                          );
                        
  }

  // ============================================================
  // FOOTER LINK
  // ============================================================
  Widget _buildFooterLink() {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: outlineVariant.withValues(alpha: 0.3),
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Already have an account?',
            style: GoogleFonts.inter(
              fontSize: 16,
              color: mutedColor,
            ),
          ),
          TextButton(
            onPressed: () {
              // Navigate to sign in
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(
              foregroundColor: primaryColor,
              padding: const EdgeInsets.symmetric(horizontal: 8),
            ),
            child: Text(
              'Sign In',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: primaryColor,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // HANDLE SIGN UP
  // ============================================================
  void _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms of Service and Privacy Policy'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Implement actual sign up logic with API
      // For now, simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
     if (mounted) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Account created successfully!'),
      backgroundColor: Colors.green,
    ),
  );

  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (_) => const MainNavigationPage(),
    ),
    (route) => false,
  );
}
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${e.toString()}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }
}

// ============================================================
// TILET PATTERN PAINTER
// ============================================================
class _TiletPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF775A19).withValues(alpha: 0.1)
      ..style = PaintingStyle.fill;
    
    const spacing = 16.0;
    const dotSize = 1.0;
    
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