import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../cubits/image_cubit.dart';

class AddImageWidget extends StatelessWidget {
  const AddImageWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImageCubit, String>(
      builder: (context, state) {
        if (state != '') {
          return SizedBox(
            height: 116.h,
            width: 116.h,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.dm),
                    child: Image.file(
                      File(state),
                      height: 112.h,
                      width: 112.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: InkWell(
                    onTap: () => context.read<ImageCubit>().removeImage(),
                    borderRadius: BorderRadius.circular(12.dm),
                    child: CircleAvatar(
                      radius: 12.dg,
                      backgroundColor: AppColors.dark100.withOpacity(0.32),
                      child: FaIcon(
                        FontAwesomeIcons.xmark,
                        color: AppColors.light100,
                        size: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return InkWell(
            onTap: () {
              showModalBottomSheet(
                backgroundColor: AppColors.light100,
                showDragHandle: true,
                context: context,
                builder: (context) {
                  return BottomSheet(
                    onClosing: () {},
                    builder: (context) {
                      final imageCubit = context.read<ImageCubit>();
                      return Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 16.w,
                          vertical: 16.h,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SquircleIconButton(
                              label: 'Camera',
                              icon: const FaIcon(FontAwesomeIcons.camera),
                              onTap: () {
                                imageCubit.getImage(ImageSource.camera);
                                context.pop();
                              },
                            ),
                            Gap(8.w),
                            SquircleIconButton(
                              label: 'Gallery',
                              icon: const FaIcon(FontAwesomeIcons.image),
                              onTap: () {
                                imageCubit.getImage(ImageSource.gallery);
                                context.pop();
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.light100,
                borderRadius: BorderRadius.circular(16.dm),
                border: Border.all(color: AppColors.light60),
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FaIcon(
                    FontAwesomeIcons.image,
                    color: AppColors.light20,
                    size: 24.sp,
                  ),
                  Gap(10.w),
                  Text(
                    'Add image',
                    style: TextStyle(
                      color: AppColors.light20,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class SquircleIconButton extends StatelessWidget {
  final String label;
  final FaIcon icon;
  final void Function() onTap;

  const SquircleIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.dm),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.violet100.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16.dm),
        ),
        height: 92.h,
        width: 92.h,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FaIcon(
              IconDataSolid(icon.icon!.codePoint),
              size: 24.sp,
              color: AppColors.violet100,
            ),
            Gap(8.h),
            Text(
              label,
              style: AppTextStyles.body2.copyWith(
                color: AppColors.violet100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
