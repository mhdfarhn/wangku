import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/features/transaction/ui/widgets/transaction_card.dart';

import '../../../../core/app_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../cubits/recent_transaction/recent_transaction_cubit.dart';

class RecentTransactionSection extends StatelessWidget {
  const RecentTransactionSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transaction',
                style: AppTextStyles.title3.copyWith(color: AppColors.dark25),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.violet20,
                  foregroundColor: AppColors.violet100,
                  elevation: 0,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                ),
                child: Text(
                  'See all',
                  style: AppTextStyles.body3,
                ),
                onPressed: () => context.goNamed(AppRouter.transaction),
              ),
            ],
          ),
        ),
        BlocBuilder<RecentTransactionCubit, LoadRecentTransactionState>(
          builder: (context, state) {
            if (state is LoadingRecentTransaction) {
              return const Center(
                child: CircularProgressIndicator(
                  color: AppColors.violet100,
                ),
              );
            } else if (state is LoadRecentTransactionError) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                child: Text(
                  state.error,
                  style: AppTextStyles.body1.copyWith(
                    color: AppColors.red100,
                  ),
                ),
              );
            } else if (state is LoadRecentTransactionSuccess) {
              final transactions = state.transactions;
              final keys = transactions.keys.toList();
              if (transactions.isNotEmpty) {
                return Column(
                  children: List.generate(keys.length, (index) {
                    final key = keys[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        transactions[key]!.length,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: TransactionCard(
                            transaction: transactions[key]![index],
                          ),
                        ),
                      )..insert(
                          0,
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            child: Text(
                              keys[index],
                              style: AppTextStyles.title3
                                  .copyWith(color: AppColors.dark100),
                            ),
                          ),
                        ),
                    );
                  }),
                );
              } else {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                  ),
                  child: Text(
                    'You haven\'t added a transaction yet',
                    style: AppTextStyles.body1.copyWith(
                      color: AppColors.dark50,
                    ),
                    textAlign: TextAlign.start,
                  ),
                );
              }
            } else {
              return Container();
            }
          },
        ),
      ],
    );
  }
}
