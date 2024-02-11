import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:wangku/core/widgets/large_primary_button.dart';
import 'package:wangku/core/widgets/top_navigation.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_enums.dart';
import '../../../../core/widgets/input_field.dart';
import '../../../authentication/cubits/authentication_cubit.dart';
import '../../cubits/account/account_cubit.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AccountCubit>();

    return Scaffold(
      backgroundColor: AppColors.violet100,
      appBar: TopNavigation.half(
        title: 'Add New Account',
        backgroundColor: AppColors.violet100,
        foregroundColor: AppColors.light100,
      ),
      body: Stack(
        children: [
          const SizedBox(height: double.infinity),
          Align(
            alignment: Alignment.bottomCenter,
            child: SingleChildScrollView(
              child: Form(
                key: _key,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(16.dm),
                        ),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Gap(8.h),
                          InputField(
                            hint: 'Name',
                            controller: _nameController,
                            keyboardType: TextInputType.name,
                          ),
                          Gap(32.h),
                          SizedBox(
                            width: double.infinity,
                            child: BlocConsumer<AccountCubit, AccountState>(
                              listener: (context, state) {
                                if (state is CreateAccountError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.error)),
                                  );
                                } else if (state is CreateAccountSuccess) {
                                  cubit.loadAccount();
                                  context
                                      .read<AuthenticationCubit>()
                                      .setAuthenticationStatus(
                                          AuthenticationStatus.accountCreated);
                                }
                              },
                              builder: (context, state) {
                                if (state is CreatingAccount) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                      color: AppColors.violet100,
                                    ),
                                  );
                                } else {
                                  return LargePrimaryButton(
                                    label: 'Create',
                                    onPressed: () {
                                      cubit.createAccount(
                                          _nameController.text.trim());
                                    },
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
