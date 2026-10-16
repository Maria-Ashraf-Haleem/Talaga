import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../core/widgets/primary_button.dart';

class HomeDashboardScreen extends StatelessWidget {
  final ValueChanged<int>? onSwitchTab;
  final VoidCallback? onAddItemTap;

  const HomeDashboardScreen({
    super.key,
    this.onSwitchTab,
    this.onAddItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: Good Morning Ahmed + Notification Bell
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Good Morning',
                        style: TextStyle(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: const [
                          Text(
                            'Ahmed',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 6),
                          Text(
                            '👋',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () => onSwitchTab?.call(3), // Go to Alerts tab
                    borderRadius: BorderRadius.circular(24),
                    child: Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Icon(
                        Icons.notifications_none_rounded,
                        color: AppColors.textPrimary,
                        size: 22,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Main Dashboard White Card Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Row 1: Total Items & Low Stock
                    Row(
                      children: [
                        Expanded(
                          child: _SummaryStatCard(
                            title: 'Total Items',
                            count: '24',
                            countColor: AppColors.primary,
                            bgColor: const Color(0xFFF3F8F5),
                            iconBgColor: AppColors.softGreenBg,
                            icon: Icons.inventory_2_rounded,
                            iconColor: AppColors.primary,
                            onTap: () => onSwitchTab?.call(1), // Inventory Tab
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryStatCard(
                            title: 'Low Stock',
                            count: '5',
                            countColor: const Color(0xFFD97706),
                            bgColor: const Color(0xFFFFFBEB),
                            iconBgColor: const Color(0xFFFEF3C7),
                            icon: Icons.warning_amber_rounded,
                            iconColor: const Color(0xFFF59E0B),
                            onTap: () => onSwitchTab?.call(3), // Alerts Tab
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),

                    // Row 2: Expiring Soon & Expired Items
                    Row(
                      children: [
                        Expanded(
                          child: _SummaryStatCard(
                            title: 'Expiring Soon',
                            count: '3',
                            countColor: const Color(0xFFEA580C),
                            bgColor: const Color(0xFFFFF7ED),
                            iconBgColor: const Color(0xFFFFEDD5),
                            icon: Icons.event_busy_rounded,
                            iconColor: const Color(0xFFF97316),
                            onTap: () => onSwitchTab?.call(3), // Alerts Tab
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _SummaryStatCard(
                            title: 'Expired Items',
                            count: '1',
                            countColor: const Color(0xFFDC2626),
                            bgColor: const Color(0xFFFEF2F2),
                            iconBgColor: const Color(0xFFFEE2E2),
                            icon: Icons.error_outline_rounded,
                            iconColor: const Color(0xFFEF4444),
                            onTap: () => onSwitchTab?.call(3), // Alerts Tab
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Shopping List Wide Card
                    InkWell(
                      onTap: () => onSwitchTab?.call(2), // Shopping Tab
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 16,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Shopping List',
                                  style: TextStyle(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                SizedBox(height: 6),
                                Text(
                                  '7',
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.w800,
                                    color: Color(0xFF1D4ED8),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 46,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFFDBEAFE),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.shopping_cart_rounded,
                                color: Color(0xFF2563EB),
                                size: 26,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // + Add Item Button
                    PrimaryButton(
                      text: 'Add Item',
                      icon: Icons.add_rounded,
                      onPressed: () {
                        if (onAddItemTap != null) {
                          onAddItemTap!();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Add Product Screen will be added in Batch 4!',
                              ),
                              backgroundColor: AppColors.primary,
                            ),
                          );
                        }
                      },
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

class _SummaryStatCard extends StatelessWidget {
  final String title;
  final String count;
  final Color countColor;
  final Color bgColor;
  final Color iconBgColor;
  final IconData icon;
  final Color iconColor;
  final VoidCallback onTap;

  const _SummaryStatCard({
    required this.title,
    required this.count,
    required this.countColor,
    required this.bgColor,
    required this.iconBgColor,
    required this.icon,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 12.5,
                fontWeight: FontWeight.w600,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  count,
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: countColor,
                  ),
                ),
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: iconColor,
                    size: 20,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}