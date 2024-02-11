import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/features/category/data/models/category_model.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../category/cubits/categories/categories_cubit.dart';
import '../../cubits/select_category_cubit.dart';

Future<dynamic> showSelectCategoryModalBottomSheet(BuildContext context) {
  return showModalBottomSheet(
    showDragHandle: true,
    context: context,
    builder: (context) {
      return BottomSheet(
        onClosing: () {},
        builder: (context) {
          return BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is LoadCategoriesError) {
                return Center(
                  child: Text(
                    state.error,
                    style:
                        AppTextStyles.body1.copyWith(color: AppColors.dark50),
                  ),
                );
              } else if (state is LoadingCategories) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.violet100),
                );
              } else if (state is LoadCategoriesSuccess) {
                final categories = state.categories;
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      categories.length,
                      (index) {
                        final category = categories[index];
                        return InkWell(
                          onTap: () {
                            context
                                .read<SelectCategoryCubit>()
                                .selectCategory(category);
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
                                    color: category.color.withOpacity(0.2),
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      IconDataSolid(
                                          category.icon.icon!.codePoint),
                                      color: category.color,
                                      size: 24.sp,
                                    ),
                                  ),
                                ),
                                Gap(8.w),
                                Expanded(
                                  child: Text(
                                    category.name,
                                    style: AppTextStyles.title3
                                        .copyWith(color: AppColors.dark100),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                BlocBuilder<SelectCategoryCubit,
                                    CategoryModel?>(
                                  builder: (context, state) {
                                    return state?.name == category.name
                                        ? Column(
                                            children: [
                                              Gap(8.w),
                                              FaIcon(
                                                FontAwesomeIcons.check,
                                                size: 24.sp,
                                                color: category.color,
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
                            'Select Category',
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
