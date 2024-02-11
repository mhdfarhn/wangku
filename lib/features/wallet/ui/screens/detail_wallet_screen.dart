import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_enums.dart';
import 'package:wangku/core/constants/app_text_styles.dart';
import 'package:wangku/core/widgets/top_navigation.dart';
import 'package:wangku/features/category/data/models/category_model.dart';
import 'package:wangku/features/transaction/data/models/transaction_model.dart';
import 'package:wangku/features/transaction/ui/widgets/transaction_card.dart';
import 'package:wangku/features/wallet/cubits/wallet/wallet_cubit.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';

class DetailWalletScreen extends StatelessWidget {
  const DetailWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light100,
      appBar: TopNavigation.full(
        title: 'Detail Wallet',
        backgroundColor: AppColors.light100,
        foregroundColor: AppColors.dark50,
        statusBarColor: AppColors.light100,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        icon: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            return InkWell(
              borderRadius: BorderRadius.circular(26.dm),
              onTap: () {
                if (state is LoadWalletSuccess) {
                  context.goNamed(
                    AppRouter.editWallet,
                    pathParameters: {'id': state.wallet.id.toString()},
                    extra: state.wallet,
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                child: FaIcon(
                  FontAwesomeIcons.pen,
                  size: 16.sp,
                ),
              ),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          Gap(32.h),
          BlocBuilder<WalletCubit, WalletState>(
            builder: (context, state) {
              return Column(
                children: [
                  Container(
                    height: 48.h,
                    width: 48.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.dm),
                        color: state is LoadWalletSuccess
                            ? state.wallet.color.withOpacity(0.1)
                            : AppColors.violet100.withOpacity(0.1)),
                    child: Center(
                      child: state is LoadWalletSuccess
                          ? FaIcon(
                              IconDataSolid(state.wallet.icon.icon!.codePoint),
                              color: state.wallet.color,
                              size: 24.sp,
                            )
                          : Icon(
                              Icons.wallet,
                              color: AppColors.violet100,
                              size: 24.sp,
                            ),
                    ),
                  ),
                  Gap(8.h),
                  Text(
                    state is LoadWalletSuccess ? state.wallet.name : '...',
                    style:
                        AppTextStyles.title2.copyWith(color: AppColors.dark100),
                  ),
                  Gap(8.h),
                  Text(
                    state is LoadWalletSuccess
                        ? '\$${state.wallet.balance}'
                        : '\$0',
                    style:
                        AppTextStyles.title1.copyWith(color: AppColors.dark50),
                  ),
                ],
              );
            },
          ),
          Gap(48.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                child: Text(
                  'Today',
                  style:
                      AppTextStyles.title3.copyWith(color: AppColors.dark100),
                ),
              ),
            ],
          ),
          TransactionCard(
            transaction: TransactionModel(
              type: TransactionType.income,
              amount: 1000,
              category: CategoryModel(
                id: 1,
                name: 'Allowance',
                transactionType: TransactionType.income,
                icon: const FaIcon(FontAwesomeIcons.coins),
                color: AppColors.violet100,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
              description: 'Description',
              wallet: WalletModel(
                id: 1,
                name: 'Allowance',
                balance: 1000,
                icon: const FaIcon(FontAwesomeIcons.coins),
                color: AppColors.violet100,
                createdAt: DateTime.now(),
                updatedAt: DateTime.now(),
              ),
              imagePath: '',
              dateTime: DateTime.now(),
              createdAt: DateTime.now(),
              updatedAt: DateTime.now(),
            ),
          ),
          Gap(8.h),
        ],
      ),
    );
  }
}
