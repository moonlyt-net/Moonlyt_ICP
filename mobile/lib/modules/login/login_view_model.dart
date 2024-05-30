import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/constant/path/routes.dart';

class WalletNotifier extends ChangeNotifier {
  bool isLoggedIn = false;

  WalletNotifier({
    required this.isLoggedIn,
  });

  void login() {
    isLoggedIn = true;
  }

  void logout() {
    isLoggedIn = false;
  }
}

final walletStateProvider = ChangeNotifierProvider<WalletNotifier>((ref) {
  final isLoggedIn = false;
  return WalletNotifier(isLoggedIn: isLoggedIn);
});
