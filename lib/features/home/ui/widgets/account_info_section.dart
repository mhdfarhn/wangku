import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wangku/features/home/cubits/account_balance/account_balance_cubit.dart';
import 'package:wangku/features/home/ui/widgets/transaction_report_card.dart';
import 'package:wangku/features/profile/cubits/account/account_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../cubits/transaction_report/transaction_report_cubit.dart';

class AccountInfoSection extends StatelessWidget {
  const AccountInfoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final accountCubit = context.read<AccountCubit>();
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(32.dm),
        ),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFFFF6E5),
            const Color(0xFFF8EED8).withOpacity(0),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Account Balance',
            style: AppTextStyles.body3.copyWith(
              color: AppColors.light20,
            ),
          ),
          Gap(8.h),
          BlocBuilder<AccountBalanceCubit, AccountBalanceState>(
            builder: (context, state) {
              return Text(
                state is LoadAccountBalanceSuccess
                    ? '\$${state.balance}'
                    : '\$9400',
                style: TextStyle(
                  color: AppColors.dark75,
                  fontSize: 40.sp,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
          Gap(28.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: BlocBuilder<TransactionReportCubit, TransactionReportState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Expanded(
                      child: TransactionReportCard(
                        transactionType: 'Income',
                        amount: state is LoadTransactionReportSuccess
                            ? state.income
                            : 0,
                        icon: const FaIcon(FontAwesomeIcons.arrowDown),
                        color: AppColors.green100,
                      ),
                    ),
                    Gap(16.w),
                    Expanded(
                      child: TransactionReportCard(
                        transactionType: 'Expense',
                        amount: state is LoadTransactionReportSuccess
                            ? state.expense
                            : 0,
                        icon: const FaIcon(FontAwesomeIcons.arrowUp),
                        color: AppColors.red100,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Gap(24.h),
        ],
      ),
    );
  }
}
