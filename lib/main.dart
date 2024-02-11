import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wangku/core/app_bloc_observer.dart';
import 'package:wangku/core/app_router.dart';
import 'package:wangku/core/constants/app_colors.dart';
import 'package:wangku/core/data/services/image_service.dart';
import 'package:wangku/core/data/services/shared_preferences_service.dart';
import 'package:wangku/features/category/cubits/categories/categories_cubit.dart';
import 'package:wangku/features/category/data/services/category_service.dart';
import 'package:wangku/features/home/cubits/spend_frequency/spend_frequency_cubit.dart';
import 'package:wangku/features/home/cubits/transaction_report/transaction_report_cubit.dart';
import 'package:wangku/features/transaction/cubits/image_cubit.dart';
import 'package:wangku/features/transaction/cubits/select_category_cubit.dart';
import 'package:wangku/features/transaction/data/services/transaction_service.dart';
import 'package:wangku/features/wallet/cubits/wallets/wallets_cubit.dart';
import 'package:wangku/features/wallet/data/services/wallet_service.dart';

import 'core/constants/app_text_styles.dart';
import 'features/authentication/cubits/authentication_cubit.dart';
import 'features/home/cubits/account_balance/account_balance_cubit.dart';
import 'features/home/cubits/recent_transaction/recent_transaction_cubit.dart';
import 'features/onboarding/cubits/onboarding_cubit.dart';
import 'features/profile/cubits/account/account_cubit.dart';
import 'features/transaction/cubits/select_wallet_cubit.dart';
import 'features/transaction/cubits/transaction/transaction_cubit.dart';
import 'features/transaction/cubits/transactions/transactions_cubit.dart';
import 'features/wallet/cubits/wallet/wallet_cubit.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  Bloc.observer = AppBlocObserver();
  runApp(const MainApp());
  await Future.delayed(const Duration(seconds: 1));
  FlutterNativeSplash.remove();
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (_) => CategoryService()),
        RepositoryProvider(create: (_) => ImageService()),
        RepositoryProvider(create: (_) => TransactionService()),
        RepositoryProvider(create: (_) => SharedPreferencesService()),
        RepositoryProvider(create: (_) => WalletService()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => ImageCubit()),
          BlocProvider(create: (_) => OnboardingCubit()),
          BlocProvider(create: (_) => SelectCategoryCubit()),
          BlocProvider(create: (_) => SelectWalletCubit()),
          BlocProvider(
            create: (context) => AccountCubit(
              context.read<SharedPreferencesService>(),
            )..loadAccount(),
          ),
          BlocProvider(
            create: (context) => AccountBalanceCubit(
              context.read<WalletService>(),
            )..loadAccountBalance(),
          ),
          BlocProvider(
            create: (context) => AuthenticationCubit(
              context.read<SharedPreferencesService>(),
              context.read<WalletService>(),
            ),
          ),
          BlocProvider(
            create: (context) => CategoriesCubit(
              context.read<CategoryService>(),
            ),
          ),
          BlocProvider(
            create: (context) => SpendFrequencyCubit(
              context.read<TransactionService>(),
            )..loadSpendFrequency(),
          ),
          BlocProvider(
            create: (context) => TransactionCubit(
              context.read<TransactionService>(),
              context.read<ImageService>(),
            ),
          ),
          BlocProvider(
            create: (context) => TransactionsCubit(
              context.read<TransactionService>(),
              context.read<ImageService>(),
            )..loadAllTransactions(),
          ),
          BlocProvider(
            create: (context) => RecentTransactionCubit(
              context.read<TransactionService>(),
            )..loadRecentTransactions(),
          ),
          BlocProvider(
            create: (context) => TransactionReportCubit(
              context.read<TransactionService>(),
            )..loadTransactionReport(),
          ),
          BlocProvider(
            create: (context) => WalletCubit(
              context.read<WalletService>(),
            ),
          ),
          BlocProvider(
            create: (context) => WalletsCubit(
              context.read<WalletService>(),
            ),
          ),
        ],
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: (_, __) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: AppRouter.router,
              title: 'wangku',
              theme: ThemeData(
                fontFamily: 'Inter',
                useMaterial3: true,
                navigationBarTheme: NavigationBarThemeData(
                  labelTextStyle: MaterialStateProperty.resolveWith(
                    (states) {
                      if (states.contains(MaterialState.selected)) {
                        return AppTextStyles.tiny
                            .copyWith(color: AppColors.violet100);
                      } else {
                        return AppTextStyles.tiny
                            .copyWith(color: const Color(0xFFC6C6C6));
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
