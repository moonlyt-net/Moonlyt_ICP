import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:moonlyt/constant/theme/theme_data.dart';
import 'package:moonlyt/routing/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  initializeApplication();
}

void initializeApplication() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF210A43),
      statusBarIconBrightness: Brightness.light,
    ));
    final route = ref.watch(routerProvider);
    return MaterialApp.router(
      title: 'Moonlyt',
      routerConfig: route,
      theme: appTheme(),
      debugShowCheckedModeBanner: false,
      supportedLocales: const [
        Locale('en', ''),
      ],
    );
  }
}
