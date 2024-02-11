import 'dart:io';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../core/constants/app_colors.dart';
import '../../../../../core/constants/app_text_styles.dart';
import '../../../data/models/transaction_model.dart';

class DescriptionAndImageSection extends StatelessWidget {
  const DescriptionAndImageSection(
    this.transaction, {
    super.key,
  });

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(16.h),
          DottedLine(
            dashColor: Colors.grey.shade300,
            dashRadius: 2.dm,
            dashLength: 8.w,
            dashGapLength: 4.w,
            lineThickness: 2.sp,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'Description',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.light20,
              ),
            ),
          ),
          Text(
            transaction.description,
            style: AppTextStyles.body1.copyWith(color: AppColors.dark100),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'Image',
              style: AppTextStyles.body2.copyWith(
                color: AppColors.light20,
              ),
            ),
          ),
          transaction.imagePath != ''
              ? ClipRRect(
                  borderRadius: BorderRadius.circular(12.dm),
                  child: Image.file(
                    File(transaction.imagePath),
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) {
                      return Text(
                        'Can\'t load image\nYour image may be deleted accidentally',
                        style: AppTextStyles.body1
                            .copyWith(color: AppColors.dark100),
                      );
                    },
                  ),
                )
              : Text(
                  'You didn\'t add an image',
                  style: AppTextStyles.body1.copyWith(color: AppColors.dark100),
                ),
          Gap(16.h),
        ],
      ),
    );
  }
}
