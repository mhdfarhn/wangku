import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../../../core/widgets/date_time_input_field.dart';
import '../../../../../core/widgets/input_field.dart';
import '../add_image_widget.dart';
import '../select_category_button.dart';
import '../select_wallet_button.dart';

class DetailTransactionSection extends StatelessWidget {
  const DetailTransactionSection({
    super.key,
    required this.descriptionController,
    required this.dateController,
    required this.timeController,
    required this.onDateInputTapped,
    required this.onTimeInputTapped,
  });

  final TextEditingController descriptionController;
  final TextEditingController dateController;
  final TextEditingController timeController;
  final void Function() onDateInputTapped;
  final void Function() onTimeInputTapped;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SelectCategoryButton(),
          Gap(16.h),
          InputField(
            hint: 'Description',
            controller: descriptionController,
            keyboardType: TextInputType.text,
          ),
          Gap(16.h),
          const SelectWalletButton(),
          Gap(16.h),
          const AddImageWidget(),
          Gap(16.h),
          Row(
            children: [
              Expanded(
                child: DateTimeInputField(
                  controller: dateController,
                  hint: 'Date',
                  onTap: onDateInputTapped,
                ),
              ),
              Gap(8.w),
              Expanded(
                child: DateTimeInputField(
                  controller: timeController,
                  hint: 'Time',
                  onTap: onTimeInputTapped,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
