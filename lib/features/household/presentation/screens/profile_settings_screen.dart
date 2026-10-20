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
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor:
                      AppColors.primary.withValues(alpha: 0.15),
                      child: const Icon(
                        Icons.person_rounded,
                        size: 28,
                        color: AppColors.primary,
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
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const _SectionHeader('Home & Members'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _SettingsNavTile(
                      icon: Icons.home_outlined,
                      title: 'My Home',
                      subtitle: 'Family Home',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.inviteMembers);
                      },
                    ),
                    const Divider(color: AppColors.divider, height: 1),
                    _SettingsNavTile(
                      icon: Icons.person_add_alt_1_outlined,
                      title: 'Manage Members',
                      subtitle: '4 members',
                      onTap: () {
                        Navigator.pushNamed(context, AppRouter.familyMembers);
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const _SectionHeader('Notifications'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _SettingsSwitchTile(
                      icon: Icons.notifications_none_rounded,
                      title: 'Push Notifications',
                      value: _pushNotifications,
                      onChanged: (val) =>
                          setState(() => _pushNotifications = val),
                    ),
                    const Divider(color: AppColors.divider, height: 1),
                    _SettingsSwitchTile(
                      icon: Icons.access_time_rounded,
                      title: 'Expiry Reminders',
                      value: _expiryReminders,
                      onChanged: (val) =>
                          setState(() => _expiryReminders = val),
                    ),
                    const Divider(color: AppColors.divider, height: 1),
                    _SettingsSwitchTile(
                      icon: Icons.inventory_2_outlined,
                      title: 'Low Stock Alerts',
                      value: _lowStockAlerts,
                      onChanged: (val) => setState(() => _lowStockAlerts = val),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              const _SectionHeader('App'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Column(
                  children: [
                    _SettingsNavTile(
                      icon: Icons.language_rounded,
                      title: 'Language',
                      trailingText: 'English',
                      onTap: () {},
                    ),
                    const Divider(color: AppColors.divider, height: 1),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRouter.login,
                              (route) => false,
                        );
                      },
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(18),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Row(
                          children: const [
                            Icon(
                              Icons.logout_rounded,
                              color: AppColors.danger,
                              size: 20,
                            ),
                            SizedBox(width: 12),
                            Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 14,
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
              const SizedBox(height: 16),
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
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }
}

class _SettingsNavTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final String? trailingText;
  final VoidCallback onTap;

  const _SettingsNavTile({
    required this.icon,
    required this.title,
    this.subtitle,
    this.trailingText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
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
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (trailingText != null) ...[
              Text(
                trailingText!,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 4),
            ],
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

class _SettingsSwitchTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  const _SettingsSwitchTile({
    required this.icon,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 22),
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeThumbColor: Colors.white,
            activeTrackColor: AppColors.primary,
          ),
        ],
      ),
    );
  }
}