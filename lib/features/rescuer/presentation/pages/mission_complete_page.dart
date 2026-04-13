import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'mission_report_form_page.dart';
import 'mission_tracking_page.dart';

class MissionCompletePage extends StatelessWidget {
  final Map<String, dynamic> data;

  const MissionCompletePage({
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
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            const Gap(40),
            // Success Icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF22C55E), // Success green
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF22C55E).withValues(alpha: 0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(Icons.check, color: Colors.white, size: 64),
            ),
            const Gap(32),
            
            // Success Message
            Text(
              'Chúc mừng!',
              style: AppTextStyles.fontManrope(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const Gap(8),
            Text(
              'Nhiệm vụ đã hoàn tất thành công.',
              style: AppTextStyles.fontInter(
                fontSize: 16,
                color: AppColors.onSurfaceVariant,
              ),
            ),
            const Gap(40),
            
            // Stats Row
            Row(
              children: [
                Expanded(child: _StatCard(icon: Icons.access_time, label: 'THỜI GIAN XỬ LÝ', value: '18:42')),
                const Gap(16),
                Expanded(child: _StatCard(icon: Icons.location_on_outlined, label: 'QUÃNG ĐƯỜNG', value: '4.2 km')),
              ],
            ),
            const Gap(32),
            
            // Mission Detail Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.surfaceContainerLow,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CHI TIẾT NHIỆM VỤ',
                    style: AppTextStyles.fontInter(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                  const Gap(20),
                  _DetailRow(
                    icon: Icons.location_on,
                    label: 'ĐIỂM ĐẾN',
                    value: 'Trung tâm sơ cứu Quận Cẩm Lệ, Đà Nẵng',
                  ),
                  const Gap(16),
                  _DetailRow(
                    icon: Icons.shopping_bag,
                    label: 'VẬT PHẨM',
                    value: 'Gói cứu trợ y tế khẩn cấp A2',
                  ),
                ],
              ),
            ),
            
            const Gap(40),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MissionReportFormPage(data: data),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.rescuerBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.assignment_turned_in),
                    Gap(12),
                    Text('Báo cáo kết quả', style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const Gap(32),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _StatCard({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 10, offset: const Offset(0, 4)),
        ],
        border: Border.all(color: AppColors.surfaceContainerHighest.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.rescuerBlue, size: 24),
          const Gap(12),
          Text(label, style: const TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.grey)),
          const Gap(4),
          Text(value, style: AppTextStyles.fontManrope(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  const _DetailRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 16, color: AppColors.rescuerPrimary),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.grey)),
              const Gap(4),
              Text(value, style: AppTextStyles.fontInter(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            ],
          ),
        ),
      ],
    );
  }
}
