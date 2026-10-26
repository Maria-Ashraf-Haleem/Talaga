import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../../core/widgets/primary_button.dart';
import '../../data/household_repository.dart';

class InviteMembersScreen extends StatelessWidget {
  const InviteMembersScreen({super.key});

  void _copyToClipboard(BuildContext context, String text, String label) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label copied to clipboard!'),
        backgroundColor: AppColors.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: HouseholdRepository.instance.getCurrentHouseholdStream(),
          builder: (context, snapshot) {
            final data = snapshot.data?.data();
            final rawCode = (data?['inviteCode'] as String?) ?? '7K8M2P';
            final spacedCode = rawCode.split('').join(' ');
            final inviteLink = 'https://talaga.app/invite/$rawCode';

            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Top Bar with Back Button & Family Members shortcut
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          size: 18,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.familyMembers);
                        },
                        icon: const Icon(
                          Icons.people_outline_rounded,
                          size: 18,
                          color: AppColors.primary,
                        ),
                        label: const Text(
                          'Members',
                          style: AppTextStyles.link,
                        ),
                      ),
                    ],
                  ),

                  // Top Key & Sparkles Illustration
                  SizedBox(
                    height: 64,
                    width: 90,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Positioned(
                          right: 12,
                          top: 4,
                          child: Icon(
                            Icons.auto_awesome_rounded,
                            size: 22,
                            color: AppColors.accentGreen.withValues(alpha: 0.8),
                          ),
                        ),
                        Transform.rotate(
                          angle: -0.4,
                          child: const Icon(
                            Icons.vpn_key_rounded,
                            size: 46,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 10),
                  const Text('Invite Members', style: AppTextStyles.h1),
                  const SizedBox(height: 6),
                  const Text(
                    'Share this code with your family\nmembers to join your home',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.subtitle,
                  ),
                  const SizedBox(height: 22),

                  // Main Card
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.85),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.white),
                    ),
                    child: Column(
                      children: [
                        // Invite Code Box
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Center(
                            child: Text(
                              spacedCode,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 3,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Copy Code Soft Green Pill Button
                        InkWell(
                          onTap: () =>
                              _copyToClipboard(context, rawCode, 'Invite code'),
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.softGreenBg,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.copy_rounded,
                                  size: 16,
                                  color: AppColors.primary,
                                ),
                                SizedBox(width: 6),
                                Text(
                                  'Copy Code',
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        const SizedBox(height: 18),
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                color: AppColors.divider,
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.symmetric(horizontal: 12),
                              child: Text(
                                'or',
                                style: AppTextStyles.subtitle
                                    .copyWith(fontSize: 12),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                color: AppColors.divider,
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),

                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Share Invite Link',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),

                        // Invite Link Container
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.scaffoldBg,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  inviteLink,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 12.5,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              GestureDetector(
                                onTap: () => _copyToClipboard(
                                  context,
                                  inviteLink,
                                  'Invite link',
                                ),
                                child: const Icon(
                                  Icons.copy_rounded,
                                  size: 18,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Share Buttons Row
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _ShareOptionButton(
                              icon: Icons.phone_rounded,
                              label: 'WhatsApp',
                              bgColor: const Color(0xFF25D366),
                              iconColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.familyMembers,
                                );
                              },
                            ),
                            _ShareOptionButton(
                              icon: Icons.chat_bubble_rounded,
                              label: 'Messages',
                              bgColor: AppColors.primary,
                              iconColor: Colors.white,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.familyMembers,
                                );
                              },
                            ),
                            _ShareOptionButton(
                              icon: Icons.more_horiz_rounded,
                              label: 'More',
                              bgColor: AppColors.scaffoldBg,
                              iconColor: AppColors.textSecondary,
                              hasBorder: true,
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  AppRouter.familyMembers,
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),
                  PrimaryButton(
                    text: 'Continue to Home Dashboard',
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRouter.mainLayout,
                            (route) => false,
                      );
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ShareOptionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color bgColor;
  final Color iconColor;
  final bool hasBorder;
  final VoidCallback onTap;

  const _ShareOptionButton({
    required this.icon,
    required this.label,
    required this.bgColor,
    required this.iconColor,
    this.hasBorder = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: bgColor,
              shape: BoxShape.circle,
              border: hasBorder ? Border.all(color: AppColors.border) : null,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(height: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 11.5,
              fontWeight: FontWeight.w500,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}