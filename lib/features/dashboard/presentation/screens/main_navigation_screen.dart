import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import 'home_dashboard_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  final int initialIndex;

  const MainNavigationScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _switchTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> tabs = [
      HomeDashboardScreen(
        onSwitchTab: _switchTab,
      ),
      _ComingSoonTabPlaceholder(
        title: 'Fridge Inventory',
        subtitle: 'سيتم إضافة شاشات المخزون الأربعة في الدفعة الرابعة (04)',
        icon: Icons.kitchen_rounded,
        onBackToHome: () => _switchTab(0),
      ),
      _ComingSoonTabPlaceholder(
        title: 'Shopping List',
        subtitle: 'سيتم إضافة شاشة المشتريات في الدفعة الخامسة (05)',
        icon: Icons.shopping_cart_outlined,
        onBackToHome: () => _switchTab(0),
      ),
      _ComingSoonTabPlaceholder(
        title: 'Alerts & Activity',
        subtitle: 'سيتم إضافة شاشة التنبيهات والنشاط في الدفعة الخامسة (06)',
        icon: Icons.notifications_none_rounded,
        onBackToHome: () => _switchTab(0),
      ),
      _ComingSoonTabPlaceholder(
        title: 'Profile & Settings',
        subtitle: 'سيتم إضافة شاشة الإعدادات في الدفعة الخامسة (07)',
        icon: Icons.more_horiz_rounded,
        onBackToHome: () => _switchTab(0),
        extraActionText: 'Open Family Members',
        onExtraAction: () =>
            Navigator.pushNamed(context, AppRouter.familyMembers),
      ),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: tabs,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _switchTab,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          elevation: 0,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textHint,
          selectedLabelStyle: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w700,
          ),
          unselectedLabelStyle: const TextStyle(
            fontSize: 11.5,
            fontWeight: FontWeight.w500,
          ),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              activeIcon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.inventory_2_outlined),
              activeIcon: Icon(Icons.inventory_2_rounded),
              label: 'Inventory',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart_outlined),
              activeIcon: Icon(Icons.shopping_cart_rounded),
              label: 'Shopping',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.notifications_none_rounded),
              activeIcon: Icon(Icons.notifications_rounded),
              label: 'Alerts',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.more_horiz_rounded),
              activeIcon: Icon(Icons.more_horiz_rounded),
              label: 'More',
            ),
          ],
        ),
      ),
    );
  }
}

class _ComingSoonTabPlaceholder extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onBackToHome;
  final String? extraActionText;
  final VoidCallback? onExtraAction;

  const _ComingSoonTabPlaceholder({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onBackToHome,
    this.extraActionText,
    this.onExtraAction,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: const BoxDecoration(
                  color: AppColors.softGreenBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 36, color: AppColors.primary),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 13.5,
                  color: AppColors.textSecondary,
                ),
              ),
              if (extraActionText != null && onExtraAction != null) ...[
                const SizedBox(height: 16),
                TextButton(
                  onPressed: onExtraAction,
                  child: Text(extraActionText!),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}