import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wangku/core/constants/app_extensions.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../data/models/transaction_model.dart';

class TypeCategoryWalletSection extends StatelessWidget {
  const TypeCategoryWalletSection(
    this.transaction, {
    super.key,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.light20,
            width: 0.1,
          ),
          borderRadius: BorderRadius.circular(12.dm),
          color: AppColors.light100,
        ),
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 12.h,
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Type',
                    style:
                        AppTextStyles.body3.copyWith(color: AppColors.light20),
                  ),
                  Gap(8.h),
                  Text(
                    transaction.type.name.capitalize(),
                    style:
                        AppTextStyles.body2.copyWith(color: AppColors.dark100),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Category',
                    style:
                        AppTextStyles.body3.copyWith(color: AppColors.light20),
                  ),
                  Gap(8.h),
                  Text(
                    transaction.category.name.capitalize(),
                    style:
                        AppTextStyles.body2.copyWith(color: AppColors.dark100),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Wallet',
                    style:
                        AppTextStyles.body3.copyWith(color: AppColors.light20),
                  ),
                  Gap(8.h),
                  Text(
                    transaction.wallet.name.capitalize(),
                    style:
                        AppTextStyles.body2.copyWith(color: AppColors.dark100),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
