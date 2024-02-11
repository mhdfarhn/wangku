import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_text_styles.dart';

class LargeSecondaryButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  const LargeSecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.violet20,
        foregroundColor: AppColors.violet100,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.dm),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 16.h,
        ),
      ),
      child: Text(
        label,
        style: AppTextStyles.title3,
      ),
    );
  }
}
