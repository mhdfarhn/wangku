import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';

class TransactionReportCard extends StatelessWidget {
  final String transactionType;
  final int amount;
  final FaIcon icon;
  final Color color;

  const TransactionReportCard({
    super.key,
    required this.transactionType,
    required this.amount,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.dm),
        color: color,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48.r,
            width: 48.r,
            decoration: BoxDecoration(
              color: AppColors.light100,
              borderRadius: BorderRadius.circular(16.dm),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FaIcon(
                  icon.icon,
                  color: color,
                  size: 10.sp,
                ),
                FaIcon(
                  FontAwesomeIcons.moneyBill,
                  color: color,
                  size: 18.sp,
                ),
              ],
            ),
          ),
          Gap(10.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                transactionType,
                style: AppTextStyles.body3.copyWith(
                  color: AppColors.light80,
                ),
              ),
              Gap(4.h),
              Text(
                '\$$amount',
                style: TextStyle(
                  color: AppColors.light80,
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
