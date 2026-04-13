import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

import 'donation_success_page.dart';

class DonationPaymentPage extends StatefulWidget {
  const DonationPaymentPage({super.key});

  @override
  State<DonationPaymentPage> createState() => _DonationPaymentPageState();
}

enum DonationCategory { money, rice, items, service }

class _DonationPaymentPageState extends State<DonationPaymentPage> {
  DonationCategory _selectedCategory = DonationCategory.money;
  
  // Money State
  int _selectedAmountIndex = 1;
  final List<String> _amounts = ['50k', '100k', '200k', '500k'];
  int _selectedPaymentMethod = 0;
  bool _isAnonymous = false;
  final TextEditingController _messageController = TextEditingController();

  // Rice State
  final TextEditingController _riceWeightController = TextEditingController();
  String _riceDeliveryMethod = 'Giao tận nơi';

  // Items State
  final Map<String, int> _itemQuantities = {'Mỳ gói': 0, 'Sách giáo khoa': 0};
  final TextEditingController _itemDescriptionController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    _riceWeightController.dispose();
    _itemDescriptionController.dispose();
    super.dispose();
  }

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
        title: Image.asset('assets/images/logo.png', height: 24),
        centerTitle: true,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.borderLight),
            ),
            child: IconButton(
              icon: const Icon(Icons.notifications_none, color: AppColors.textPrimary, size: 20),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(16),
              Center(
                child: Text(
                  'Quyên góp',
                  style: AppTextStyles.fontManrope(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              const Gap(24),
              
              // Category Selection Tabs
              _buildCategoryTabs(),
              
              const Gap(24),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: _buildSelectedForm(),
              ),

              const Gap(32),
              
              // Footer
              _buildFooter(),
              const Gap(40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          _CategoryTab(
            label: 'Tiền',
            isSelected: _selectedCategory == DonationCategory.money,
            onTap: () => setState(() => _selectedCategory = DonationCategory.money),
          ),
          const Gap(12),
          _CategoryTab(
            label: 'Gạo',
            isSelected: _selectedCategory == DonationCategory.rice,
            onTap: () => setState(() => _selectedCategory = DonationCategory.rice),
          ),
          const Gap(12),
          _CategoryTab(
            label: 'Vật phẩm',
            isSelected: _selectedCategory == DonationCategory.items,
            onTap: () => setState(() => _selectedCategory = DonationCategory.items),
          ),
          const Gap(12),
          _CategoryTab(
            label: 'Sức khỏe',
            isSelected: _selectedCategory == DonationCategory.service,
            onTap: () => setState(() => _selectedCategory = DonationCategory.service),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectedForm() {
    switch (_selectedCategory) {
      case DonationCategory.money:
        return _buildMoneyForm();
      case DonationCategory.rice:
        return _buildRiceForm();
      case DonationCategory.items:
        return _buildItemsForm();
      case DonationCategory.service:
        return _buildServiceForm();
    }
  }

  Widget _buildMoneyForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Chọn số tiền', style: AppTextStyles.subtitleBold),
        const Gap(12),
        _buildAmountSelection(),
        const Gap(24),
        Text('Phương thức thanh toán', style: AppTextStyles.subtitleBold),
        const Gap(12),
        _buildPaymentMethods(),
        const Gap(24),
        Text('Lời nhắn', style: AppTextStyles.subtitleBold),
        const Gap(12),
        _buildTextField(_messageController, 'Gửi lời nhắn của bạn...'),
        const Gap(24),
        _buildAnonymousToggle(),
      ],
    );
  }

  Widget _buildAmountSelection() {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightestBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: List.generate(_amounts.length, (index) {
          final isSelected = _selectedAmountIndex == index;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _selectedAmountIndex = index),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.accentBlue : Colors.transparent,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: isSelected ? [
                    BoxShadow(color: AppColors.accentBlue.withValues(alpha: 0.3), blurRadius: 4, offset: const Offset(0, 2))
                  ] : null,
                ),
                child: Center(
                  child: Text(
                    _amounts[index],
                    style: AppTextStyles.bodySemiBold.copyWith(
                      color: isSelected ? Colors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPaymentMethods() {
    final methods = [
      {'name': 'Chuyển khoản ngân hàng', 'icon': Icons.account_balance},
      {'name': 'Ví momo', 'icon': Icons.account_balance_wallet_outlined},
    ];
    
    return Column(
      children: methods.asMap().entries.map((entry) {
        final index = entry.key;
        final method = entry.value;
        final isSelected = _selectedPaymentMethod == index;
        return GestureDetector(
          onTap: () => setState(() => _selectedPaymentMethod = index),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.accentBlue.withValues(alpha: 0.1) : Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? AppColors.accentBlue : AppColors.borderLight,
                width: 1,
              ),
            ),
            child: Row(
              children: [
                Icon((method['icon'] as IconData?) ?? Icons.error, color: isSelected ? AppColors.accentBlue : AppColors.textSecondary),
                const Gap(12),
                Expanded(
                  child: Text(
                    (method['name'] as String?) ?? '',
                    style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Icon(
                  isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                  color: isSelected ? AppColors.accentBlue : AppColors.borderLight,
                  size: 20,
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildAnonymousToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Quyên góp ẩn danh',
          style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600),
        ),
        Switch.adaptive(
          value: _isAnonymous,
          activeTrackColor: AppColors.accentBlue,
          onChanged: (val) => setState(() => _isAnonymous = val),
        ),
      ],
    );
  }

  Widget _buildRiceForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Bạn muốn ủng hộ bao nhiêu?', style: AppTextStyles.subtitleBold),
        const Gap(4),
        Text('Nhập số lượng gạo muốn quyên góp', style: AppTextStyles.bodyRegular),
        const Gap(16),
        _buildTextField(_riceWeightController, '0 kg'),
        const Gap(32),
        Text('Chúng tôi có thể nhận gạo bằng cách nào?', style: AppTextStyles.subtitleBold),
        const Gap(16),
        Row(
          children: [
            Expanded(
              child: _ChoiceButton(
                label: 'Giao tận nơi',
                isSelected: _riceDeliveryMethod == 'Giao tận nơi',
                onTap: () => setState(() => _riceDeliveryMethod = 'Giao tận nơi'),
              ),
            ),
            const Gap(12),
            Expanded(
              child: _ChoiceButton(
                label: 'Hẹn lấy tại nhà',
                isSelected: _riceDeliveryMethod == 'Hẹn lấy tại nhà',
                onTap: () => setState(() => _riceDeliveryMethod = 'Hẹn lấy tại nhà'),
              ),
            ),
          ],
        ),
        const Gap(32),
        Text('Thông tin của bạn', style: AppTextStyles.subtitleBold),
        const Gap(4),
        Text('Chúng tôi cần thông tin này để liên hệ bạn', style: AppTextStyles.bodyRegular),
      ],
    );
  }

  Widget _buildItemsForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Vật phẩm quyên góp', style: AppTextStyles.subtitleBold),
        const Gap(16),
        _buildItemRow('Mỳ gói', Icons.soup_kitchen),
        const Gap(12),
        _buildItemRow('Sách giáo khoa', Icons.menu_book),
        const Gap(16),
        OutlinedButton.icon(
          onPressed: () {},
          icon: const Icon(Icons.add_circle, size: 20),
          label: const Text('Thêm vật phẩm'),
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(double.infinity, 48),
            side: const BorderSide(color: AppColors.accentBlue),
            foregroundColor: AppColors.accentBlue,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        const Gap(32),
        Text('Mô tả tình trạng (không bắt buộc)', style: AppTextStyles.subtitleBold),
        const Gap(12),
        _buildTextField(_itemDescriptionController, 'Ví dụ: sách còn mới, quần áo hơi cũ...', maxLines: 4),
      ],
    );
  }

  Widget _buildItemRow(String name, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.backgroundLightestBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(color: AppColors.accentBlue, borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const Gap(12),
          Expanded(child: Text(name, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.bold))),
          Row(
            children: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.remove_circle_outline, size: 20)),
              Text((_itemQuantities[name] ?? 0).toString(), style: AppTextStyles.bodyMedium),
              IconButton(onPressed: () {}, icon: const Icon(Icons.add_circle_outline, size: 20)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildServiceForm() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40),
        child: Column(
          children: [
            const Icon(Icons.handshake_outlined, size: 64, color: AppColors.accentBlue),
            const Gap(16),
            Text('Coming Soon', style: AppTextStyles.subtitleBold),
            const Gap(8),
            const Text('Tính năng quyên góp sức khỏe đang được phát triển.', textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hint, {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: AppTextStyles.fontInter(color: AppColors.textTertiary),
        filled: true,
        fillColor: const Color(0xFFFBFBFB),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.accentBlue),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          if (_selectedCategory == DonationCategory.money)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Tổng cộng', style: AppTextStyles.subtitleBold),
                Text('50.000 VND', style: AppTextStyles.subtitleBold.copyWith(color: AppColors.primary)),
              ],
            ),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const DonationSuccessPage())),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accentBlue.withValues(alpha: 0.7), // As per design light blue theme
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: Text('Xác nhận quyên góp', style: AppTextStyles.actionButton),
            ),
          ),
        ],
      ),
    );
  }
}

class _CategoryTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryTab({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentBlue : AppColors.backgroundLightestBlue,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Text(
          label,
          style: AppTextStyles.bodyMedium.copyWith(
            color: isSelected ? Colors.white : AppColors.textSecondary,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _ChoiceButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ChoiceButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentBlue : const Color(0xFFFFFBFA),
          borderRadius: BorderRadius.circular(8),
          border: isSelected ? null : Border.all(color: AppColors.borderLight),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTextStyles.bodyMedium.copyWith(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

