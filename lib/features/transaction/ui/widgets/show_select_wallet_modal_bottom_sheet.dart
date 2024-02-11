import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../wallet/cubits/wallets/wallets_cubit.dart';
import '../../../wallet/data/models/wallet_model.dart';
import '../../cubits/select_wallet_cubit.dart';

Future<dynamic> showSelectWalletModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return BlocBuilder<WalletsCubit, WalletsState>(
            builder: (context, state) {
              if (state is LoadWalletsError) {
                return Center(
                  child: Text(
                    state.error,
                    style:
                        AppTextStyles.body1.copyWith(color: AppColors.dark50),
                  ),
                );
              } else if (state is LoadingWallets) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.violet100),
                );
              } else if (state is LoadWalletsSuccess) {
                final wallets = state.wallets;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      wallets.length,
                      (index) {
                        final wallet = wallets[index];
                        return InkWell(
                          onTap: () {
                            context
                                .read<SelectWalletCubit>()
                                .selectWallet(wallet);
                            context.pop();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(color: AppColors.light60),
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  height: 48.h,
                                  width: 48.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16.dm),
                                    color: wallet.color.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      IconDataSolid(
                                          wallet.icon.icon!.codePoint),
                                      color: wallet.color,
                                      size: 24.sp,
                                    ),
                                  ),
                                ),
                                Gap(8.w),
                                Expanded(
                                  child: Text(
                                    wallet.name,
                                    style: AppTextStyles.title3
                                        .copyWith(color: AppColors.dark100),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  '\$${wallet.balance}',
                                  style: AppTextStyles.title3
                                      .copyWith(color: AppColors.dark100),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                BlocBuilder<SelectWalletCubit, WalletModel?>(
                                  builder: (context, state) {
                                    return state?.name == wallet.name
                                        ? Row(
                                            children: [
                                              Gap(8.w),
                                              FaIcon(
                                                FontAwesomeIcons.check,
                                                size: 24.sp,
                                                color: wallet.color,
                                              ),
                                            ],
                                          )
                                        : const SizedBox();
                                  },
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )..insert(
                        0,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 16.h,
                          ),
                          child: Text(
                            'Select Wallet',
                            style: AppTextStyles.title3
                                .copyWith(color: AppColors.dark100),
                          ),
                        ),
                      ),
                  ),
                );
              } else {
                return Container();
              }
            },
          );
        },
      );
    },
  );
}
