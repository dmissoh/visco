import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/calculator/presentation/screens/whatif_calculator_screen.dart';
import 'package:visco/features/help/presentation/screens/help_screen.dart';
import 'package:visco/features/history/presentation/screens/history_screen.dart';
import 'package:visco/features/onboarding/presentation/screens/onboarding_screen.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart' show profileNotifierProvider, onboardingCompletedProvider;
import 'package:visco/features/result/presentation/screens/result_screen.dart';
import 'package:visco/features/settings/presentation/screens/settings_screen.dart';
import 'package:visco/features/shell/presentation/screens/main_shell.dart';

final routerProvider = Provider<GoRouter>((ref) {
  final profile = ref.watch(profileNotifierProvider);
  final onboardingCompleted = ref.watch(onboardingCompletedProvider);

  return GoRouter(
    initialLocation: '/',
    redirect: (context, state) {
      final hasProfile = profile != null;
      final isOnboarding = state.matchedLocation == '/onboarding';

      // Show onboarding only if no profile AND onboarding not completed/skipped
      if (!hasProfile && !onboardingCompleted && !isOnboarding) {
        return '/onboarding';
      }

      // If user has profile and tries to go to onboarding, redirect home
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
        name: 'home',
        builder: (context, state) => const MainShell(),
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
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/new-profile',
        name: 'new-profile',
        builder: (context, state) => const OnboardingScreen(isAddingNewProfile: true),
      ),
      GoRoute(
        path: '/whatif',
        name: 'whatif',
        builder: (context, state) => const WhatIfCalculatorScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri}'),
      ),
    ),
  );
});
