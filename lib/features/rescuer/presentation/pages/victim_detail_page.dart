import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:safezone/features/rescuer/presentation/pages/mission_tracking_page.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/presentation/widgets/rescuer_bottom_nav_bar.dart';

class VictimDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;

  const VictimDetailPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
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
          const Gap(16),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            // Emergency Status Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFFFDAD6),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: const Color(0xFFBA1A1A),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.warning_amber_rounded, color: Colors.white),
                  ),
                  const Gap(16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TÌNH TRẠNG KHẨN CẤP',
                          style: AppTextStyles.fontInter(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF410002),
                          ),
                        ),
                        const Gap(4),
                        Text(
                          'Mức độ nguy hiểm: RẤT CAO',
                          style: AppTextStyles.fontInter(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFFBA1A1A),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Gap(24),
            
            // Profile Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Photo and Mock Plus Background
                  Stack(
                    children: [
                      // Photo
                      Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          image: DecorationImage(
                            image: data['image'] != null
                                ? NetworkImage(data['image'])
                                : const AssetImage('assets/images/victim_placeholder.png') as ImageProvider,
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(color: const Color(0xFFFFDAD6), width: 2),
                        ),
                      ),
                      // Positioned Watermark Mock
                      Positioned(
                        right: 0,
                        top: 0,
                        child: Icon(
                          Icons.medical_services_outlined,
                          size: 100,
                          color: Colors.grey.withValues(alpha: 0.05),
                        ),
                      ),
                    ],
                  ),
                  const Gap(32),
                  
                  // ID Badge
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFDAD6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'MÃ ĐỊNH DANH: SZ-9921',
                      style: AppTextStyles.fontInter(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFBA1A1A),
                      ),
                    ),
                  ),
                  const Gap(12),
                  
                  // Name
                  Text(
                    data['name'],
                    style: AppTextStyles.fontManrope(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const Gap(20),
                  
                  // Age and Blood Type
                  Row(
                    children: [
                      _StatBox(label: 'TUỔI', value: '42'),
                      const Gap(12),
                      _StatBox(
                        label: 'NHÓM MÁU', 
                        value: 'O-', 
                        valueColor: const Color(0xFFBA1A1A),
                        bgColor: const Color(0xFFFFDAD6).withValues(alpha: 0.3),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const Gap(24),
            
            // Emergency Contact
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF0061A5),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.contact_mail_outlined, color: Colors.white, size: 28),
                  const Gap(16),
                  Text(
                    'Liên hệ khẩn cấp',
                    style: AppTextStyles.fontInter(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const Gap(8),
                  Text(
                    'Người thân: Trần Thị B',
                    style: AppTextStyles.fontInter(
                      fontSize: 14,
                      color: Colors.white.withValues(alpha: 0.8),
                    ),
                  ),
                ],
              ),
            ),
            const Gap(100), // Padding for nav bar
          ],
        ),
      ),
      bottomNavigationBar: RescuerBottomNavBar(
        currentIndex: 0,
        onTabSelected: (index) {
          if (index != 0) {
            RescuerBottomNavBar.navigateToTab(context, index);
          }
        },
      ),
    );
  }
}

class _StatBox extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final Color? bgColor;

  const _StatBox({
    required this.label,
    required this.value,
    this.valueColor,
    this.bgColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: bgColor ?? const Color(0xFFF1F3F4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: AppTextStyles.fontInter(
              fontSize: 10,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFBA1A1A).withValues(alpha: 0.5),
            ),
          ),
          const Gap(4),
          Text(
            value,
            style: AppTextStyles.fontManrope(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: valueColor ?? AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
