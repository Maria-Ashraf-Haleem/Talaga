import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';

class FamilyMembersScreen extends StatelessWidget {
  const FamilyMembersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_MemberItem> members = [
      const _MemberItem(
        name: 'You',
        role: 'Owner',
        isOwner: true,
        avatarColor: Color(0xFF1E88E5),
        icon: Icons.person,
      ),
      const _MemberItem(
        name: 'Ahmed',
        role: 'Member',
        avatarColor: Color(0xFF43A047),
        icon: Icons.person_3_rounded,
      ),
      const _MemberItem(
        name: 'Sara',
        role: 'Member',
        avatarColor: Color(0xFFE53935),
        icon: Icons.person_2_rounded,
      ),
      const _MemberItem(
        name: 'Omar',
        role: 'Member',
        avatarColor: Color(0xFFFB8C00),
        icon: Icons.person_4_rounded,
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBg,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          child: Column(
            children: [
              // Custom AppBar
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
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Family Members',
                        style: AppTextStyles.h2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 40),
                ],
              ),
              const SizedBox(height: 18),

              // Members Card Container
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.85),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white),
                ),
                child: Column(
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: members.length,
                      separatorBuilder: (_, __) => const Divider(
                        color: AppColors.divider,
                        height: 20,
                      ),
                      itemBuilder: (context, index) {
                        final member = members[index];
                        return InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(12),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 22,
                                  backgroundColor: member.avatarColor
                                      .withValues(alpha: 0.18),
                                  child: Icon(
                                    member.icon,
                                    color: member.avatarColor,
                                    size: 24,
                                  ),
                                ),
                                const SizedBox(width: 14),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        member.name,
                                        style: const TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      if (member.isOwner)
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 10,
                                            vertical: 2.5,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.softGreenBg,
                                            borderRadius:
                                            BorderRadius.circular(6),
                                          ),
                                          child: Text(
                                            member.role,
                                            style: const TextStyle(
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              color: AppColors.primary,
                                            ),
                                          ),
                                        )
                                      else
                                        Text(
                                          member.role,
                                          style: const TextStyle(
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
                        );
                      },
                    ),
                    const SizedBox(height: 22),

                    // + Invite Member Button
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRouter.inviteMembers);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.softGreenBg,
                          foregroundColor: AppColors.primary,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        icon: const Icon(Icons.add_rounded, size: 20),
                        label: const Text(
                          'Invite Member',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: AppColors.primary,
                          ),
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

class _MemberItem {
  final String name;
  final String role;
  final bool isOwner;
  final Color avatarColor;
  final IconData icon;

  const _MemberItem({
    required this.name,
    required this.role,
    this.isOwner = false,
    required this.avatarColor,
    required this.icon,
  });
}