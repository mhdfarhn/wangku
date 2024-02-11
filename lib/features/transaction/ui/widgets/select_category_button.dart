import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_text_styles.dart';
import 'package:wangku/features/category/data/models/category_model.dart';
import 'package:wangku/features/transaction/ui/widgets/show_select_category_modal_bottom_sheet.dart';

import '../../cubits/select_category_cubit.dart';

class SelectCategoryButton extends StatelessWidget {
  const SelectCategoryButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => showSelectCategoryModalBottomSheet(context),
      borderRadius: BorderRadius.circular(16.dm),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.light100,
          border: Border.all(color: AppColors.light60),
          borderRadius: BorderRadius.circular(16.dm),
        ),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical:
              context.read<SelectCategoryCubit>().state != null ? 8.h : 16.h,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocBuilder<SelectCategoryCubit, CategoryModel?>(
              builder: (context, state) {
                return state != null
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.light60),
                          borderRadius: BorderRadius.circular(32.dm),
                          color: AppColors.light80,
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 8.w,
                          vertical: 8.h,
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: state.color,
                              radius: 8.dg,
                            ),
                            Gap(8.w),
                            Text(
                              state.name,
                              style: AppTextStyles.body3
                                  .copyWith(color: AppColors.dark50),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        'Category',
                        style: TextStyle(
                          color: AppColors.light20,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      );
              },
            ),
            FaIcon(
              FontAwesomeIcons.angleDown,
              color: AppColors.light20,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
