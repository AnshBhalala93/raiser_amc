import 'package:flutter/material.dart';
import 'package:raiser_amc/core/theme/app_colors.dart';
import 'package:raiser_amc/core/theme/app_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomDropdown<T> extends StatelessWidget {
  final String label;
  final String hintText;
  final IconData? prefixIcon;

  final T? value;
  final List<T> items;

  final String Function(T item) itemLabel;

  final ValueChanged<T?>? onChanged;

  final String? Function(T?)? validator;

  final bool isEnabled;

  const CustomDropdown({
    super.key,
    required this.label,
    required this.hintText,
    required this.items,
    required this.itemLabel,
    this.prefixIcon,
    this.value,
    this.onChanged,
    this.validator,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasPrefixIcon = prefixIcon != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // =====================================================
        // LABEL
        // =====================================================
        if (label.isNotEmpty) ...[
          Text(
            label,
            style: TextStyle(
              fontSize: 15.sp,
              fontFamily: AppFonts.bold,
              color: AppColors.textPrimary,
            ),
          ),

          SizedBox(height: 1.h),
        ],

        // =====================================================
        // DROPDOWN
        // =====================================================
        DropdownButtonFormField<T>(
          value: value,

          isExpanded: true,

          validator: validator,

          onChanged: isEnabled ? onChanged : null,

          icon: Icon(
            Icons.keyboard_arrow_down_rounded,
            size: 6.w,
            color: isEnabled ? AppColors.iconSecondary : AppColors.iconMuted,
          ),

          style: TextStyle(
            fontSize: 15.sp,
            color: AppColors.textPrimary,
            fontFamily: AppFonts.medium,
          ),

          dropdownColor: AppColors.surface,

          borderRadius: BorderRadius.circular(3.w),

          menuMaxHeight: 35.h,

          decoration: InputDecoration(
            hintText: hintText,

            // =================================================
            // HINT
            // =================================================
            hintStyle: TextStyle(
              fontSize: 15.sp,
              color: AppColors.textSecondary,
              fontFamily: AppFonts.regular,
            ),

            // =================================================
            // PREFIX ICON
            // =================================================
            prefixIcon: hasPrefixIcon
                ? Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.w),
              child: Icon(
                prefixIcon,
                color: AppColors.iconSecondary,
                size: 20.sp,
              ),
            )
                : null,

            prefixIconConstraints: hasPrefixIcon
                ? BoxConstraints(minWidth: 12.w, minHeight: 0)
                : const BoxConstraints(minWidth: 0, minHeight: 0),

            // =================================================
            // BACKGROUND
            // =================================================
            filled: true,
            fillColor: isEnabled
                ? AppColors.inputBackground
                : AppColors.surfaceSecondary,

            // =================================================
            // PADDING
            // =================================================
            contentPadding: EdgeInsets.symmetric(
              horizontal: 4.w,
              vertical: 1.6.h,
            ),

            // =================================================
            // NORMAL BORDER
            // =================================================
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.border, width: 1),
            ),

            // =================================================
            // ENABLED BORDER
            // =================================================
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.border, width: 1),
            ),

            // =================================================
            // FOCUSED BORDER
            // =================================================
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.primary, width: 1.5),
            ),

            // =================================================
            // ERROR BORDER
            // =================================================
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.error, width: 1),
            ),

            // =================================================
            // FOCUSED ERROR
            // =================================================
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),

            // =================================================
            // DISABLED BORDER
            // =================================================
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(color: AppColors.borderLight, width: 1),
            ),

            // =================================================
            // ERROR TEXT
            // =================================================
            errorStyle: TextStyle(
              fontSize: 11.sp,
              color: AppColors.error,
              fontFamily: AppFonts.regular,
            ),
          ),

          // =====================================================
          // ITEMS
          // =====================================================
          items: items.map((item) {
            return DropdownMenuItem<T>(
              value: item,

              child: Text(
                itemLabel(item),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontFamily: AppFonts.medium,
                  color: AppColors.textPrimary,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}