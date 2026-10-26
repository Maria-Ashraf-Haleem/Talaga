import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../../app/router.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_text_styles.dart';
import '../../../auth/data/auth_repository.dart';
import '../../data/household_repository.dart';

class FamilyMembersScreen extends StatelessWidget {
  const FamilyMembersScreen({super.key});

  static const List<Color> _avatarColors = [
    Color(0xFF1E88E5),
    Color(0xFF43A047),
    Color(0xFFE53935),
    Color(0xFFFB8C00),
    Color(0xFF8E24AA),
  ];

  @override
  Widget build(BuildContext context) {
    final currentUid = AuthRepository.instance.currentUserId;

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
                    StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                      stream: HouseholdRepository.instance
                          .getCurrentHouseholdStream(),
                      builder: (context, homeSnap) {
                        final ownerId = homeSnap.data?.data()?['ownerId'];

                        return StreamBuilder<
                            QuerySnapshot<Map<String, dynamic>>>(
                          stream: HouseholdRepository.instance
                              .getHouseholdMembersStream(),
                          builder: (context, membersSnap) {
                            if (membersSnap.connectionState ==
                                ConnectionState.waiting) {
                              return const Padding(
                                padding: EdgeInsets.all(20),
                                child:
                                Center(child: CircularProgressIndicator()),
                              );
                            }

                            final docs = membersSnap.data?.docs ?? [];
                            if (docs.isEmpty) {
                              return const Padding(
                                padding: EdgeInsets.all(16),
                                child: Text('No members found in this home.'),
                              );
                            }

                            return ListView.separated(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: docs.length,
                              separatorBuilder: (_, __) => const Divider(
                                color: AppColors.divider,
                                height: 20,
                              ),
                              itemBuilder: (context, index) {
                                final data = docs[index].data();
                                final uid = data['uid'] as String? ?? '';
                                final rawName =
                                    data['name'] as String? ?? 'Member';
                                final isMe = uid == currentUid;
                                final isOwner =
                                    uid == ownerId || (ownerId == null && isMe);
                                final displayName =
                                isMe ? '$rawName (You)' : rawName;
                                final color =
                                _avatarColors[index % _avatarColors.length];

                                return Padding(
                                  padding:
                                  const EdgeInsets.symmetric(vertical: 4),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 22,
                                        backgroundColor:
                                        color.withValues(alpha: 0.18),
                                        child: Icon(
                                          Icons.person_rounded,
                                          color: color,
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
                                              displayName,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            if (isOwner)
                                              Container(
                                                padding:
                                                const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 2.5,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: AppColors.softGreenBg,
                                                  borderRadius:
                                                  BorderRadius.circular(6),
                                                ),
                                                child: const Text(
                                                  'Owner',
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.w700,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                              )
                                            else
                                              const Text(
                                                'Member',
                                                style: TextStyle(
                                                  fontSize: 12.5,
                                                  color:
                                                  AppColors.textSecondary,
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
                                );
                              },
                            );
                          },
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