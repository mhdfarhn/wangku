import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_text_styles.dart';
import '../../../profile/cubits/account/account_cubit.dart';
import '../widgets/account_info_section.dart';
import '../widgets/recent_transaction_section.dart';
import '../widgets/spend_frequency_section.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.light100,
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFF6E5),
        surfaceTintColor: const Color(0xFFFFF6E5),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFFFFF6E5),
          statusBarBrightness: Brightness.light,
          statusBarIconBrightness: Brightness.dark,
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 16.r,
              backgroundColor: AppColors.violet60,
              child: FaIcon(
                FontAwesomeIcons.user,
                color: AppColors.light100,
                size: 16.sp,
              ),
            ),
            Gap(8.w),
            BlocBuilder<AccountCubit, AccountState>(
              builder: (context, state) {
                return Text(
                  state is LoadAccountSuccess ? state.name : 'No Name',
                  style: AppTextStyles.title3,
                );
              },
            ),
          ],
        ),
      ),
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AccountInfoSection(),
              SpendFrequencySection(),
              RecentTransactionSection(),
            ],
          ),
        ),
      ),
    );
  }
}
