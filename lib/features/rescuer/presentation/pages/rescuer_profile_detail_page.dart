import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';

class RescuerProfileDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const RescuerProfileDetailPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset(
          'assets/images/logo.png',
          height: 24,
          errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: AppColors.primary),
        ),
        centerTitle: true,
        actions: [
          const CircleAvatar(
            radius: 16,
            backgroundImage: NetworkImage('https://i.pravatar.cc/150?u=rescuer'),
          ),
          const Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(24),
            // Profile Photo
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  Container(
                    width: 160,
                    height: 160,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      image: const DecorationImage(
                        image: NetworkImage('https://i.pravatar.cc/150?u=hoang'),
                        fit: BoxFit.cover,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0061A5),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(Icons.medical_services, color: Colors.white, size: 16),
                  ),
                ],
              ),
            ),
            const Gap(24),
            
            // Subtitle / Department
            Text(
              'ĐỘI PHẢN ỨNG NHANH',
              style: AppTextStyles.fontInter(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0061A5),
                letterSpacing: 0.5,
              ),
            ),
            const Gap(8),
            
            // Name
            Text(
              data['name'],
              style: AppTextStyles.fontManrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(16),
            
            // Tags
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _Tag(label: 'Chỉ huy Hiện trường', color: const Color(0xFFD4E5FF), textColor: const Color(0xFF001D40)),
                const Gap(8),
                _Tag(label: 'Cấp cứu Y tế', color: const Color(0xFFFDE1D3), textColor: const Color(0xFF8B4D00)),
              ],
            ),
            const Gap(32),
            
            // Stats Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                children: [
                  Expanded(
                    child: _StatBox(
                      value: '142',
                      label: 'NHIỆM VỤ HOÀN THÀNH',
                    ),
                  ),
                  const Gap(16),
                  Expanded(
                    child: _StatBox(
                      value: '4.9',
                      label: 'ĐÁNH GIÁ TIN CẬY',
                      valueColor: const Color(0xFF0061A5),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(40),
            
            // Mission History Section
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lịch sử nhiệm vụ',
                        style: AppTextStyles.fontManrope(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: const Text('Tất cả', style: TextStyle(color: Color(0xFFBA1A1A), fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const Gap(16),
                  _MissionCard(
                    date: '12 THÁNG 10, 2023',
                    title: 'Ứng phó lũ lụt - Quận Liên Chiểu',
                    description: 'Điều phối sơ tán 20 hộ dân và cung cấp hỗ trợ y tế khẩn cấp tại khu vực ngập lụt nặng.',
                    status: 'HOÀN THÀNH',
                    borderColor: const Color(0xFFBA1A1A),
                  ),
                  const Gap(16),
                  _MissionCard(
                    date: '05 THÁNG 10, 2023',
                    title: 'Cấp cứu tai nạn giao thông',
                    description: 'Hỗ trợ sơ cứu 3 nạn nhân tại hiện trường và điều phối cứu thương.',
                    status: 'HOÀN THÀNH',
                    borderColor: const Color(0xFF0061A5),
                  ),
                  const Gap(100),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: 2, // Chat tab context
        onTabSelected: (index) => Navigator.pop(context),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;

  const _Tag({required this.label, required this.color, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: AppTextStyles.fontInter(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String value;
  final String label;
  final Color? valueColor;

  const _StatBox({required this.value, required this.label, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F3F4).withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTextStyles.fontManrope(
              fontSize: 32,
              fontWeight: FontWeight.w800,
              color: valueColor ?? const Color(0xFFBA1A1A),
            ),
          ),
          const Gap(8),
          Text(
            label,
            style: AppTextStyles.fontInter(
              fontSize: 8,
              fontWeight: FontWeight.bold,
              color: AppColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  final String date;
  final String title;
  final String description;
  final String status;
  final Color borderColor;

  const _MissionCard({
    required this.date,
    required this.title,
    required this.description,
    required this.status,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: borderColor, width: 4)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                date,
                style: AppTextStyles.fontInter(
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                ),
              ),
              Icon(Icons.house_outlined, color: borderColor.withValues(alpha: 0.7), size: 18),
            ],
          ),
          const Gap(8),
          Text(
            title,
            style: AppTextStyles.fontInter(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const Gap(12),
          Text(
            description,
            style: AppTextStyles.fontInter(
              fontSize: 13,
              color: AppColors.onSurfaceVariant,
              height: 1.5,
            ),
          ),
          const Gap(16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F3F4),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              status,
              style: AppTextStyles.fontInter(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: AppColors.onSurfaceVariant,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
