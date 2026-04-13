import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

import '../../../../core/presentation/widgets/app_bottom_nav_bar.dart';
import '../../../emergency/presentation/widgets/floating_sos_button.dart';
import 'warning_detail_page.dart';

class WarningsFeedPage extends StatefulWidget {
  const WarningsFeedPage({super.key});

  @override
  State<WarningsFeedPage> createState() => _WarningsFeedPageState();
}

class _WarningsFeedPageState extends State<WarningsFeedPage> {
  int _selectedTabIndex = 0;

  final List<String> _tabs = ['Gần tôi', 'Safety', 'Cộng đồng', 'Đánh dấu đã đọc'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Image.asset('assets/images/logo.png', width: 80, height: 35, fit: BoxFit.contain),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Gap(10),
            // Search Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.cardGray,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  decoration: InputDecoration(
                    icon: const Icon(Icons.search, color: AppColors.textSecondary),
                    hintText: 'Search',
                    hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.filter_list, color: AppColors.textSecondary),
                  ),
                ),
              ),
            ),
            const Gap(15),
            
            // Tabs
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: List.generate(_tabs.length, (index) {
                  final isSelected = _selectedTabIndex == index;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedTabIndex = index;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected ? AppColors.activeBlue : AppColors.borderLight,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _tabs[index],
                        style: AppTextStyles.bodySemiBold.copyWith(
                          fontSize: 12,
                          color: isSelected ? AppColors.white : AppColors.textSecondary,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Gap(20),

            // List of Warnings
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 20),
                decoration: const BoxDecoration(
                  color: AppColors.redLight,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
                ),
                child: _buildFeedList(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: AppBottomNavBar(
        currentIndex: 2,
        onTabSelected: (idx) {
          if(idx != 0) Navigator.pop(context);
        },
      ),
      floatingActionButton: const FloatingSosButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  Widget _buildFeedList() {
    // 0: Gần tôi (All), 1: Safety (Red only), 2: Cộng đồng (News)
    List<Widget> items = [];

    if (_selectedTabIndex == 1) {
      // Safety: Only Red
      items = [
        _buildWarningRow('Báo cáo hoạt động đáng ngờ', '15 phút trước', '600m', false),
        _buildWarningRow('Báo cáo hoạt động đáng ngờ', '1 giờ trước', '1.2km', false),
        _buildWarningRow('Hành vi ẩu đả', '1 giờ trước', '1km', false),
        _buildWarningRow('Phá hoại tài sản', '1 ngày trước', '1.5km', false),
      ];
    } else if (_selectedTabIndex == 2) {
      // Cộng đồng: Multiple News
      items = [
        _buildNewsRow('Lớn lên không có bố, mẹ bị tâm thần nặng...'),
        _buildNewsRow('Cụ ông 80 tuổi ròng rã nhặt ve chai nuôi cháu mồ côi...'),
        _buildNewsRow('Hai anh em mồ côi cha mẹ bơ vơ giữa đỉnh đồi...'),
        _buildNewsRow('Gia cảnh bi đát của người mẹ đơn thân chạy thận...'),
      ];
    } else {
      // Gần tôi (Default)
      items = [
        _buildWarningRow('Báo cáo hoạt động đáng ngờ', '15 phút trước', '600m', false),
        _buildWarningRow('Tai nạn chặn đường', '30 phút trước', '800m', true),
        _buildWarningRow('Báo cáo hoạt động đáng ngờ', '1 giờ trước', '1.2km', false),
        _buildWarningRow('Hành vi ẩu đả', '1 giờ trước', '1km', false),
        _buildWarningRow('Phá hoại tài sản', '1 ngày trước', '1.5km', false),
      ];
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      itemCount: items.length + 1,
      itemBuilder: (context, index) {
        if (index == items.length) {
          return const Gap(100); // padding for FAB and Nav
        }
        return items[index];
      },
    );
  }

  // Common warning card
  Widget _buildWarningRow(String title, String timeAgo, String distance, bool isYellow) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: isYellow
                      ? const [AppColors.alertYellowStart, AppColors.alertYellowEnd]
                      : const [AppColors.alertRedStart, AppColors.alertRedEnd],
                ),
              ),
              child: const Icon(Icons.warning_amber_rounded, color: AppColors.white, size: 20),
            ),
            const Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.bodySemiBold.copyWith(color: AppColors.textPrimary),
                  ),
                  Text(
                    timeAgo,
                    style: AppTextStyles.bodyRegular.copyWith(fontSize: 11),
                  ),
                ],
              ),
            ),
            Text(
              distance,
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary, fontSize: 11),
            ),
            const Gap(AppSpacing.sm),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      );
  }

  // News logic for Cong Dong tab (click leads to Hoan Canh)
  Widget _buildNewsRow(String title) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const WarningDetailPage(title: 'Lời kêu gọi', timeAgo: 'Vừa xong')),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: AppColors.cardGray,
                image: const DecorationImage(
                  image: AssetImage('assets/images/boy_eating.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const Gap(15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySemiBold.copyWith(color: AppColors.textPrimary, height: 1.3),
                  ),
                  const Gap(4),
                  Text(
                    'Đóng góp ngay',
                    style: AppTextStyles.bodySemiBold.copyWith(fontSize: 11, color: AppColors.accentBlue),
                  ),
                ],
              ),
            ),
            const Gap(AppSpacing.sm),
            const Icon(Icons.chevron_right, color: AppColors.textSecondary),
          ],
        ),
      ),
    );
  }
}