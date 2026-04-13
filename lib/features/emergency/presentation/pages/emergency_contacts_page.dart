import 'package:flutter/material.dart';
import 'package:safezone/core/theme/app_text_styles.dart';
import 'package:safezone/core/theme/app_colors.dart';
import 'package:gap/gap.dart';

import 'add_contact_page.dart';
import 'active_call_page.dart';

class EmergencyContactsPage extends StatelessWidget {
  const EmergencyContactsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20, right: 8),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddContactPage()),
            );
          },
          backgroundColor: Colors.white,
          elevation: 4,
          shape: const CircleBorder(
            side: BorderSide(color: AppColors.primary, width: 0.5),
          ),
          child: const Icon(Icons.add, color: AppColors.primary, size: 32),
        ),
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(20),
              _buildHeader(),
              const Gap(24),
              Text(
                'Liên lạc',
                style: AppTextStyles.fontPoppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                  letterSpacing: -0.5,
                ),
              ),
              const Gap(12),
              _buildSearchBar(),
              const Gap(24),
              _buildContactList(context),
              const Gap(24),
              Text(
                'Bạn rất quan trọng!',
                style: AppTextStyles.fontPoppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              const Gap(4),
              Text(
                'Chỉ cần một cuộc gọi, chúng tôi sẽ luôn sẵn sàng hỗ trợ bạn.',
                style: AppTextStyles.fontPoppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.textSecondary,
                ),
              ),
              const Gap(20),
              _buildCallUsCard(),
              const Gap(100),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ClipOval(
          child: Image.asset(
            'assets/images/avatar_1.png',
            width: 44,
            height: 44,
            fit: BoxFit.cover,
          ),
        ),
        Image.asset(
          'assets/images/logo.png',
          width: 80,
          height: 35,
          fit: BoxFit.contain,
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.borderLight),
          ),
          child: const Icon(Icons.notifications_none, color: Colors.black, size: 24),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: AppColors.searchBarBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          const Gap(12),
          const Icon(Icons.search, color: AppColors.iconGray, size: 20),
          const Gap(8),
          Text(
            'Search',
            style: AppTextStyles.fontInter(
              fontSize: 14,
              color: AppColors.iconGray,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactList(BuildContext context) {
    return Column(
      children: [
        _ContactTile(
          name: 'Bố',
          phone: '(+84) 365196582',
          avatarAsset: 'assets/images/avatar_1.png',
          onTap: () => _startCall(context, 'Bố'),
        ),
        _ContactTile(
          name: 'Mẹ',
          phone: '(+84) 365196582',
          avatarAsset: 'assets/images/avatar_2.png',
          onTap: () => _startCall(context, 'Mẹ'),
        ),
        _ContactTile(
          name: 'Anh 2',
          phone: '(+84) 365196582',
          avatarAsset: 'assets/images/avatar_1.png',
          onTap: () => _startCall(context, 'Anh 2'),
        ),
      ],
    );
  }

  Widget _buildCallUsCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.primary, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: const BoxDecoration(
              color: AppColors.pureRed,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.phone, color: Colors.white, size: 24),
          ),
          const Gap(16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Đội ngũ của chúng tôi luôn sẵn sàng hỗ trợ 24/7.',
                  style: AppTextStyles.fontPoppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textSecondary,
                  ),
                ),
                const Gap(4),
                Text(
                  'Call Us',
                  style: AppTextStyles.fontPoppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _startCall(BuildContext context, String name) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ActiveCallPage(callerName: name)),
    );
  }
}

class _ContactTile extends StatelessWidget {
  final String name;
  final String phone;
  final String avatarAsset;
  final VoidCallback onTap;

  const _ContactTile({
    required this.name,
    required this.phone,
    required this.avatarAsset,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            ClipOval(
              child: Image.asset(
                avatarAsset,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: AppTextStyles.fontPoppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    phone,
                    style: AppTextStyles.fontRoboto(
                      fontSize: 12,
                      color: AppColors.iconGray,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
