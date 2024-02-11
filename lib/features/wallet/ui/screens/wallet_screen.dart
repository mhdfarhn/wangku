import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_text_styles.dart';
import 'package:wangku/core/widgets/large_primary_button.dart';
import 'package:wangku/core/widgets/top_navigation.dart';
import 'package:wangku/features/home/cubits/account_balance/account_balance_cubit.dart';
import 'package:wangku/features/wallet/cubits/wallets/wallets_cubit.dart';
import 'package:wangku/features/wallet/ui/widgets/wallet_widgets.dart';

import '../../cubits/wallet/wallet_cubit.dart';

class WalletScreen extends StatelessWidget {
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AccountBalanceCubit>().state;

    return Scaffold(
      appBar: TopNavigation.half(
        title: 'Wallet',
        backgroundColor: AppColors.light100,
        foregroundColor: AppColors.dark50,
        statusBarColor: AppColors.light100,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      backgroundColor: AppColors.light100,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Gap(48.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      Text(
                        'Account balance',
                        style: AppTextStyles.body3
                            .copyWith(color: AppColors.light20),
                      ),
                      Gap(8.h),
                      Text(
                        state is LoadAccountBalanceSuccess
                            ? '\$${state.balance}'
                            : '\$0',
                        style: TextStyle(
                          color: AppColors.dark75,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(76.h),
                BlocBuilder<WalletsCubit, WalletsState>(
                  builder: (context, state) {
                    if (state is LoadWalletsError) {
                      return Center(
                        child: Text(
                          state.error,
                          style: AppTextStyles.body1
                              .copyWith(color: AppColors.dark100),
                        ),
                      );
                    } else if (state is LoadWalletsSuccess) {
                      final wallets = state.wallets;

                      if (wallets.isEmpty) {
                        return Center(
                          child: Text(
                            'You haven\'t added a wallet yet',
                            style: AppTextStyles.body1,
                            textAlign: TextAlign.center,
                          ),
                        );
                      } else {
                        return Column(
                          children: List.generate(
                            wallets.length,
                            (index) {
                              final wallet = wallets[index];

                              return WalletListTile(
                                wallet: wallet,
                                onTap: () {
                                  context
                                      .read<WalletCubit>()
                                      .loadWallet(wallet.id!);
                                  context.goNamed(
                                    AppRouter.detailWallet,
                                    pathParameters: {
                                      'id': wallet.id.toString()
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        );
                      }
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            child: SizedBox(
              width: double.infinity,
              child: LargePrimaryButton(
                label: 'Add new wallet',
                onPressed: () => context.goNamed(AppRouter.addWallet),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
