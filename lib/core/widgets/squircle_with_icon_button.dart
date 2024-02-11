// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:gap/gap.dart';
//
// class SquircleWithIconButton extends StatelessWidget {
//   final String label;
//   final IconData iconData;
//   final void Function() onTap;
//   const SquircleWithIconButton({
//     super.key,
//     required this.label,
//     required this.iconData,
//     required this.onTap,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(12.dm),
//       child: Container(
//         height: 80.h,
//         width: 80.h,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12.dm),
//           color: Colors.deepPurpleAccent.withOpacity(0.1),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(
//               iconData,
//               color: Colors.deepPurpleAccent,
//               size: 32.sp,
//             ),
//             Gap(4.h),
//             Text(
//               label,
//               style: TextStyle(
//                 color: Colors.deepPurpleAccent,
//                 fontSize: 16.sp,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
