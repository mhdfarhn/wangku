import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/features/profile/cubits/account/account_cubit.dart';
import 'package:wangku/features/profile/ui/widgets/profile_option_list_tile.dart';

import '../../../../core/constants/app_text_styles.dart';
import '../../../category/cubits/categories/categories_cubit.dart';
import '../../../wallet/cubits/wallets/wallets_cubit.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.read<AccountCubit>().state;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFF6F6F6),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      backgroundColor: const Color(0xFFF6F6F6),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.violet60,
                    radius: 40.dg,
                    child: FaIcon(
                      FontAwesomeIcons.user,
                      color: AppColors.light100,
                      size: 28.sp,
                    ),
                  ),
                  Gap(16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Username',
                          style: AppTextStyles.body3
                              .copyWith(color: AppColors.light20),
                        ),
                        Gap(8.h),
                        Text(
                          state is LoadAccountSuccess ? state.name : '...',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.title2
                              .copyWith(color: AppColors.dark75),
                        ),
                      ],
                    ),
                  ),
                  Gap(16.w),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(18.dm),
                    child: Padding(
                      padding: EdgeInsets.all(8.dg),
                      child: FaIcon(
                        FontAwesomeIcons.pen,
                        color: AppColors.dark50,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(36.h),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.dm),
                color: AppColors.light100,
              ),
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: ListTile.divideTiles(
                  context: context,
                  color: Colors.grey.withOpacity(0.1),
                  tiles: [
                    ProfileOptionListTile(
                      title: 'Wallet',
                      iconData: FontAwesomeIcons.wallet,
                      iconColor: AppColors.violet100,
                      iconBackgroundColor: AppColors.violet20,
                      onTap: () {
                        context.read<WalletsCubit>().loadWallets();
                        context.goNamed(AppRouter.wallet);
                      },
                    ),
                    ProfileOptionListTile(
                      title: 'Category',
                      iconData: FontAwesomeIcons.icons,
                      iconColor: AppColors.violet100,
                      iconBackgroundColor: AppColors.violet20,
                      onTap: () {
                        context.read<CategoriesCubit>().loadCategories();
                        context.goNamed(AppRouter.category);
                      },
                    ),
                    ProfileOptionListTile(
                      title: 'Settings',
                      iconData: FontAwesomeIcons.gear,
                      iconColor: AppColors.violet100,
                      iconBackgroundColor: AppColors.violet20,
                      onTap: () {},
                    ),
                    ProfileOptionListTile(
                      title: 'Export Data',
                      iconData: FontAwesomeIcons.upload,
                      iconColor: AppColors.violet100,
                      iconBackgroundColor: AppColors.violet20,
                      onTap: () {},
                    ),
                  ],
                ).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
