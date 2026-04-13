import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import 'mission_tracking_page.dart';
import '../widgets/filter_chip_bar.dart';
import '../widgets/sos_card.dart';
import '../widgets/urgency_badge.dart';
import '../widgets/disaster_tag.dart';
import 'sos_detail_sheet.dart';

class SosListPage extends StatelessWidget {
  const SosListPage({super.key});

  void _showSosDetail(BuildContext context, Map<String, dynamic> data) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SosDetailSheet(data: data),
    );
  }

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
              // Header: Logo and Profile
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    'assets/images/logo.png', // Fallback to asset if exists
                    height: 32,
                    errorBuilder: (context, error, stackTrace) => const Icon(Icons.security, color: AppColors.primary),
                  ),
                  Row(
                    children: [
                      _CircleButton(icon: Icons.notifications_none),
                      const Gap(12),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const MissionTrackingPage()),
                          );
                        },
                        child: const CircleAvatar(
                          radius: 20,
                          backgroundImage: AssetImage('assets/images/rescuer_nam.png'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Gap(24),
              
              // Titles
              Text(
                'HỆ THỐNG ĐIỀU PHỐI',
                style: AppTextStyles.fontInter(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: AppColors.rescuerBlue,
                  letterSpacing: 1,
                ),
              ),
              const Gap(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Danh sách SOS',
                    style: AppTextStyles.fontManrope(
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                      color: AppColors.textPrimary,
                      letterSpacing: -0.75,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceContainerLow,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _SmallTab(label: 'Khẩn cấp', isActive: true),
                        _SmallTab(label: 'Gần đây', isActive: false),
                      ],
                    ),
                  ),
                ],
              ),
              const Gap(24),
              
              // Main Filter Tabs
              FilterChipBar(
                chips: const ['Đang xử lý', 'Mới nhận', 'Hoàn thành'],
                onSelected: (index) {},
              ),
              const Gap(24),
              
              // SOS List
              ...mockSosRequests.map((sos) => SosCard(
                victimName: sos['name'],
                timeAgo: sos['time'],
                distance: sos['distance'],
                address: sos['address'],
                urgency: sos['urgency'],
                tags: List<DisasterType>.from(sos['tags']),
                participants: sos['participants'],
                imageUrl: sos['image'],
                onAccept: () => _showSosDetail(context, sos),
              )),
              const Gap(100), // Bottom nav padding
            ],
          ),
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  const _CircleButton({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.borderGrayLight),
      ),
      child: Icon(icon, size: 20, color: AppColors.textPrimary),
    );
  }
}

class _SmallTab extends StatelessWidget {
  final String label;
  final bool isActive;
  const _SmallTab({required this.label, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        boxShadow: isActive ? [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 2,
            offset: const Offset(0, 1),
          )
        ] : null,
      ),
      child: Text(
        label,
        style: AppTextStyles.fontInter(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          color: isActive ? AppColors.textPrimary : AppColors.onSurfaceVariant,
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> mockSosRequests = [
  {
    'name': 'Nguyễn Văn An',
    'time': '2 phút trước',
    'distance': '1.2km',
    'address': '24 Trần Phú, Đà Nẵng',
    'description': 'Đang bị kẹt tại tầng 2, nước dâng nhanh. Cần hỗ trợ di dời 3 người lớn, 1 trẻ em.',
    'urgency': UrgencyLevel.emergency,
    'tags': [DisasterType.flood],
    'participants': '4 người',
    'image': null,
  },
  {
    'name': 'Lê Thị Hoa',
    'time': '8 phút trước',
    'distance': '2.5km',
    'address': 'K12/4 Hùng Vương, Đà Nẵng',
    'description': 'Gia đình có người già yếu, khói đang bốc lên từ tầng trệt.',
    'urgency': UrgencyLevel.emergency,
    'tags': [DisasterType.fire],
    'participants': '1 người già',
    'image': null,
  },
  {
    'name': 'Trần Minh Quân',
    'time': '15 phút trước',
    'distance': '4.8km',
    'address': 'Cầu Rồng, Đà Nẵng',
    'description': 'Tai nạn giao thông, cần sơ cứu vết thương hở.',
    'urgency': UrgencyLevel.normal,
    'tags': [DisasterType.medical],
    'participants': '1 người',
    'image': null,
  },
];
