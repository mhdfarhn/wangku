import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/widgets/large_primary_button.dart';
import 'package:wangku/features/onboarding/cubits/onboarding_cubit.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enums.dart';
import '../../../../core/constants/app_images.dart';
import '../../../authentication/cubits/authentication_cubit.dart';
import '../widgets/onboarding_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.light100,
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return BlocListener<AuthenticationCubit, AuthenticationStatus>(
      listener: (context, state) {
        GoRouter.of(context).refresh();
      },
      child: Scaffold(
        backgroundColor: AppColors.light100,
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: PageView(
                  controller: _controller,
                  onPageChanged: (value) =>
                      context.read<OnboardingCubit>().updateIndex(value),
                  children: const [
                    OnboardingContent(
                      image: AppImages.onboarding1,
                      title: 'Gain your total control of your money',
                      description:
                          'Become your own money managerr and make every cent count',
                    ),
                    OnboardingContent(
                      image: AppImages.onboarding2,
                      title: 'Know where your money goes',
                      description:
                          'Track your transaction easily, with categories and financial report',
                    ),
                    OnboardingContent(
                      image: AppImages.onboarding3,
                      title: 'Planning ahead',
                      description:
                          'Setup your budget for each category so you in control',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: 8.w,
                  right: 8.w,
                  bottom: 16.h,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) => Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      child: BlocBuilder<OnboardingCubit, int>(
                        builder: (context, state) {
                          return CircleAvatar(
                            radius: state == index ? 10.dg : 6.dg,
                            backgroundColor: state == index
                                ? AppColors.violet100
                                : AppColors.light40,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                width: double.infinity,
                child: LargePrimaryButton(
                  label: 'Create Account',
                  onPressed: () => context.goNamed(AppRouter.createAccount),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
