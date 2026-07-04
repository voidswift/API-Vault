import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/security/app_state.dart';
import '../../features/auth/screens/lock_screen.dart';
import '../../features/onboarding/screens/splash_screen.dart';
import '../../features/vault/screens/home_screen.dart';
import '../../features/vault/screens/no_vault_screen.dart';
import 'app_state_provider.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final appState = ref.watch(appStateProvider);

  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final isSplash = state.matchedLocation == '/splash';

      switch (appState) {
        case AppState.initial:
          return isSplash ? null : '/splash';
        case AppState.noVault:
          return '/no-vault';
        case AppState.locked:
        case AppState.unlocking:
        case AppState.error:
          return '/lock';
        case AppState.unlocked:
          if (state.matchedLocation == '/lock' || state.matchedLocation == '/splash' || state.matchedLocation == '/no-vault') {
            return '/home';
          }
          return null; // Stay on current unlocked screen
      }
    },
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/no-vault',
        builder: (context, state) => const NoVaultScreen(),
      ),
      GoRoute(
        path: '/lock',
        builder: (context, state) => const LockScreen(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
});
