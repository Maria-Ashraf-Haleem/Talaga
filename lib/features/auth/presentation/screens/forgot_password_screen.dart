import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/auth_repository.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _sendResetLink() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter your email address first.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    setState(() => _isLoading = true);
    try {
      await AuthRepository.instance.sendPasswordResetEmail(email);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Reset link sent to your email!'),
          backgroundColor: AppColors.primary,
        ),
      );
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AuthRepository.getReadableErrorMessage(e)),
          backgroundColor: Colors.redAccent,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Paper Plane Illustration Circle
              Container(
                width: 96,
                height: 96,
                decoration: const BoxDecoration(
                  color: AppColors.softGreenBg,
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      bottom: 22,
                      left: 22,
                      child: Icon(
                        Icons.more_horiz_rounded,
                        color: AppColors.primaryLight.withValues(alpha: 0.45),
                        size: 26,
                      ),
                    ),
                    Transform.rotate(
                      angle: -0.35,
                      child: const Icon(
                        Icons.send_rounded,
                        size: 44,
                        color: AppColors.primaryLight,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),
              const Text('Forgot Password', style: AppTextStyles.h1),
              const SizedBox(height: 8),
              const Text(
                'Enter your email to receive a reset link',
                textAlign: TextAlign.center,
                style: AppTextStyles.subtitle,
              ),
              const SizedBox(height: 28),

              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Email',
                      prefixIcon: Icons.mail_outline_rounded,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    const SizedBox(height: 18),
                    _isLoading
                        ? const CircularProgressIndicator()
                        : PrimaryButton(
                      text: 'Send Reset Link',
                      onPressed: _sendResetLink,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}