import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InputFieldButton extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final void Function() onTap;
  const InputFieldButton({
    super.key,
    required this.hint,
    required this.controller,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.arrow_drop_down),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.dm),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.dm),
          borderSide: const BorderSide(color: Colors.redAccent),
        ),
      ),
      onTap: onTap,
      validator: (value) => value == null || value.isEmpty
          ? 'Please select ${hint.toLowerCase()}'
          : null,
    );
  }
}
