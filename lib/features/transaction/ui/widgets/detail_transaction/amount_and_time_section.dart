import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wangku/core/constants/app_extensions.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_enums.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../data/models/transaction_model.dart';

class AmountAndTimeSection extends StatelessWidget {
  const AmountAndTimeSection(
    this.transaction, {
    super.key,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: transaction.type == TransactionType.income
                ? AppColors.green100
                : AppColors.red100,
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(16.dm),
            ),
          ),
          child: Column(
            children: [
              Gap(8.h),
              Text(
                '\$${transaction.amount}',
                style: TextStyle(
                  color: AppColors.light80,
                  fontSize: 48.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gap(8.h),
              Text(
                '${transaction.dateTime.toDayString()}\n${transaction.dateTime.toTimeString()}',
                style: AppTextStyles.small.copyWith(color: AppColors.light100),
                textAlign: TextAlign.center,
              ),
              Gap(54.h),
            ],
          ),
        ),
        Gap(30.h),
      ],
    );
  }
}
