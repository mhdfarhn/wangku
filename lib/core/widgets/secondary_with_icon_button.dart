import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class SecondaryWithIconButton extends StatelessWidget {
  final String label;
  final Icon icon;
  final void Function() onPressed;

  const SecondaryWithIconButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent,
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.h,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.dm),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          Gap(8.w),
          Text(label),
        ],
      ),
    );
  }
}
