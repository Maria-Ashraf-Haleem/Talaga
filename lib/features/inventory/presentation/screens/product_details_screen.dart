import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../domain/models/product_item.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductItem product;

  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            children: [
              // Top AppBar
              Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        product.name,
                        style: AppTextStyles.h2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 14),

              // Main Details Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    // Product Illustration Image Header
                    Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: product.bgColor.withValues(alpha: 0.45),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Center(
                        child: Text(
                          product.emoji,
                          style: const TextStyle(fontSize: 78),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),

                    _DetailInfoRow(
                      icon: Icons.local_offer_outlined,
                      label: 'Category',
                      value: product.category,
                    ),
                    const Divider(color: AppColors.divider, height: 22),

                    _DetailInfoRow(
                      icon: Icons.scale_outlined,
                      label: 'Quantity',
                      value: product.fullQuantity,
                    ),
                    const Divider(color: AppColors.divider, height: 22),

                    _DetailInfoRow(
                      icon: Icons.inventory_2_outlined,
                      label: 'Minimum Quantity',
                      value: product.minQuantity,
                    ),
                    const Divider(color: AppColors.divider, height: 22),

                    _DetailInfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Expiry Date',
                      value: product.expiryDateFormatted,
                      valueColor: AppColors.expiring,
                    ),
                    const Divider(color: AppColors.divider, height: 22),

                    _DetailInfoRow(
                      icon: Icons.notes_rounded,
                      label: 'Notes',
                      value: product.notes,
                    ),
                    const SizedBox(height: 28),

                    // Edit & Delete Buttons Row
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.addEditProduct,
                                  arguments: product,
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.softGreenBg,
                                foregroundColor: AppColors.primary,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Edit',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: SizedBox(
                            height: 46,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('${product.name} deleted'),
                                    backgroundColor: AppColors.danger,
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEF5350),
                                foregroundColor: Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: const Text(
                                'Delete',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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

class _DetailInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const _DetailInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          size: 18,
          color: AppColors.textHint,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                value,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: valueColor ?? AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}