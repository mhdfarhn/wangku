import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_text_styles.dart';

class ProfileOptionListTile extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Color iconColor;
  final Color iconBackgroundColor;
  final void Function() onTap;

  const ProfileOptionListTile({
    super.key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.iconBackgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ListTile(
        horizontalTitleGap: 8.w,
        leading: Container(
          height: 52.h,
          width: 52.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16.dm),
            color: iconBackgroundColor,
          ),
          child: Center(
            child: FaIcon(
              iconData,
              color: iconColor,
              size: 24.sp,
            ),
          ),
        ),
        onTap: onTap,
        title: Text(
          title,
          style: AppTextStyles.body1.copyWith(color: AppColors.dark25),
        ),
      ),
    );
  }
}
