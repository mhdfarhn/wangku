import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/app_router.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/widgets/large_primary_button.dart';
import '../../../../home/cubits/account_balance/account_balance_cubit.dart';
import '../../../../home/cubits/recent_transaction/recent_transaction_cubit.dart';
import '../../../../home/cubits/spend_frequency/spend_frequency_cubit.dart';
import '../../../cubits/transaction/transaction_cubit.dart';
import '../../../cubits/transactions/transactions_cubit.dart';
import '../../../data/models/transaction_model.dart';

class RemoveTransactionButton extends StatelessWidget {
  const RemoveTransactionButton(
    this.transaction, {
    super.key,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TransactionCubit, TransactionState>(
      listener: (context, state) {
        if (state is DeleteTransactionError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        } else if (state is DeleteTransactionSuccess) {
          context.read<TransactionsCubit>().loadAllTransactions();
          context.read<AccountBalanceCubit>().loadAccountBalance();
          context.read<SpendFrequencyCubit>().loadSpendFrequency();
          context.read<RecentTransactionCubit>().loadRecentTransactions();
          context.goNamed(AppRouter.transaction);
        }
      },
      builder: (context, state) {
        if (state is DeletingTransaction) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.violet100),
          );
        } else {
          return LargePrimaryButton(
            label: 'Yes',
            onPressed: () =>
                context.read<TransactionCubit>().deleteTransaction(transaction),
          );
        }
      },
    );
  }
}
