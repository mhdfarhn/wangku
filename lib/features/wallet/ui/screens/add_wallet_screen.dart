import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/constants/app_lists.dart';
import 'package:wangku/core/constants/app_text_styles.dart';
import 'package:wangku/core/widgets/input_field.dart';
import 'package:wangku/core/widgets/large_primary_button.dart';
import 'package:wangku/core/widgets/top_navigation.dart';
import 'package:wangku/features/authentication/cubits/authentication_cubit.dart';
import 'package:wangku/features/home/cubits/account_balance/account_balance_cubit.dart';
import 'package:wangku/features/wallet/cubits/wallets/wallets_cubit.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';
import 'package:wangku/features/wallet/ui/widgets/wallet_widgets.dart';

import '../../../../core/constants/app_enums.dart';
import '../../../../core/widgets/large_input_field.dart';

class AddWalletScreen extends StatefulWidget {
  const AddWalletScreen({super.key});

  @override
  State<AddWalletScreen> createState() => _AddWalletScreenState();
}

class _AddWalletScreenState extends State<AddWalletScreen> {
  final _key = GlobalKey<FormState>();
  final _balanceController = TextEditingController();
  final _nameController = TextEditingController();
  FaIcon? _icon;
  Color? _color;

  @override
  void dispose() {
    _balanceController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.violet100,
      appBar: TopNavigation.half(
        title: 'Add New Wallet',
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
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Balance',
                            style: AppTextStyles.title3.copyWith(
                              color: AppColors.light80.withOpacity(0.64),
                            ),
                            textAlign: TextAlign.start,
                          ),
                          LargeInputField(_balanceController),
                        ],
                      ),
                    ),
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
                          Gap(16.h),
                          Text(
                            'Icon',
                            style: AppTextStyles.body1
                                .copyWith(color: AppColors.dark100),
                          ),
                          Gap(8.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: List.generate(
                              AppLists.walletIcon.length,
                              (index) {
                                final icons = AppLists.walletIcon;
                                return WalletIconChip(
                                  onTap: () =>
                                      setState(() => _icon = icons[index]),
                                  icon: icons[index],
                                  selectedIcon: _icon,
                                  color: _color,
                                );
                              },
                            ),
                          ),
                          Gap(16.h),
                          Text(
                            'Color',
                            style: AppTextStyles.body1
                                .copyWith(color: AppColors.dark100),
                          ),
                          Gap(8.h),
                          Wrap(
                            spacing: 8.w,
                            runSpacing: 8.h,
                            children: List.generate(
                              AppLists.color.length,
                              (index) {
                                final colors = AppLists.color;
                                return WalletColorChip(
                                  onTap: () =>
                                      setState(() => _color = colors[index]),
                                  color: colors[index],
                                  selectedColor: _color,
                                );
                              },
                            ),
                          ),
                          Gap(32.h),
                          SizedBox(
                            width: double.infinity,
                            child: BlocConsumer<WalletsCubit, WalletsState>(
                              listener: (context, state) {
                                if (state is AddWalletError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.error)),
                                  );
                                } else if (state is AddWalletSuccess) {
                                  context.read<WalletsCubit>().loadWallets();
                                  context
                                      .read<AccountBalanceCubit>()
                                      .loadAccountBalance();
                                  _nameController.clear();
                                  _balanceController.clear();
                                  final path =
                                      GoRouterState.of(context).uri.path;
                                  if (path == '/onboarding/create-wallet') {
                                    context
                                        .read<AuthenticationCubit>()
                                        .setAuthenticationStatus(
                                            AuthenticationStatus.signedIn);
                                  } else {
                                    context.goNamed(AppRouter.wallet);
                                  }
                                }
                              },
                              builder: (context, state) {
                                if (state is AddingWallet) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.violet100),
                                  );
                                } else {
                                  return LargePrimaryButton(
                                    label: 'Add',
                                    onPressed: () {
                                      if (_key.currentState!.validate() &&
                                          _icon != null &&
                                          _color != null) {
                                        context.read<WalletsCubit>().addWallet(
                                              WalletModel(
                                                name:
                                                    _nameController.text.trim(),
                                                balance: int.parse(
                                                    _balanceController.text
                                                        .trim()),
                                                icon: _icon!,
                                                color: _color!,
                                                createdAt: DateTime.now(),
                                                updatedAt: DateTime.now(),
                                              ),
                                            );
                                      }
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
