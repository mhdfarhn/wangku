import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SecondaryDialogButton extends StatelessWidget {
  final String label;
  final void Function() onPressed;
  const SecondaryDialogButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.deepPurpleAccent.shade100,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.dm),
        ),
      ),
      child: Text(label),
    );
  }
}
