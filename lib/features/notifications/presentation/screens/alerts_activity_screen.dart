import 'package:flutter/material.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class AlertsActivityScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const AlertsActivityScreen({
    super.key,
    this.onBackToHome,
  });

  @override
  State<AlertsActivityScreen> createState() => _AlertsActivityScreenState();
}

class _AlertsActivityScreenState extends State<AlertsActivityScreen> {
  String _selectedFilter = 'All';

  final List<String> _filters = const [
    'All',
    'Low Stock',
    'Expiring',
    'Expired',
  ];

  final List<_AlertItemData> _allAlerts = const [
    _AlertItemData(
      category: 'Low Stock',
      title: 'Low stock',
      line1: 'Milk is running low',
      line2: 'Only 1 left',
      timeAgo: '2 hours ago',
      icon: Icons.warning_amber_rounded,
      iconBoxColor: Color(0xFFF59E0B),
      cardBgColor: Color(0xFFFFFBEB),
    ),
    _AlertItemData(
      category: 'Expiring',
      title: 'Expiring Soon',
      line1: 'Cheese expires in 3 days',
      line2: 'Oct 18, 2026',
      timeAgo: '5 hours ago',
      icon: Icons.event_busy_rounded,
      iconBoxColor: Color(0xFFEA580C),
      cardBgColor: Color(0xFFFFF7ED),
    ),
    _AlertItemData(
      category: 'Expired',
      title: 'Expired Item',
      line1: 'Yogurt has expired',
      line2: 'Oct 10, 2026',
      timeAgo: '1 day ago',
      icon: Icons.error_outline_rounded,
      iconBoxColor: Color(0xFFDC2626),
      cardBgColor: Color(0xFFFEF2F2),
    ),
  ];

  List<_AlertItemData> get _filteredAlerts {
    if (_selectedFilter == 'All') return _allAlerts;
    return _allAlerts
        .where((alert) => alert.category == _selectedFilter)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      if (widget.onBackToHome != null) {
                        widget.onBackToHome!();
                      } else if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_back_rounded,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Text('Alerts', style: AppTextStyles.h2),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.tune_rounded,
                      size: 20,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _filters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    final isSelected = _selectedFilter == filter;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 7,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primary
                              : Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            filter,
                            style: TextStyle(
                              fontSize: 12.5,
                              fontWeight: FontWeight.w600,
                              color: isSelected
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              ..._filteredAlerts.map(
                    (alert) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.02),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            color: alert.iconBoxColor,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            alert.icon,
                            color: Colors.white,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                alert.title,
                                style: const TextStyle(
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                alert.line1,
                                style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text(
                                alert.line2,
                                style: const TextStyle(
                                  fontSize: 12.5,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                alert.timeAgo,
                                style: const TextStyle(
                                  fontSize: 11.5,
                                  color: AppColors.textHint,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(top: 14),
                          child: Icon(
                            Icons.chevron_right_rounded,
                            color: AppColors.textHint,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Recent Activity',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: const [
                    _ActivityTile(
                      userName: 'Ahmed',
                      actionText: ' added ',
                      itemName: 'Tomatoes',
                      suffixText: '',
                      timeAgo: '2 hours ago',
                      avatarColor: Color(0xFF43A047),
                      avatarIcon: Icons.person_3_rounded,
                    ),
                    Divider(color: AppColors.divider, height: 22),
                    _ActivityTile(
                      userName: 'Sara',
                      actionText: ' updated ',
                      itemName: 'Milk',
                      suffixText: ' quantity',
                      timeAgo: '5 hours ago',
                      avatarColor: Color(0xFFE53935),
                      avatarIcon: Icons.person_2_rounded,
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

class _AlertItemData {
  final String category;
  final String title;
  final String line1;
  final String line2;
  final String timeAgo;
  final IconData icon;
  final Color iconBoxColor;
  final Color cardBgColor;

  const _AlertItemData({
    required this.category,
    required this.title,
    required this.line1,
    required this.line2,
    required this.timeAgo,
    required this.icon,
    required this.iconBoxColor,
    required this.cardBgColor,
  });
}

class _ActivityTile extends StatelessWidget {
  final String userName;
  final String actionText;
  final String itemName;
  final String suffixText;
  final String timeAgo;
  final Color avatarColor;
  final IconData avatarIcon;

  const _ActivityTile({
    required this.userName,
    required this.actionText,
    required this.itemName,
    required this.suffixText,
    required this.timeAgo,
    required this.avatarColor,
    required this.avatarIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: avatarColor.withValues(alpha: 0.16),
          child: Icon(avatarIcon, color: avatarColor, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 13.5,
                    color: AppColors.textPrimary,
                  ),
                  children: [
                    TextSpan(
                      text: userName,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: actionText),
                    TextSpan(
                      text: itemName,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                    TextSpan(text: suffixText),
                  ],
                ),
              ),
              const SizedBox(height: 3),
              Text(
                timeAgo,
                style: const TextStyle(
                  fontSize: 11.5,
                  color: AppColors.textHint,
                ),
              ),
            ],
          ),
        ),
        const Icon(
          Icons.chevron_right_rounded,
          color: AppColors.textHint,
          size: 20,
        ),
      ],
    );
  }
}