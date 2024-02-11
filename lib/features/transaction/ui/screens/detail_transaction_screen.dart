import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/widgets/large_primary_button.dart';
import 'package:wangku/core/widgets/show_confirmation_modal_button_sheet.dart';
import 'package:wangku/core/widgets/top_navigation.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enums.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../cubits/transaction/transaction_cubit.dart';
import '../widgets/detail_transaction/detail_transaction_widgets.dart';

class DetailTransactionScreen extends StatelessWidget {
  final String id;

  const DetailTransactionScreen(
    this.id, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionCubit, TransactionState>(
      builder: (context, state) {
        if (state is LoadingTransaction) {
          return const Scaffold(
            backgroundColor: AppColors.light100,
            body: Center(
              child: CircularProgressIndicator(color: AppColors.violet100),
            ),
          );
        } else if (state is LoadTransactionError) {
          return Scaffold(
            backgroundColor: AppColors.light100,
            body: Center(
              child: Text(
                state.error,
                style: AppTextStyles.body3.copyWith(
                  color: AppColors.red100,
                ),
              ),
            ),
          );
        } else if (state is LoadTransactionSuccess) {
          final transaction = state.transaction;

          return Scaffold(
            backgroundColor: AppColors.light100,
            appBar: TopNavigation.full(
              title: 'Detail Transaction',
              backgroundColor: transaction.type == TransactionType.income
                  ? AppColors.green100
                  : AppColors.red100,
              foregroundColor: AppColors.light100,
              statusBarColor: transaction.type == TransactionType.income
                  ? AppColors.green100
                  : AppColors.red100,
              statusBarBrightness: Brightness.dark,
              statusBarIconBrightness: Brightness.light,
              icon: InkWell(
                borderRadius: BorderRadius.circular(26.dm),
                onTap: () {
                  showConfirmationModalBottomSheet(
                    context: context,
                    title: 'Remove this transaction?',
                    description:
                        'Are you sure want to delete this transaction?',
                    confirmButton: RemoveTransactionButton(transaction),
                  );
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    size: 16.sp,
                  ),
                ),
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      Stack(
                        children: [
                          AmountAndTimeSection(transaction),
                          TypeCategoryWalletSection(transaction),
                        ],
                      ),
                      DescriptionAndImageSection(transaction),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(
                    left: 16.w,
                    top: 8.h,
                    right: 16.w,
                    bottom: 16.h,
                  ),
                  width: double.infinity,
                  child: LargePrimaryButton(
                    label: 'Edit',
                    onPressed: () => context.goNamed(
                      AppRouter.editTransaction,
                      pathParameters: {'id': transaction.id.toString()},
                      extra: transaction,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Scaffold();
        }
      },
    );
  }
}
