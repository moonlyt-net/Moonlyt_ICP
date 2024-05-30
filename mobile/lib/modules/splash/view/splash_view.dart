// SplashView.dart
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:go_router/go_router.dart';
import 'package:moonlyt/constant/path/routes.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  // final PermissionViewModel _viewModel = PermissionViewModel();

  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => context.pushReplacement(
              Routes.start,
            ));
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("SplashView");
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/background_dark.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity),
          Center(
            child: SizedBox(
                width: 250,
                child: Image.asset('assets/splash.png', fit: BoxFit.cover)),
          ),
        ],
      ),
    );
  }
}
