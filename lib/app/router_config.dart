import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minicore_arch_example/app/modules/assets_module/presentation/assets_page.dart';
import 'package:minicore_arch_example/app/modules/home/presentation/home_page.dart';
import 'package:minicore_arch_example/app/modules/splash/splash_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouterConfig = GoRouter(
  initialLocation: '/splash',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/splash',
      builder: (context, state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) {
        return const HomePage();
      },
    ),
    GoRoute(
      path: '/assets/:companyId',
      builder: (context, state) {
        return AssetsPage(companyId: state.pathParameters['companyId'] ?? '');
      },
    ),
  ],
);
