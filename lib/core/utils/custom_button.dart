import 'package:flutter/material.dart';
import 'package:raiser_amc/core/theme/app_colors.dart';
import 'package:raiser_amc/core/theme/app_fonts.dart';
import 'package:sizer/sizer.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool showArrow;
  final bool isOutlined;
  final double? width;
  final double height;
  final Color? backgroundColor;
  final Color? textColor;
  final double fontSize;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.showArrow = false,
    this.isOutlined = false,
    this.width,
    this.height = 56,
    this.backgroundColor,
    this.textColor,
    this.fontSize = 16,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: isOutlined
              ? Colors.transparent
              : (backgroundColor ?? AppColors.primary),
          foregroundColor: isOutlined
              ? AppColors.primary
              : (textColor ?? Colors.white),
          elevation: isOutlined ? 0 : 4,
          shadowColor: AppColors.primary.withOpacity(0.4),
          side: isOutlined
              ? BorderSide(color: AppColors.primary, width: 1.5)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(13),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                fontFamily: AppFonts.bold,
                color: isOutlined
                    ? AppColors.primary
                    : (textColor ?? Colors.white),
                letterSpacing: 0.3,
              ),
            ),
            if (showArrow) ...[
               SizedBox(width: 8),
              Icon(
                Icons.arrow_forward,
                size: 18.sp,
                color: isOutlined
                    ? AppColors.primary
                    : (textColor ?? Colors.white),
              ),
            ],
          ],
        ),
      ),
    );
  }
}