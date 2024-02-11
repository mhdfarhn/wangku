import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';
import 'large_secondary_button.dart';

Future<dynamic> showConfirmationModalBottomSheet({
  required BuildContext context,
  required String title,
  required String description,
  required Widget confirmButton,
}) {
  return showModalBottomSheet(
    backgroundColor: AppColors.light100,
    showDragHandle: true,
    context: context,
    builder: (context) {
      return BottomSheet(
        backgroundColor: AppColors.light100,
        onClosing: () {},
        builder: (context) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style:
                      AppTextStyles.title3.copyWith(color: AppColors.dark100),
                ),
                Gap(8.h),
                Text(
                  description,
                  style: AppTextStyles.body1.copyWith(color: AppColors.light20),
                ),
                Gap(16.h),
                Row(
                  children: [
                    Expanded(
                      child: LargeSecondaryButton(
                        label: 'No',
                        onPressed: () => context.pop(),
                      ),
                    ),
                    Gap(16.w),
                    Expanded(child: confirmButton),
                  ],
                ),
                Gap(16.w),
              ],
            ),
          );
        },
      );
    },
  );
}
