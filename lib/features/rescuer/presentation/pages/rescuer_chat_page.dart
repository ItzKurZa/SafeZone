import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safezone/features/rescuer/presentation/pages/mission_tracking_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/team_member_tile.dart';
import 'rescuer_group_chat_page.dart';
import 'rescuer_profile_detail_page.dart';

class RescuerChatPage extends StatelessWidget {
  const RescuerChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   Image.asset(
                    'assets/images/logo.png',
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: AppColors.primary),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const MissionTrackingPage()),
                      );
                    },
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundImage: AssetImage('assets/images/rescuer_nam.png'),
                    ),
                  ),
                ],
              ),
              const Gap(32),

              // Chat List Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDAD6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'NHẮN TIN',
                      style: AppTextStyles.fontInter(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF93000A),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDAD6),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(Icons.chat_bubble, color: AppColors.rescuerBlue, size: 20),
                  ),
                ],
              ),
              const Gap(24),

              // Group Chat Mock List
              ...List.generate(4, (index) => _ChatGroupTile()),
              
              const Gap(40),
              
              // Member List Section
              Text(
                'Thành viên hỗ trợ',
                style: AppTextStyles.fontManrope(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                ),
              ),
              const Gap(16),
              
              TeamMemberTile(
                name: 'BS. Lê Minh Hoàng',
                role: 'Đội phản ứng nhanh',
                rating: 4.9,
                imageAsset: 'assets/images/doctor_hoang.png',
                isAssigned: false,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RescuerProfileDetailPage(data: {'name': 'BS. Lê Minh Hoàng'}),
                  ),
                ),
              ),
              TeamMemberTile(
                name: 'BS. Mai Phương Linh',
                role: 'Đội cấp cứu bệnh viện C',
                rating: 4.9,
                imageAsset: 'assets/images/doctor_linh.png',
                isAssigned: true,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RescuerProfileDetailPage(data: {'name': 'BS. Mai Phương Linh'}),
                  ),
                ),
              ),
              TeamMemberTile(
                name: 'BS. Lê Minh Hoàng',
                role: 'Đội phản ứng nhanh',
                rating: 4.9,
                imageAsset: 'assets/images/doctor_hoang.png',
                isAssigned: false,
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RescuerProfileDetailPage(data: {'name': 'BS. Lê Minh Hoàng'}),
                  ),
                ),
              ),
              
              const Gap(100), // Bottom nav padding
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.rescuerBlue,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class _ChatGroupTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const RescuerGroupChatPage(),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            // Stacked avatars mock
            const SizedBox(
              width: 56,
              child: Stack(
                children: [
                  CircleAvatar(backgroundImage: AssetImage('assets/images/team_member_1.png'), radius: 12),
                  Positioned(left: 10, child: CircleAvatar(backgroundImage: AssetImage('assets/images/team_member_2.png'), radius: 12)),
                  Positioned(left: 20, child: CircleAvatar(backgroundColor: Color(0xFFD4E5FF), radius: 12, child: Text('+12', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)))),
                ],
              ),
            ),
            const Gap(12),
            Text(
              'ĐỘI CỨU HỘ QUẬN 1',
              style: AppTextStyles.fontInter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            Text(
              '2 phút trước',
              style: AppTextStyles.fontInter(
                fontSize: 12,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
