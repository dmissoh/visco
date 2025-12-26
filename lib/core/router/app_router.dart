import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:visco/features/help/presentation/screens/help_screen.dart';
import 'package:visco/features/history/presentation/screens/history_screen.dart';
import 'package:visco/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/result/presentation/screens/result_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final profile = ref.watch(profileNotifierProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final hasProfile = profile != null;
      final isOnboarding = state.matchedLocation == '/onboarding';

      if (!hasProfile && !isOnboarding) {
        return '/onboarding';
      }

      if (hasProfile && isOnboarding) {
        return '/';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/onboarding',
        name: 'onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/',
        name: 'calculator',
        builder: (context, state) => const CalculatorScreen(),
      ),
      GoRoute(
        path: '/result',
        name: 'result',
        builder: (context, state) {
          final measurement = state.extra as Measurement;
          return ResultScreen(measurement: measurement);
        },
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/help',
        name: 'help',
        builder: (context, state) => const HelpScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
});
