import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

import '../../features/category/cubits/categories/categories_cubit.dart';
import '../../features/wallet/cubits/wallets/wallets_cubit.dart';
import '../app_router.dart';
import '../constants/app_colors.dart';
import '../constants/app_enums.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const ScaffoldWithNestedNavigation({
    super.key,
    required this.navigationShell,
  });

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: location != '/' &&
              location != '/transaction' &&
              location != '/profile'
          ? null
          : NavigationBar(
              backgroundColor: AppColors.light100,
              indicatorColor: AppColors.violet100.withOpacity(0.1),
              surfaceTintColor: AppColors.light100,
              destinations: [
                NavigationDestination(
                  label: 'Home',
                  icon: FaIcon(
                    FontAwesomeIcons.house,
                    color: const Color(0xFFC6C6C6),
                    size: 20.sp,
                  ),
                  selectedIcon: FaIcon(
                    FontAwesomeIcons.house,
                    color: AppColors.violet100,
                    size: 20.sp,
                  ),
                  tooltip: 'Home',
                ),
                NavigationDestination(
                  label: 'Transaction',
                  icon: FaIcon(
                    FontAwesomeIcons.moneyBillTransfer,
                    color: const Color(0xFFC6C6C6),
                    size: 20.sp,
                  ),
                  selectedIcon: FaIcon(
                    FontAwesomeIcons.moneyBillTransfer,
                    color: AppColors.violet100,
                    size: 20.sp,
                  ),
                  tooltip: 'Transaction',
                ),
                NavigationDestination(
                  label: 'Profile',
                  icon: FaIcon(
                    FontAwesomeIcons.user,
                    color: const Color(0xFFC6C6C6),
                    size: 20.sp,
                  ),
                  selectedIcon: FaIcon(
                    FontAwesomeIcons.user,
                    color: AppColors.violet100,
                    size: 20.sp,
                  ),
                  tooltip: 'Profile',
                ),
              ],
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _goBranch,
            ),
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: location != '/' &&
              location != '/transaction' &&
              location != '/profile'
          ? null
          : ExpandableFab(
              distance: 60.w,
              childrenOffset: Offset(4.w, 16.h),
              openButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const FaIcon(FontAwesomeIcons.plus),
                backgroundColor: AppColors.violet100,
                foregroundColor: AppColors.light80,
                shape: const CircleBorder(),
              ),
              closeButtonBuilder: RotateFloatingActionButtonBuilder(
                child: const FaIcon(FontAwesomeIcons.xmark),
                backgroundColor: AppColors.violet100,
                foregroundColor: AppColors.light80,
                shape: const CircleBorder(),
              ),
              type: ExpandableFabType.up,
              children: [
                FloatingActionButton.small(
                  backgroundColor: AppColors.red100,
                  foregroundColor: AppColors.light100,
                  shape: const CircleBorder(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowUp,
                        size: 10.sp,
                      ),
                      FaIcon(
                        FontAwesomeIcons.moneyBill,
                        size: 18.sp,
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.goNamed(
                      AppRouter.addTransaction,
                      queryParameters: {'type': 'expense'},
                    );
                    context
                        .read<CategoriesCubit>()
                        .loadCategoriesByType(TransactionType.expense);
                    context.read<WalletsCubit>().loadWallets();
                  },
                ),
                FloatingActionButton.small(
                  backgroundColor: AppColors.green100,
                  foregroundColor: AppColors.light100,
                  shape: const CircleBorder(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.arrowDown,
                        size: 10.sp,
                      ),
                      FaIcon(
                        FontAwesomeIcons.moneyBill,
                        size: 18.sp,
                      ),
                    ],
                  ),
                  onPressed: () {
                    context.goNamed(
                      AppRouter.addTransaction,
                      queryParameters: {'type': 'income'},
                    );
                    context
                        .read<CategoriesCubit>()
                        .loadCategoriesByType(TransactionType.income);
                    context.read<WalletsCubit>().loadWallets();
                  },
                ),
              ],
            ),
    );
  }
}
