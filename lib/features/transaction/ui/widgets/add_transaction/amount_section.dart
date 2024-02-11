import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../../../core/widgets/large_input_field.dart';

class AmountSection extends StatelessWidget {
  const AmountSection(
    this.controller, {
    super.key,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24.w,
        top: 60.h,
        right: 24.w,
        bottom: 16.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'How much?',
            style: AppTextStyles.title3.copyWith(
              color: AppColors.light80.withOpacity(0.64),
            ),
          ),
          Gap(12.h),
          LargeInputField(controller),
        ],
      ),
    );
  }
}
