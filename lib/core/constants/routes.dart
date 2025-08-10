import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cointrack/presentation/pages/pages.dart';

final GoRouter router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashPage();
      },
    ),
    GoRoute(
      path: '/home',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage(
          child: const HomePage(),
          transitionDuration: Durations.long3,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Tela entra da direita
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/details/:coinId',
      pageBuilder: (context, state) {
        final coinId = state.pathParameters['coinId'] ?? '';
        return CustomTransitionPage(
          child: DetailsPage(coinId: coinId),
          transitionDuration: Durations.long3,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1.0, 0.0), // Tela entra da direita
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
      },
    ),
  ],
);
