import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/modules/model/wallet/wallet_balance_model.dart';

class WalletBalanceNotifier extends StateNotifier<WalletBalanceModel> {
  WalletBalanceNotifier() : super(WalletBalanceModel(balance: 0.0));

  void updateBalance(double amount) {
    final newBalance = state.balance + amount;
    state = WalletBalanceModel(balance: newBalance);
  }
}

final walletBalanceProvider =
    StateNotifierProvider<WalletBalanceNotifier, WalletBalanceModel>((ref) {
  return WalletBalanceNotifier();
});
