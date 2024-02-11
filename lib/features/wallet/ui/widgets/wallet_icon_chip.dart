import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/constants/app_colors.dart';

class WalletIconChip extends StatelessWidget {
  final void Function() onTap;
  final FaIcon icon;
  final FaIcon? selectedIcon;
  final Color? color;

  const WalletIconChip({
    super.key,
    required this.onTap,
    required this.icon,
    required this.selectedIcon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(8.dm),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.dm),
          border: Border.all(
            color: selectedIcon?.icon!.codePoint == icon.icon!.codePoint
                ? color ?? AppColors.violet100
                : Colors.transparent,
          ),
          color: color != null
              ? color!.withOpacity(0.1)
              : AppColors.violet100.withOpacity(0.1),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 8.h,
        ),
        child: Icon(
          icon.icon,
          color: color ?? AppColors.violet100,
          size: 24.sp,
        ),
      ),
    );
  }
}
