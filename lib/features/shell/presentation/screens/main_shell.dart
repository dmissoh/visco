import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:visco/features/calculator/presentation/screens/whatif_calculator_screen.dart';
import 'package:visco/features/history/presentation/screens/history_screen.dart';
import 'package:visco/features/settings/presentation/screens/settings_screen.dart';

/// Provider for the current tab index
final currentTabProvider = StateProvider<int>((ref) => 0);

/// Main shell with bottom navigation bar
class MainShell extends ConsumerWidget {
  const MainShell({super.key});

  Widget _buildScreen(int index) {
    switch (index) {
      case 0:
        return const CalculatorScreen();
      case 1:
        return const WhatIfCalculatorScreen();
      case 2:
        return const HistoryScreen();
      case 3:
        return const SettingsScreen();
      default:
        return const CalculatorScreen();
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final currentIndex = ref.watch(currentTabProvider);

    return Scaffold(
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        child: KeyedSubtree(
          key: ValueKey<int>(currentIndex),
          child: _buildScreen(currentIndex),
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          HapticFeedback.lightImpact();
          ref.read(currentTabProvider.notifier).state = index;
        },
        backgroundColor: colors.surface,
        indicatorColor: colors.accent.withValues(alpha: 0.15),
        destinations: [
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined, color: colors.textSecondary),
            selectedIcon: Icon(Icons.calculate, color: colors.accent),
            label: 'Calculate',
          ),
          NavigationDestination(
            icon: Icon(Icons.science_outlined, color: colors.textSecondary),
            selectedIcon: Icon(Icons.science, color: colors.accent),
            label: 'What-If',
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined, color: colors.textSecondary),
            selectedIcon: Icon(Icons.bar_chart, color: colors.accent),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: colors.textSecondary),
            selectedIcon: Icon(Icons.settings, color: colors.accent),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
