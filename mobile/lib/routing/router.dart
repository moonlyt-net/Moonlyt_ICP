import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:moonlyt/constant/path/routes.dart';
import 'package:moonlyt/modules/login/login_view.dart';
import 'package:moonlyt/modules/login/login_view_model.dart';
import 'package:moonlyt/modules/model/webtoon.dart';
import 'package:moonlyt/modules/screen/navigation/my_bottom_navigation_bar.dart';
import 'package:moonlyt/modules/screen/mypage/dao/dao_view.dart';
import 'package:moonlyt/modules/screen/mypage/my_moonpass_view.dart';
import 'package:moonlyt/modules/screen/passes/buy_pass_list.dart';
import 'package:moonlyt/modules/screen/passes/pass/pass.dart';

import 'package:moonlyt/modules/screen/my/send/send_view.dart';
import 'package:moonlyt/modules/screen/my/wallet_view.dart';
import 'package:moonlyt/modules/screen/webtoon/detail/webtoon_detail_view.dart';
import 'package:moonlyt/modules/screen/webtoon/detail/webtoon_viewer.dart';
import 'package:moonlyt/modules/screen/webtoon/webtoon_view.dart';
import 'package:moonlyt/modules/splash/view/splash_view.dart';

final routerNavigatorKey = GlobalKey<NavigatorState>();

final unauthorizedRoutes = [
  Routes.splash,
  Routes.start,
];

final routerProvider = Provider((ref) {
  final connectState = ref.watch(walletStateProvider);
  return GoRouter(
    debugLogDiagnostics: true,
    initialLocation: Routes.splash,
    navigatorKey: routerNavigatorKey,
    refreshListenable: connectState,
    redirect: (context, state) {
      final isLoggedIn = connectState.isLoggedIn;
      if (state.fullPath == Routes.start) {
        return isLoggedIn ? Routes.webtoon : Routes.start;
      }
      if (isLoggedIn || unauthorizedRoutes.contains(state.matchedLocation)) {
        return state.uri.toString();
      }
      return Routes.splash;
    },
    routes: [
      GoRoute(
        path: Routes.splash,
        builder: (context, state) {
          return SplashView();
        },
      ),
      GoRoute(
        path: Routes.start,
        builder: (context, state) {
          return const StartView();
        },
      ),
      // ...authRoutes,
      ShellRoute(
          builder: (context, state, child) =>
              MyBottomNavigationBar(child: child),
          routes: [
            ...webtoonRoutes,
          ])
    ],
  );
});

final List<GoRoute> webtoonRoutes = [
  GoRoute(
      name: 'webtoon',
      path: Routes.webtoon,
      pageBuilder: (context, state) {
        return const NoTransitionPage(child: WebtoonView());
      },
      onExit: (context) async => false,
      routes: [
        GoRoute(
          path: '${Routes.webtoonDetail}/:id',
          name: 'webtoon_detail',
          pageBuilder: (context, state) => NoTransitionPage(
            child: WebtoonDetailView(id: state.pathParameters['id']!),
          ),
          routes: [
            GoRoute(
              path: '${Routes.webtoonPage}/:id',
              name: 'webtoon_page',
              pageBuilder: (context, state) => NoTransitionPage(
                child: WebtoonViewer(id: state.pathParameters['id']!),
              ),
            ),
          ],
        ),
        GoRoute(
          name: 'my',
          path: Routes.my,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: WalletView());
          },
          routes: [
            GoRoute(
              name: 'send',
              path: Routes.send,
              pageBuilder: (context, state) {
                return const NoTransitionPage(child: SendView());
              },
            ),
          ],
        ),
        GoRoute(
          name: 'moonpass',
          path: Routes.moonpass,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: MoonPassView());
          },
          routes: [
            GoRoute(
              name: 'pass',
              path: '${Routes.pass}/:title',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                  child: PassView(title: state.pathParameters['title']!),
                );
              },
            ),
          ],
        ),
        GoRoute(
          name: 'mymoonpass',
          path: Routes.mymoonpass,
          pageBuilder: (context, state) {
            return const NoTransitionPage(child: MyMoonPassView());
          },
          routes: [
            GoRoute(
              name: 'dao',
              path: '${Routes.dao}/:title',
              pageBuilder: (context, state) {
                return NoTransitionPage(
                    child: DaoView(title: state.pathParameters['title']!));
              },
            ),
          ],
        ),
      ]),
];
