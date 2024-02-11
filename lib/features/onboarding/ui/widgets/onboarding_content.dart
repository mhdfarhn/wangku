import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class OnboardingContent extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  const OnboardingContent({
    super.key,
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 32.w,
        vertical: 32.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(image),
          Gap(40.h),
          Text(
            title,
            style: AppTextStyles.title1.copyWith(color: AppColors.dark50),
            textAlign: TextAlign.center,
          ),
          Gap(16.h),
          Text(
            description,
            style: AppTextStyles.body1.copyWith(color: AppColors.light20),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
