import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/constants/app_colors.dart';

class WalletColorChip extends StatelessWidget {
  final void Function() onTap;
  final Color color;
  final Color? selectedColor;

  const WalletColorChip({
    super.key,
    required this.onTap,
    required this.color,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.dm),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.dm),
          color: color,
        ),
        height: 40.h,
        width: 40.h,
        child: selectedColor?.value == color.value
            ? Icon(
                Icons.check,
                color: AppColors.light100,
                size: 24.sp,
              )
            : null,
      ),
    );
  }
}
