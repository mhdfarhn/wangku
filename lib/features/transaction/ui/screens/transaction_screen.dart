import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_text_styles.dart';
import 'package:wangku/core/widgets/top_navigation.dart';
import 'package:wangku/features/transaction/ui/widgets/transaction_card.dart';

import '../../cubits/transactions/transactions_cubit.dart';

class TransactionScreen extends StatelessWidget {
  const TransactionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light100,
      appBar: TopNavigation.transaction(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 8.h,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                backgroundColor: AppColors.violet20,
                foregroundColor: AppColors.violet100,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.dm)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'See your financial report',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  FaIcon(
                    FontAwesomeIcons.angleRight,
                    size: 20.sp,
                  ),
                ],
              ),
              onPressed: () {},
            ),
          ),
          Expanded(
            child: BlocBuilder<TransactionsCubit, TransactionsState>(
              builder: (context, state) {
                if (state is LoadTransactionsSuccess) {
                  final transactions = state.transactions;
                  final keys = transactions.keys.toList();
                  return transactions.isEmpty
                      ? Center(
                          child: Text(
                            'You haven\'t added a transaction yet',
                            style: AppTextStyles.body1
                                .copyWith(color: AppColors.dark50),
                          ),
                        )
                      : ListView(
                          children: List.generate(
                            keys.length,
                            (index) {
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
                            },
                          ),
                        );
                } else if (state is LoadTransactionsError) {
                  return Center(
                    child: Text(
                      state.error,
                      style: TextStyle(
                        color: Colors.redAccent,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
