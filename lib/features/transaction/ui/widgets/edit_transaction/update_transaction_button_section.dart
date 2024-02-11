import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/large_primary_button.dart';
import '../../../../home/cubits/account_balance/account_balance_cubit.dart';
import '../../../../home/cubits/recent_transaction/recent_transaction_cubit.dart';
import '../../../../home/cubits/spend_frequency/spend_frequency_cubit.dart';
import '../../../cubits/image_cubit.dart';
import '../../../cubits/select_category_cubit.dart';
import '../../../cubits/select_wallet_cubit.dart';
import '../../../cubits/transaction/transaction_cubit.dart';
import '../../../cubits/transactions/transactions_cubit.dart';

class UpdateTransactionButtonSection extends StatelessWidget {
  const UpdateTransactionButtonSection({
    super.key,
    required this.transactionId,
    required this.onPressed,
  });

  final int transactionId;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 16.h,
      ),
      child: SizedBox(
        width: double.infinity,
        child: BlocConsumer<TransactionCubit, TransactionState>(
          listener: (context, state) {
            if (state is UpdateTransactionError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is UpdateTransactionSuccess) {
              context.read<TransactionCubit>().loadTransaction(transactionId);
              context.read<TransactionsCubit>().loadAllTransactions();
              context.read<AccountBalanceCubit>().loadAccountBalance();
              context.read<SpendFrequencyCubit>().loadSpendFrequency();
              context.read<RecentTransactionCubit>().loadRecentTransactions();
              context.read<SelectCategoryCubit>().removeCategory();
              context.read<SelectWalletCubit>().removeWallet();
              context.read<ImageCubit>().removeImage();
              context.goNamed(
                AppRouter.detailTransaction,
                pathParameters: {'id': transactionId.toString()},
              );
            }
          },
          builder: (context, state) {
            if (state is UpdatingTransaction) {
              return const Center(
                child: CircularProgressIndicator(color: AppColors.violet100),
              );
            } else {
              return LargePrimaryButton(
                label: 'Update',
                onPressed: onPressed,
              );
            }
          },
        ),
      ),
    );
  }
}
