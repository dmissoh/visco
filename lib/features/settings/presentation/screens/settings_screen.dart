import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final currentTheme = ref.watch(settingsProvider);
    final profile = ref.watch(profileNotifierProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            'Profile',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.person_outline,
                    color: colors.textSecondary,
                  ),
                  title: Text(
                    'Sex',
                    style: AppTypography.body(color: colors.textPrimary),
                  ),
                  trailing: Text(
                    profile?.sex == Sex.male ? 'Male' : 'Female',
                    style: AppTypography.body(color: colors.textSecondary),
                  ),
                ),
                Divider(height: 1, color: colors.border),
                ListTile(
                  leading: Icon(
                    Icons.cake_outlined,
                    color: colors.textSecondary,
                  ),
                  title: Text(
                    'Age',
                    style: AppTypography.body(color: colors.textPrimary),
                  ),
                  trailing: Text(
                    '${profile?.age ?? 0} years',
                    style: AppTypography.body(color: colors.textSecondary),
                  ),
                ),
                Divider(height: 1, color: colors.border),
                ListTile(
                  leading: Icon(
                    Icons.height,
                    color: colors.textSecondary,
                  ),
                  title: Text(
                    'Height',
                    style: AppTypography.body(color: colors.textPrimary),
                  ),
                  trailing: Text(
                    '${profile?.heightCm.toStringAsFixed(0) ?? 0} cm',
                    style: AppTypography.body(color: colors.textSecondary),
                  ),
                ),
                Divider(height: 1, color: colors.border),
                ListTile(
                  leading: Icon(
                    Icons.refresh,
                    color: colors.danger,
                  ),
                  title: Text(
                    'Reset Profile',
                    style: AppTypography.body(color: colors.danger),
                  ),
                  onTap: () => _showResetConfirmation(context, ref),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Appearance',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              children: [
                _buildThemeOption(
                  context,
                  ref,
                  title: 'System',
                  subtitle: 'Follow system settings',
                  value: ThemeMode.system,
                  currentValue: currentTheme,
                  icon: Icons.settings_suggest_outlined,
                ),
                Divider(height: 1, color: colors.border),
                _buildThemeOption(
                  context,
                  ref,
                  title: 'Light',
                  subtitle: 'Always use light theme',
                  value: ThemeMode.light,
                  currentValue: currentTheme,
                  icon: Icons.light_mode_outlined,
                ),
                Divider(height: 1, color: colors.border),
                _buildThemeOption(
                  context,
                  ref,
                  title: 'Dark',
                  subtitle: 'Always use dark theme',
                  value: ThemeMode.dark,
                  currentValue: currentTheme,
                  icon: Icons.dark_mode_outlined,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showResetConfirmation(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'Reset Profile',
          style: AppTypography.title(color: colors.textPrimary),
        ),
        content: Text(
          'This will delete your profile and all measurement history. You will need to set up your profile again.',
          style: AppTypography.body(color: colors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.body(color: colors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () async {
              await ref.read(profileNotifierProvider.notifier).deleteProfile();
              if (context.mounted) {
                Navigator.pop(context);
                context.go('/onboarding');
              }
            },
            child: Text(
              'Reset',
              style: AppTypography.body(color: colors.danger),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildThemeOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subtitle,
    required ThemeMode value,
    required ThemeMode currentValue,
    required IconData icon,
  }) {
    final colors = AppColors.of(context);
    final isSelected = value == currentValue;

    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? colors.accent : colors.textSecondary,
      ),
      title: Text(
        title,
        style: AppTypography.body(color: colors.textPrimary),
      ),
      subtitle: Text(
        subtitle,
        style: AppTypography.caption(color: colors.textSecondary),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colors.accent)
          : null,
      onTap: () {
        ref.read(settingsProvider.notifier).setThemeMode(value);
      },
    );
  }
}
