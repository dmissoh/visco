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
    final allProfiles = ref.watch(allProfilesProvider);

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
            'Profiles',
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
                ...allProfiles.map((p) => _buildProfileItem(
                      context,
                      ref,
                      profile: p,
                      isActive: p.id == profile?.id,
                      colors: colors,
                    )),
                if (allProfiles.isNotEmpty)
                  Divider(height: 1, color: colors.border),
                ListTile(
                  leading: Icon(
                    Icons.add_circle_outline,
                    color: colors.accent,
                  ),
                  title: Text(
                    'Add Profile',
                    style: AppTypography.body(color: colors.accent),
                  ),
                  onTap: () => context.push('/new-profile'),
                ),
              ],
            ),
          ),
          if (profile != null) ...[
            const SizedBox(height: AppSpacing.xl),
            Text(
              'Current Profile',
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
                      profile.sex == Sex.male ? 'Male' : 'Female',
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
                      '${profile.age} years',
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
                      '${profile.heightCm.toStringAsFixed(0)} cm',
                      style: AppTypography.body(color: colors.textSecondary),
                    ),
                  ),
                  if (allProfiles.length > 1) ...[
                    Divider(height: 1, color: colors.border),
                    ListTile(
                      leading: Icon(
                        Icons.delete_outline,
                        color: colors.danger,
                      ),
                      title: Text(
                        'Delete Profile',
                        style: AppTypography.body(color: colors.danger),
                      ),
                      onTap: () => _showDeleteProfileConfirmation(context, ref, profile),
                    ),
                  ],
                ],
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Goals',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildGoalSection(context, ref, colors),
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
          const SizedBox(height: AppSpacing.xl),
          Text(
            'Data',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.border),
            ),
            child: ListTile(
              leading: Icon(
                Icons.delete_forever,
                color: colors.danger,
              ),
              title: Text(
                'Reset All Data',
                style: AppTypography.body(color: colors.danger),
              ),
              subtitle: Text(
                'Delete all profiles and measurements',
                style: AppTypography.caption(color: colors.textSecondary),
              ),
              onTap: () => _showResetAllConfirmation(context, ref),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalSection(BuildContext context, WidgetRef ref, AppColorScheme colors) {
    final goalValue = ref.watch(vatGoalProvider);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: ListTile(
        leading: Icon(
          Icons.flag_outlined,
          color: colors.textSecondary,
        ),
        title: Text(
          'VAT Goal',
          style: AppTypography.body(color: colors.textPrimary),
        ),
        subtitle: Text(
          goalValue != null ? '${goalValue.toStringAsFixed(0)} cm\u00B2' : 'Not set',
          style: AppTypography.caption(color: colors.textSecondary),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colors.textSecondary,
        ),
        onTap: () => _showGoalDialog(context, ref, goalValue),
      ),
    );
  }

  void _showGoalDialog(BuildContext context, WidgetRef ref, double? currentGoal) {
    final colors = AppColors.of(context);
    final controller = TextEditingController(
      text: currentGoal?.toStringAsFixed(0) ?? '',
    );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'Set VAT Goal',
          style: AppTypography.title(color: colors.textPrimary),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Set a target visceral fat area to track on your progress chart.',
              style: AppTypography.caption(color: colors.textSecondary),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Goal (cm\u00B2)',
                hintText: 'e.g., 100',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'Tip: Below 100 cm\u00B2 is considered healthy',
              style: AppTypography.caption(color: colors.success),
            ),
          ],
        ),
        actions: [
          if (currentGoal != null)
            TextButton(
              onPressed: () {
                ref.read(vatGoalProvider.notifier).setGoal(null);
                Navigator.pop(context);
              },
              child: Text(
                'Clear',
                style: AppTypography.body(color: colors.danger),
              ),
            ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: AppTypography.body(color: colors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              final value = double.tryParse(controller.text);
              if (value != null && value > 0) {
                ref.read(vatGoalProvider.notifier).setGoal(value);
              }
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: AppTypography.body(color: colors.accent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    WidgetRef ref, {
    required UserProfile profile,
    required bool isActive,
    required AppColorScheme colors,
  }) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: isActive ? colors.accent : colors.border,
        child: Text(
          profile.name.isNotEmpty ? profile.name[0].toUpperCase() : '?',
          style: AppTypography.body(
            color: isActive ? Colors.white : colors.textSecondary,
          ),
        ),
      ),
      title: Text(
        profile.name,
        style: AppTypography.body(color: colors.textPrimary),
      ),
      subtitle: Text(
        '${profile.sex == Sex.male ? 'Male' : 'Female'}, ${profile.age} years',
        style: AppTypography.caption(color: colors.textSecondary),
      ),
      trailing: isActive
          ? Icon(Icons.check_circle, color: colors.accent)
          : null,
      onTap: isActive
          ? null
          : () => ref.read(profileNotifierProvider.notifier).switchProfile(profile.id),
    );
  }

  void _showDeleteProfileConfirmation(BuildContext context, WidgetRef ref, UserProfile profile) {
    final colors = AppColors.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'Delete Profile',
          style: AppTypography.title(color: colors.textPrimary),
        ),
        content: Text(
          'Delete "${profile.name}" and all their measurements? This cannot be undone.',
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
              await ref.read(profileNotifierProvider.notifier).deleteProfile(profile.id);
              if (context.mounted) {
                Navigator.pop(context);
              }
            },
            child: Text(
              'Delete',
              style: AppTypography.body(color: colors.danger),
            ),
          ),
        ],
      ),
    );
  }

  void _showResetAllConfirmation(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: colors.surface,
        title: Text(
          'Reset All Data',
          style: AppTypography.title(color: colors.textPrimary),
        ),
        content: Text(
          'This will delete ALL profiles and measurements. You will need to set up a new profile. This cannot be undone.',
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
              await ref.read(profileNotifierProvider.notifier).deleteAllProfiles();
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
