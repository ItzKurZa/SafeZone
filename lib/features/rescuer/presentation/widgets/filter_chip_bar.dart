import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class FilterChipBar extends StatefulWidget {
  final List<String> chips;
  final Function(int) onSelected;

  const FilterChipBar({
    super.key,
    required this.chips,
    required this.onSelected,
  });

  @override
  State<FilterChipBar> createState() => _FilterChipBarState();
}

class _FilterChipBarState extends State<FilterChipBar> {
  int _selectedIndex = 1; // Default to "Mới nhận" (index 1) according to Figma

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: List.generate(widget.chips.length, (index) {
          final isSelected = _selectedIndex == index;
          Color bgColor;
          Color textColor;
          Color dotColor;
          
          if (isSelected) {
            bgColor = AppColors.rescuerPrimary;
            textColor = Colors.white;
            dotColor = Colors.white;
          } else {
            bgColor = index == 0 ? AppColors.surfaceContainerHighest : AppColors.surfaceContainerLow;
            textColor = index == 0 ? AppColors.textPrimary : AppColors.onSurfaceVariant;
            dotColor = index == 0 ? Colors.blue : Colors.grey.shade400;
          }

          return GestureDetector(
            onTap: () {
              setState(() => _selectedIndex = index);
              widget.onSelected(index);
            },
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: isSelected ? [
                  BoxShadow(
                    color: AppColors.rescuerPrimary.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ] : null,
              ),
              child: Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: dotColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    widget.chips[index],
                    style: AppTextStyles.fontInter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
