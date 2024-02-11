import 'package:flutter_bloc/flutter_bloc.dart';

import '../../wallet/data/models/wallet_model.dart';

class SelectWalletCubit extends Cubit<WalletModel?> {
  SelectWalletCubit() : super((null));

  void selectWallet(WalletModel wallet) => emit(wallet);
  void removeWallet() => emit(null);
}
