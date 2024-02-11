import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../constants/app_colors.dart';

class LargeInputField extends StatelessWidget {
  final TextEditingController controller;

  const LargeInputField(
    this.controller, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '\$',
          style: TextStyle(
            color: AppColors.light80,
            fontSize: 61.sp,
          ),
        ),
        Gap(8.w),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              hintText: '0',
              hintStyle: TextStyle(
                color: AppColors.light80,
                fontSize: 64.sp,
              ),
            ),
            keyboardType: TextInputType.number,
            style: TextStyle(
              color: AppColors.light80,
              fontSize: 64.sp,
            ),
          ),
        ),
      ],
    );
  }
}
