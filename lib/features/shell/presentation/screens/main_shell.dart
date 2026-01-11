import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/features/calculator/presentation/screens/calculator_screen.dart';
import 'package:visco/features/calculator/presentation/screens/whatif_calculator_screen.dart';
import 'package:visco/features/calculator/presentation/widgets/quick_measurement_modal.dart';
import 'package:visco/features/history/presentation/screens/history_screen.dart';
import 'package:visco/features/settings/presentation/screens/settings_screen.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

/// Provider for the current tab index
final currentTabProvider = StateProvider<int>((ref) => 0);

/// Main shell with bottom navigation bar, central FAB, and fade transitions
class MainShell extends ConsumerStatefulWidget {
  const MainShell({super.key});

  @override
  ConsumerState<MainShell> createState() => _MainShellState();
}

class _MainShellState extends ConsumerState<MainShell> {
  // Screens order: Home (Calculator) | Progress | What-If | Settings
  // FAB in center triggers Calculator screen
  static const _screens = [
    CalculatorScreen(),
    HistoryScreen(),
    WhatIfCalculatorScreen(),
    SettingsScreen(),
  ];

  void _onNavItemTapped(int index) {
    HapticFeedback.lightImpact();
    ref.read(currentTabProvider.notifier).state = index;
  }

  Future<void> _onFabPressed() async {
    HapticFeedback.mediumImpact();
    // Show quick measurement entry modal
    await QuickMeasurementModal.show(context);
  }

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
      floatingActionButton: (currentIndex == 2 || currentIndex == 3)
          ? null // Hide on What-If and Settings
          : FloatingActionButton(
              onPressed: _onFabPressed,
              elevation: 4,
              backgroundColor: colors.accent,
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.add, size: 28),
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: colors.surface,
        elevation: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home (Calculator)
              _NavBarItem(
                icon: Icons.home_outlined,
                selectedIcon: Icons.home,
                label: l10n.navHome,
                isSelected: currentIndex == 0,
                onTap: () => _onNavItemTapped(0),
                colors: colors,
              ),
              // Progress
              _NavBarItem(
                icon: Icons.bar_chart_outlined,
                selectedIcon: Icons.bar_chart,
                label: l10n.navProgress,
                isSelected: currentIndex == 1,
                onTap: () => _onNavItemTapped(1),
                colors: colors,
              ),
              // Space for FAB
              const SizedBox(width: 56),
              // What-If
              _NavBarItem(
                icon: Icons.science_outlined,
                selectedIcon: Icons.science,
                label: l10n.navWhatIf,
                isSelected: currentIndex == 2,
                onTap: () => _onNavItemTapped(2),
                colors: colors,
              ),
              // Settings
              _NavBarItem(
                icon: Icons.settings_outlined,
                selectedIcon: Icons.settings,
                label: l10n.navSettings,
                isSelected: currentIndex == 3,
                onTap: () => _onNavItemTapped(3),
                colors: colors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final IconData selectedIcon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final AppColorScheme colors;

  const _NavBarItem({
    required this.icon,
    required this.selectedIcon,
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.colors,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? selectedIcon : icon,
              color: isSelected ? colors.accent : colors.textSecondary,
              size: 22,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? colors.accent : colors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
