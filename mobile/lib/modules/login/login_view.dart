import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:moonlyt/constant/path/routes.dart';
import 'package:moonlyt/modules/login/login_view_model.dart';

class StartView extends ConsumerStatefulWidget {
  const StartView({super.key});

  @override
  ConsumerState<StartView> createState() => _StartViewState();
}

class _StartViewState extends ConsumerState<StartView> {
  void _connectWalletWindow() {
    showDialog(
        // barrierColor: Colors.red,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Colors.white, width: 1.0)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: const Color(0xFF333333).withOpacity(0.5),
            title: const Text('Connect Wallet'),
            content: GestureDetector(
              onTap: () async {
                ref.read(walletStateProvider.notifier).login();
                GoRouter.of(context).go(Routes.webtoon);
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: const Color(0xFF3333333).withOpacity(1),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.all(10),
                height: 50,
                width: 100,
                child: Text(
                  'Connect',
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  'Close',
                  style: TextStyle(color: Colors.white.withOpacity(0.5)),
                ),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Image.asset('assets/background_dark.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 50),
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      'Shine in darkness,\nbring hope',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 100),
                  Stack(
                    children: [
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.yellow.withOpacity(0.4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.white.withOpacity(0.8),
                              spreadRadius: 2,
                              blurRadius: 30,
                              offset: const Offset(1, 0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 150),
                  SizedBox(
                    child: GestureDetector(
                        child: Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF2E21AC),
                                Color(0xFF7834A5),
                                Color(0xFFD3479D),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Connect Wallet',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white)),
                            ],
                          ),
                        ),
                        onTap: () {
                          _connectWalletWindow();
                          // _onPressed(context);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  //이 위치에서는 사용할 수 있음?

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
