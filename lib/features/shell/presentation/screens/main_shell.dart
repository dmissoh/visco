import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:visco/features/calculator/presentation/screens/whatif_calculator_screen.dart';
import 'package:visco/features/history/presentation/screens/history_screen.dart';
import 'package:visco/features/settings/presentation/screens/settings_screen.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

/// Provider for the current tab index
final currentTabProvider = StateProvider<int>((ref) => 0);

/// Main shell with bottom navigation bar and fade transitions
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  static const _screens = [
    CalculatorScreen(),
    WhatIfCalculatorScreen(),
    HistoryScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final currentIndex = ref.watch(currentTabProvider);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Stack(
        children: List.generate(_screens.length, (index) {
          return AnimatedOpacity(
            opacity: index == currentIndex ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 200),
            child: IgnorePointer(
              ignoring: index != currentIndex,
              child: _screens[index],
            ),
          );
        }),
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
            label: l10n.navCalculate,
          ),
          NavigationDestination(
            icon: Icon(Icons.science_outlined, color: colors.textSecondary),
            selectedIcon: Icon(Icons.science, color: colors.accent),
            label: l10n.navWhatIf,
          ),
          NavigationDestination(
            icon: Icon(Icons.bar_chart_outlined, color: colors.textSecondary),
            selectedIcon: Icon(Icons.bar_chart, color: colors.accent),
            label: l10n.navProgress,
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined, color: colors.textSecondary),
            selectedIcon: Icon(Icons.settings, color: colors.accent),
            label: l10n.navSettings,
          ),
        ],
      ),
    );
  }
}
