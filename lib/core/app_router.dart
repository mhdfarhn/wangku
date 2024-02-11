import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wangku/core/widgets/scaffold_with_nested_navigation.dart';
import 'package:wangku/features/authentication/cubits/authentication_cubit.dart';
import 'package:wangku/features/category/ui/screens/category_screen.dart';
import 'package:wangku/features/home/ui/screens/home_screen.dart';
import 'package:wangku/features/onboarding/ui/screens/onboarding_screen.dart';
import 'package:wangku/features/profile/ui/screens/create_account_screen.dart';
import 'package:wangku/features/profile/ui/screens/profile_screen.dart';
import 'package:wangku/features/transaction/ui/screens/add_transaction_screen.dart';
import 'package:wangku/features/transaction/ui/screens/detail_transaction_screen.dart';
import 'package:wangku/features/transaction/ui/screens/edit_transaction_screen.dart';
import 'package:wangku/features/transaction/ui/screens/transaction_screen.dart';
import 'package:wangku/features/wallet/data/models/wallet_model.dart';
import 'package:wangku/features/wallet/ui/screens/add_wallet_screen.dart';
import 'package:wangku/features/wallet/ui/screens/detail_wallet_screen.dart';
import 'package:wangku/features/wallet/ui/screens/edit_wallet_screen.dart';
import 'package:wangku/features/wallet/ui/screens/wallet_screen.dart';

import '../features/transaction/data/models/transaction_model.dart';
import 'constants/app_enums.dart';

class AppRouter {
  static final _rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Root Navigator');
  static final _homeNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Home Navigator');
  static final _transactionNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Transaction Navigator');
  static final _profileNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'Profile Navigator');

  static const home = 'home';
  static const transaction = 'transaction';
  static const addTransaction = 'addTransaction';
  static const detailTransaction = 'detailTransaction';
  static const editTransaction = 'editTransaction';
  static const profile = 'profile';
  static const createAccount = 'createAccount';
  static const wallet = 'wallet';
  static const createWallet = 'createWallet';
  static const addWallet = 'addWallet';
  static const detailWallet = 'detailWallet';
  static const editWallet = 'editWallet';
  static const selectWallet = 'selectWallet';
  static const category = 'category';
  static const selectCategory = 'selectCategory';
  static const onboarding = 'onboarding';

  static final router = GoRouter(
    initialLocation: '/onboarding',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: '/onboarding',
        name: onboarding,
        builder: (_, __) => const OnboardingScreen(),
        redirect: (context, state) async {
          final cubit = context.read<AuthenticationCubit>();
          await cubit.loadAuthenticationStatus();
          if (cubit.state == AuthenticationStatus.accountCreated) {
            return '/onboarding/create-wallet';
          } else if (cubit.state == AuthenticationStatus.signedIn) {
            return '/';
          }
          return null;
        },
        routes: [
          GoRoute(
            path: 'create-account',
            name: createAccount,
            builder: (_, __) => const CreateAccountScreen(),
          ),
          GoRoute(
            path: 'create-wallet',
            name: createWallet,
            builder: (_, __) => const AddWalletScreen(),
          ),
        ],
      ),
      StatefulShellRoute.indexedStack(
        builder: (_, __, navigationShell) =>
            ScaffoldWithNestedNavigation(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            navigatorKey: _homeNavigatorKey,
            routes: [
              GoRoute(
                path: '/',
                name: home,
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: HomeScreen()),
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _transactionNavigatorKey,
            routes: [
              GoRoute(
                path: '/transaction',
                name: transaction,
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: TransactionScreen()),
                routes: [
                  GoRoute(
                    path: 'add',
                    name: addTransaction,
                    builder: (_, state) {
                      final type = TransactionType.values.firstWhere((type) =>
                          type.name == state.uri.queryParameters['type']);
                      return AddTransactionScreen(type);
                    },
                  ),
                  GoRoute(
                    path: ':id',
                    name: detailTransaction,
                    builder: (_, state) {
                      final id = state.pathParameters['id'] as String;
                      return DetailTransactionScreen(id);
                    },
                    routes: [
                      GoRoute(
                        path: 'edit',
                        name: editTransaction,
                        builder: (_, state) {
                          final transaction = state.extra as TransactionModel;
                          return EditTransactionScreen(transaction);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _profileNavigatorKey,
            routes: [
              GoRoute(
                path: '/profile',
                name: profile,
                pageBuilder: (_, __) =>
                    const NoTransitionPage(child: ProfileScreen()),
                routes: [
                  GoRoute(
                    path: 'wallet',
                    name: wallet,
                    builder: (_, __) => const WalletScreen(),
                    routes: [
                      GoRoute(
                        path: 'add',
                        name: addWallet,
                        builder: (_, __) => const AddWalletScreen(),
                      ),
                      GoRoute(
                        path: ':id',
                        name: detailWallet,
                        builder: (_, state) {
                          return const DetailWalletScreen();
                        },
                        routes: [
                          GoRoute(
                            path: 'edit',
                            name: editWallet,
                            builder: (_, state) {
                              final wallet = state.extra as WalletModel;
                              return EditWalletScreen(wallet);
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  GoRoute(
                    path: 'category',
                    name: category,
                    builder: (_, __) => const CategoryScreen(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
