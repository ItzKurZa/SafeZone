import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../widgets/incident_type_card.dart';
import '../widgets/report_success_overlay.dart';
import 'pick_photo_page.dart';
import 'location_picker_page.dart';

class ReportPage extends StatefulWidget {
  final VoidCallback? onFinish;
  const ReportPage({super.key, this.onFinish});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  IncidentType? _selectedType;
  int _severityLevel = 0; // 0: Thấp, 1: Trung bình, 2: Cao
  final TextEditingController _descriptionController = TextEditingController();
  List<String> _selectedPhotos = [];
  String _selectedAddress = '01 Phan Huy Chú, Đà Nẵng';

  final List<Map<String, dynamic>> _incidentTypes = [
    {
      'type': IncidentType.suspicious,
      'label': 'Hoạt động đáng ngờ',
      'icon': Icons.warning_amber_rounded,
    },
    {
      'type': IncidentType.accident,
      'label': 'Tai nạn',
      'icon': Icons.car_crash_outlined,
    },
    {
      'type': IncidentType.fire,
      'label': 'Cháy nổ',
      'icon': Icons.local_fire_department_outlined,
    },
    {
      'type': IncidentType.flood,
      'label': 'Ngập lụt',
      'icon': Icons.water_drop_outlined,
    },
    {
      'type': IncidentType.powerOutage,
      'label': 'Mất điện',
      'icon': Icons.bolt_outlined,
    },
    {
      'type': IncidentType.other,
      'label': 'Khác',
      'icon': Icons.more_horiz_outlined,
    },
  ];

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
          onPressed: () {}, // Since it's a tab, back might not do much
        ),
        title: Image.asset('assets/images/logo.png', width: 80, height: 35, fit: BoxFit.contain),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none_outlined, color: AppColors.textPrimary),
            onPressed: () {},
          ),
          const Gap(10),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Gap(10),
            Text(
              _selectedType != null 
                  ? 'Báo cáo: ${_incidentTypes.firstWhere((e) => e['type'] == _selectedType)['label']}'
                  : 'Báo cáo sự cố',
              style: AppTextStyles.h2.copyWith(color: AppColors.textPrimary, fontSize: 24),
            ),
            const Gap(8),
            Text(
              'Chọn loại sự cố',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const Gap(16),
            
            // Incident Grid
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 2.8,
              ),
              itemCount: _incidentTypes.length,
              itemBuilder: (context, index) {
                final item = _incidentTypes[index];
                return IncidentTypeCard(
                  type: item['type'],
                  label: item['label'],
                  icon: item['icon'],
                  isSelected: _selectedType == item['type'],
                  onTap: () {
                    setState(() {
                      _selectedType = item['type'];
                    });
                  },
                );
              },
            ),
            
            const Gap(24),
            Text(
              'Mô tả',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const Gap(8),
            Container(
              height: 100,
              decoration: BoxDecoration(
                color: AppColors.incidentIconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _descriptionController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Mô tả chi tiết sự việc...',
                  hintStyle: AppTextStyles.bodyRegular.copyWith(color: AppColors.textHint),
                  border: InputBorder.none,
                ),
              ),
            ),
            
            const Gap(24),
            Text(
              'Tải ảnh lên',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const Gap(8),
            GestureDetector(
              onTap: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const PickPhotoPage()),
                );
                if (result != null && result is List<String>) {
                  setState(() {
                    _selectedPhotos = result;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.accentBlue, width: 1, style: BorderStyle.solid), // Should be dashed ideally
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.camera_alt_outlined, color: AppColors.accentBlue, size: 24),
                    const Gap(4),
                    Text(
                      _selectedPhotos.isNotEmpty ? 'Đã thêm ${_selectedPhotos.length} ảnh' : 'Thêm ảnh',
                      style: AppTextStyles.bodyMedium.copyWith(color: AppColors.accentBlue),
                    ),
                  ],
                ),
              ),
            ),
            
            if (_selectedPhotos.isNotEmpty) ...[
              const Gap(12),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _selectedPhotos.length,
                  separatorBuilder: (context, index) => const Gap(8),
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            _selectedPhotos[index],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPhotos.removeAt(index);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.black54,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(Icons.close, size: 12, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
            
            const Gap(24),
            Text(
              'Vị trí',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const Gap(8),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.incidentIconBg,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                   const Icon(Icons.location_on_outlined, color: AppColors.textSecondary, size: 32),
                   const Gap(12),
                   Expanded(
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Text(
                           _selectedAddress.split(',').first,
                           style: AppTextStyles.bodySemiBold.copyWith(color: AppColors.textPrimary),
                         ),
                         Text(
                           _selectedAddress.contains(',') ? _selectedAddress.split(',').last.trim() : '',
                           style: AppTextStyles.bodyRegular.copyWith(fontSize: 12, color: AppColors.textSecondary),
                         ),
                       ],
                     ),
                   ),
                   TextButton(
                     onPressed: () async {
                       final result = await Navigator.push(
                         context,
                         MaterialPageRoute(builder: (context) => const LocationPickerPage()),
                       );
                       if (result != null && result is String) {
                         setState(() {
                           _selectedAddress = result;
                         });
                       }
                     },
                     child: Text(
                       'Thay đổi',
                       style: AppTextStyles.bodySemiBold.copyWith(color: AppColors.accentBlue),
                     ),
                   ),
                ],
              ),
            ),

            const Gap(24),
            Text(
              'Mức độ',
              style: AppTextStyles.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            const Gap(8),
            _buildSeveritySelector(),
            
            const Gap(32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  showReportSuccess(context, () {
                    Navigator.pop(context); // Close dialog
                    if (widget.onFinish != null) {
                      widget.onFinish!();
                    }
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.accentBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Gửi báo cáo',
                  style: AppTextStyles.buttonLarge.copyWith(color: AppColors.white),
                ),
              ),
            ),
            const Gap(100), // Padding for bottom nav
          ],
        ),
      ),
    );
  }

  Widget _buildSeveritySelector() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.yellowLight,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _buildSeverityItem(0, 'Thấp'),
          _buildSeverityItem(1, 'Trung bình'),
          _buildSeverityItem(2, 'Cao'),
        ],
      ),
    );
  }

  Widget _buildSeverityItem(int level, String label) {
    bool isSelected = _severityLevel == level;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _severityLevel = level;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected ? [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ] : null,
          ),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
