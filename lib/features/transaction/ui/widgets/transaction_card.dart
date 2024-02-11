import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_extensions.dart';
import 'package:wangku/core/constants/app_text_styles.dart';
import 'package:wangku/features/transaction/data/models/transaction_model.dart';

import '../../../../core/constants/app_enums.dart';
import '../../cubits/transaction/transaction_cubit.dart';

class TransactionCard extends StatelessWidget {
  final TransactionModel transaction;

  const TransactionCard({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TransactionCubit>().loadTransaction(transaction.id!);
        context.goNamed(
          AppRouter.detailTransaction,
          pathParameters: {'id': transaction.id.toString()},
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24.dm),
          color: AppColors.light80,
        ),
        margin: EdgeInsets.symmetric(horizontal: 20.w),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 14.h,
        ),
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.dm),
                color: transaction.category.color.withOpacity(0.1),
              ),
              height: 60.h,
              width: 60.h,
              child: Center(
                child: FaIcon(
                  IconDataSolid(transaction.category.icon.icon!.codePoint),
                  color: transaction.category.color,
                  size: 28.sp,
                ),
              ),
            ),
            Gap(8.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.category.name,
                    style:
                        AppTextStyles.body1.copyWith(color: AppColors.dark25),
                    overflow: TextOverflow.ellipsis,
                  ),
                  Gap(12.h),
                  Text(
                    transaction.description,
                    style:
                        AppTextStyles.small.copyWith(color: AppColors.light20),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Gap(8.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  transaction.type.name == TransactionType.income.name
                      ? '+ \$${transaction.amount}'
                      : '- \$${transaction.amount}',
                  style: AppTextStyles.body2.copyWith(
                    color: transaction.type.name == TransactionType.income.name
                        ? AppColors.green100
                        : AppColors.red100,
                  ),
                ),
                Gap(12.h),
                Text(
                  transaction.dateTime.toTimeString(),
                  style: AppTextStyles.small.copyWith(color: AppColors.light20),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
