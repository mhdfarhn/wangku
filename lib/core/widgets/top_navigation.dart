import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_text_styles.dart';

class TopNavigation {
  static AppBar full({
    required String title,
    required Color backgroundColor,
    required Color foregroundColor,
    required Widget icon,
    Color? statusBarColor,
    Brightness? statusBarBrightness,
    Brightness? statusBarIconBrightness,
  }) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: backgroundColor,
      title: Text(
        title,
        style: AppTextStyles.title3,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.violet100,
        statusBarBrightness: statusBarBrightness ?? Brightness.dark,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
      ),
      actions: [
        icon,
      ],
    );
  }

  static AppBar half({
    required String title,
    required Color backgroundColor,
    required Color foregroundColor,
    bool? automaticallyImplyLeading,
    Color? statusBarColor,
    Brightness? statusBarBrightness,
    Brightness? statusBarIconBrightness,
  }) {
    return AppBar(
      automaticallyImplyLeading: automaticallyImplyLeading ?? true,
      centerTitle: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: backgroundColor,
      title: Text(
        title,
        style: AppTextStyles.title3,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.violet100,
        statusBarBrightness: statusBarBrightness ?? Brightness.dark,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
      ),
    );
  }

  static AppBar transaction() {
    return AppBar(
      centerTitle: true,
      backgroundColor: AppColors.light100,
      foregroundColor: AppColors.dark50,
      surfaceTintColor: AppColors.light100,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColors.light100,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
      title: Text(
        'Transaction',
        style: AppTextStyles.title3,
      ),
    );
  }

  static AppBar halfWithTabBar({
    required String title,
    required Color backgroundColor,
    required Color foregroundColor,
    required TabBar tabBar,
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Brightness? statusBarBrightness,
  }) {
    return AppBar(
      centerTitle: true,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      surfaceTintColor: backgroundColor,
      title: Text(
        title,
        style: AppTextStyles.title3,
      ),
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: statusBarColor ?? AppColors.violet100,
        statusBarBrightness: statusBarBrightness ?? Brightness.dark,
        statusBarIconBrightness: statusBarIconBrightness ?? Brightness.light,
      ),
      bottom: tabBar,
    );
  }
}
