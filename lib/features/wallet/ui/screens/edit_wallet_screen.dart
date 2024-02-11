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
import 'package:wangku/features/wallet/cubits/wallet/wallet_cubit.dart';
import 'package:wangku/features/wallet/cubits/wallets/wallets_cubit.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';

import '../../../../core/widgets/large_input_field.dart';
import '../../../../core/widgets/show_confirmation_modal_button_sheet.dart';
import '../widgets/wallet_widgets.dart';

class EditWalletScreen extends StatefulWidget {
  final WalletModel wallet;

  const EditWalletScreen(this.wallet, {super.key});

  @override
  State<EditWalletScreen> createState() => _EditWalletScreenState();
}

class _EditWalletScreenState extends State<EditWalletScreen> {
  final _key = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _balanceController = TextEditingController();

  late FaIcon _icon;
  late Color _color;

  @override
  void initState() {
    _nameController.text = widget.wallet.name;
    _balanceController.text = widget.wallet.balance.toString();
    _icon = FaIcon(IconDataSolid(widget.wallet.icon.icon!.codePoint));
    _color = widget.wallet.color;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _balanceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.violet100,
      appBar: TopNavigation.full(
        title: 'Edit Wallet',
        backgroundColor: AppColors.violet100,
        foregroundColor: AppColors.light100,
        icon: InkWell(
          borderRadius: BorderRadius.circular(26.dm),
          onTap: () {
            showConfirmationModalBottomSheet(
              context: context,
              title: 'Remove this wallet?',
              description: 'Are you sure want to delete this wallet?',
              confirmButton: BlocConsumer<WalletCubit, WalletState>(
                listener: (context, state) {
                  if (state is DeleteWalletError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  } else if (state is DeleteWalletSuccess) {
                    context.read<WalletsCubit>().loadWallets();
                    context.goNamed(AppRouter.wallet);
                  }
                },
                builder: (context, state) {
                  if (state is DeletingWallet) {
                    return const Center(
                      child:
                          CircularProgressIndicator(color: AppColors.violet100),
                    );
                  } else {
                    return LargePrimaryButton(
                      label: 'Yes',
                      onPressed: () {
                        context
                            .read<WalletCubit>()
                            .deleteWallet(widget.wallet.id!);
                      },
                    );
                  }
                },
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
            child: FaIcon(
              FontAwesomeIcons.trash,
              size: 16.sp,
            ),
          ),
        ),
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
                            child: BlocConsumer<WalletCubit, WalletState>(
                              listener: (context, state) {
                                if (state is UpdateWalletError) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(state.error)),
                                  );
                                } else if (state is UpdateWalletSuccess) {
                                  _nameController.clear();
                                  _balanceController.clear();
                                  context
                                      .read<WalletCubit>()
                                      .loadWallet(widget.wallet.id!);
                                  context.read<WalletsCubit>().loadWallets();
                                  context.goNamed(
                                    AppRouter.detailWallet,
                                    pathParameters: {
                                      'id': widget.wallet.id.toString()
                                    },
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is UpdatingWallet) {
                                  return const Center(
                                    child: CircularProgressIndicator(
                                        color: AppColors.violet100),
                                  );
                                }
                                return LargePrimaryButton(
                                  label: 'Update',
                                  onPressed: () {
                                    if (_key.currentState!.validate()) {
                                      context.read<WalletCubit>().updateWallet(
                                            widget.wallet.copyWith(
                                              id: widget.wallet.id,
                                              name: _nameController.text,
                                              balance: int.parse(
                                                  _balanceController.text
                                                      .trim()),
                                              icon: _icon,
                                              color: _color,
                                              updatedAt: DateTime.now(),
                                            ),
                                          );
                                    }
                                  },
                                );
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
