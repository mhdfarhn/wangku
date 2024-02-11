import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropdownField extends StatefulWidget {
  final String hint;
  final List items;
  final String? Function(Object?) validator;

  const DropdownField({
    super.key,
    required this.hint,
    required this.items,
    required this.validator,
  });

  @override
  State<DropdownField> createState() => _DropdownFieldState();
}

class _DropdownFieldState extends State<DropdownField> {
  Object? _value;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.dm),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(12.dm),
        ),
      ),
      hint: Text(widget.hint),
      items: List.generate(
        widget.items.length,
        (index) => DropdownMenuItem(
          value: widget.items[index],
          child: Text(widget.items[index].name),
        ),
      ),
      onChanged: (value) => _value = value,
      validator: widget.validator,
      value: _value,
    );
  }
}
