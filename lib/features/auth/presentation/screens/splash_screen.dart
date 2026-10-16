import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/talaga_logo.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRouter.login);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F1EC),
      body: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, AppRouter.login),
        child: Stack(
          children: [
            // Top-Left Leaf & Tomato Decoration
            Positioned(
              top: -20,
              left: -25,
              child: _FoodCircleDecor(
                size: 130,
                color: const Color(0xFF2E7D32).withValues(alpha: 0.15),
                icon: Icons.eco_rounded,
                iconColor: const Color(0xFF2E7D32),
                iconSize: 64,
              ),
            ),
            Positioned(
              top: 95,
              left: -18,
              child: _FoodCircleDecor(
                size: 85,
                color: const Color(0xFFD32F2F).withValues(alpha: 0.15),
                icon: Icons.circle,
                iconColor: const Color(0xFFD32F2F),
                iconSize: 55,
              ),
            ),

            // Top-Right Herbs & Lemon Decoration
            Positioned(
              top: 40,
              right: 30,
              child: Icon(
                Icons.spa_rounded,
                color: const Color(0xFF388E3C).withValues(alpha: 0.75),
                size: 38,
              ),
            ),
            Positioned(
              top: 170,
              right: -25,
              child: _FoodCircleDecor(
                size: 85,
                color: const Color(0xFFFBC02D).withValues(alpha: 0.22),
                icon: Icons.brightness_1,
                iconColor: const Color(0xFFFBC02D),
                iconSize: 55,
              ),
            ),

            // Bottom-Left Red Pepper & Broccoli Decoration
            Positioned(
              bottom: 150,
              left: -25,
              child: _FoodCircleDecor(
                size: 85,
                color: const Color(0xFFC62828).withValues(alpha: 0.16),
                icon: Icons.local_florist_rounded,
                iconColor: const Color(0xFFC62828),
                iconSize: 48,
              ),
            ),
            Positioned(
              bottom: -20,
              left: -15,
              child: _FoodCircleDecor(
                size: 115,
                color: const Color(0xFF388E3C).withValues(alpha: 0.18),
                icon: Icons.park_rounded,
                iconColor: const Color(0xFF2E7D32),
                iconSize: 56,
              ),
            ),

            // Bottom-Right Broccoli & Orange Slice Decoration
            Positioned(
              bottom: 90,
              right: 12,
              child: _FoodCircleDecor(
                size: 95,
                color: const Color(0xFF1B5E20).withValues(alpha: 0.18),
                icon: Icons.forest_rounded,
                iconColor: const Color(0xFF1B5E20),
                iconSize: 50,
              ),
            ),
            Positioned(
              bottom: -25,
              right: -15,
              child: _FoodCircleDecor(
                size: 100,
                color: const Color(0xFFFB8C00).withValues(alpha: 0.22),
                icon: Icons.pie_chart_rounded,
                iconColor: const Color(0xFFFB8C00),
                iconSize: 58,
              ),
            ),

            // Center Logo & Tagline
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const TalagaLogo(
                    iconSize: 92,
                    fontSize: 38,
                  ),
                  const SizedBox(height: 14),
                  const Text(
                    'Manage your fridge\nTogether',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textPrimary,
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            // Bottom Progress Indicator Bar (Matches Image)
            Positioned(
              bottom: 42,
              left: 0,
              right: 0,
              child: Center(
                child: SizedBox(
                  width: 90,
                  child: Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        height: 3,
                        width: 90,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        height: 3,
                        width: 32,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Positioned(
                        left: 28,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppColors.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
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

class _FoodCircleDecor extends StatelessWidget {
  final double size;
  final Color color;
  final IconData icon;
  final Color iconColor;
  final double iconSize;

  const _FoodCircleDecor({
    required this.size,
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.iconSize,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}