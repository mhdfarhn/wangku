import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangku/core/constants/app_colors.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;

  const InputField({
    super.key,
    required this.hint,
    required this.controller,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: AppColors.violet100,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        hintText: hint,
        hintStyle: TextStyle(
          color: AppColors.light20,
          fontWeight: FontWeight.w400,
          fontSize: 16.sp,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: const BorderSide(color: AppColors.light60),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: const BorderSide(color: AppColors.light60),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: const BorderSide(color: AppColors.violet100),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.dm),
          borderSide: const BorderSide(color: AppColors.red100),
        ),
      ),
      keyboardType: keyboardType,
      style: TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        color: AppColors.dark100,
      ),
      validator: (value) => value == null || value.isEmpty
          ? 'Please enter ${hint.toLowerCase()}'
          : null,
    );
  }
}
