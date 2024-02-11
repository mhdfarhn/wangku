import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants/app_colors.dart';

class AddTransactionButton extends StatelessWidget {
  final void Function() onPressed;
  final FaIcon icon;
  final Color backgroundColor;
  const AddTransactionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      color: backgroundColor,
      child: IconButton(
        onPressed: onPressed,
        icon: Column(
          children: [
            FaIcon(
              icon.icon,
              size: 12.sp,
            ),
            FaIcon(
              FontAwesomeIcons.moneyBill,
              size: 20.sp,
            ),
          ],
        ),
        color: AppColors.light100,
      ),
    );
  }
}
