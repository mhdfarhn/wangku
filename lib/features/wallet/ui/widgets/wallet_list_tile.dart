import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../data/models/wallet_model.dart';

class WalletListTile extends StatelessWidget {
  final WalletModel wallet;
  final void Function() onTap;

  const WalletListTile({
    super.key,
    required this.wallet,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                color: wallet.color.withOpacity(0.1),
              ),
              child: Center(
                child: FaIcon(
                  IconDataSolid(wallet.icon.icon!.codePoint),
                  color: wallet.color,
                  size: 24.sp,
                ),
              ),
            ),
            Gap(8.w),
            Expanded(
              child: Text(
                wallet.name,
                style: AppTextStyles.title3.copyWith(color: AppColors.dark100),
              ),
            ),
            Gap(8.w),
            Text(
              '\$${wallet.balance}',
              style: AppTextStyles.title3.copyWith(color: AppColors.dark50),
            ),
          ],
        ),
      ),
    );
  }
}
