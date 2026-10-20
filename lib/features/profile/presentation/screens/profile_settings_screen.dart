import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class ProfileSettingsScreen extends StatefulWidget {
  final VoidCallback? onBackToHome;

  const ProfileSettingsScreen({
    super.key,
    this.onBackToHome,
  });

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  bool _pushNotifications = true;
  bool _expiryReminders = true;
  bool _lowStockAlerts = true;

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
              // Top AppBar
              Row(
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
                      Icons.arrow_back_ios_new_rounded,
                      size: 18,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Profile & Settings',
                        style: AppTextStyles.h2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 10),

              // Main White Container Card (Matches Image Layout)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // User Profile Header Tile
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(14),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 24,
                              backgroundColor:
                              const Color(0xFF43A047).withValues(alpha: 0.18),
                              child: const Icon(
                                Icons.person_3_rounded,
                                size: 28,
                                color: Color(0xFF2E7D32),
                              ),
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Ahmed',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.textPrimary,
                                    ),
                                  ),
                                  SizedBox(height: 2),
                                  Text(
                                    'ahmed@example.com',
                                    style: TextStyle(
                                      fontSize: 12.5,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textHint,
                              size: 22,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 18),

                    // Section 1: Home & Members
                    const _SectionHeader('Home & Members'),
                    const SizedBox(height: 8),
                    _SettingsNavRow(
                      icon: Icons.home_outlined,
                      title: 'My Home',
                      subtitle: 'Family Home',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.inviteMembers);
                      },
                    ),
                    const Divider(color: AppColors.divider, height: 16),
                    _SettingsNavRow(
                      icon: Icons.people_outline_rounded,
                      title: 'Manage Members',
                      subtitle: '4 members',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.familyMembers);
                      },
                    ),
                    const SizedBox(height: 18),

                    // Section 2: Notifications
                    const _SectionHeader('Notifications'),
                    const SizedBox(height: 6),
                    _SettingsToggleRow(
                      icon: Icons.notifications_none_rounded,
                      title: 'Push Notifications',
                      value: _pushNotifications,
                      onChanged: (v) => setState(() => _pushNotifications = v),
                    ),
                    const Divider(color: AppColors.divider, height: 12),
                    _SettingsToggleRow(
                      icon: Icons.access_time_rounded,
                      title: 'Expiry Reminders',
                      value: _expiryReminders,
                      onChanged: (v) => setState(() => _expiryReminders = v),
                    ),
                    const Divider(color: AppColors.divider, height: 12),
                    _SettingsToggleRow(
                      icon: Icons.inventory_2_outlined,
                      title: 'Low Stock Alerts',
                      value: _lowStockAlerts,
                      onChanged: (v) => setState(() => _lowStockAlerts = v),
                    ),
                    const SizedBox(height: 18),

                    // Section 3: App
                    const _SectionHeader('App'),
                    const SizedBox(height: 8),
                    InkWell(
                      onTap: () {},
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.language_rounded,
                              size: 20,
                              color: AppColors.textPrimary,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Language',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ),
                            Text(
                              'English',
                              style: TextStyle(
                                fontSize: 13,
                                color: AppColors.textSecondary,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(
                              Icons.chevron_right_rounded,
                              color: AppColors.textHint,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(color: AppColors.divider, height: 16),

                    // Logout Row inside Card
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouter.login,
                              (route) => false,
                        );
                      },
                      borderRadius: BorderRadius.circular(10),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.logout_rounded,
                              size: 20,
                              color: AppColors.danger,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: AppColors.danger,
                              ),
                            ),
                          ],
                        ),
                      ),
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

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 13.5,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      ),
    );
  }
}

class _SettingsNavRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _SettingsNavRow({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.textPrimary),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
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
        ),
      ),
    );
  }
}

class _SettingsToggleRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsToggleRow({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textPrimary),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        Transform.scale(
          scale: 0.82,
          child: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: AppColors.primary,
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: AppColors.border,
          ),
        ),
      ],
    );
  }
}