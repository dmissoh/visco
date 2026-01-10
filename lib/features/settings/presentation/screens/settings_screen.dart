import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/services/notification_service.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/premium/presentation/screens/paywall_screen.dart';
import 'package:visco/features/premium/providers/premium_provider.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final currentTheme = ref.watch(settingsProvider);
    final profile = ref.watch(profileNotifierProvider);
    final allProfiles = ref.watch(allProfilesProvider);
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.settings),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            l10n.profiles,
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
                  title: Row(
                    children: [
                      Text(
                        l10n.addProfile,
                        style: AppTypography.body(color: colors.accent),
                      ),
                      if (!isPremium && allProfiles.isNotEmpty) ...[
                        const SizedBox(width: AppSpacing.sm),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: colors.accent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            l10n.pro,
                            style: AppTypography.label(color: Colors.white)
                                .copyWith(fontSize: 10),
                          ),
                        ),
                      ],
                    ],
                  ),
                  onTap: () async {
                    // Free users can only have 1 profile
                    if (!isPremium && allProfiles.isNotEmpty) {
                      final upgraded = await showPaywall(
                        context,
                        featureName: l10n.multipleProfiles,
                      );
                      if (!upgraded) return;
                    }
                    if (context.mounted) {
                      context.push('/new-profile');
                    }
                  },
                ),
              ],
            ),
          ),
          if (profile != null) ...[
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.currentProfile,
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
                      l10n.sexLabel,
                      style: AppTypography.body(color: colors.textPrimary),
                    ),
                    trailing: Text(
                      profile.sex == Sex.male ? l10n.male : l10n.female,
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
                      l10n.age,
                      style: AppTypography.body(color: colors.textPrimary),
                    ),
                    trailing: Text(
                      l10n.ageYears(profile.age),
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
                      l10n.height,
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
                        l10n.deleteProfile,
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
            l10n.goals,
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildGoalSection(context, ref, colors),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.units,
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildUnitsSection(context, ref, colors),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.reminders,
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildRemindersSection(context, ref, colors),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.appearance,
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
                  title: l10n.system,
                  subtitle: l10n.followSystemSettings,
                  value: ThemeMode.system,
                  currentValue: currentTheme,
                  icon: Icons.settings_suggest_outlined,
                ),
                Divider(height: 1, color: colors.border),
                _buildThemeOption(
                  context,
                  ref,
                  title: l10n.light,
                  subtitle: l10n.alwaysLightTheme,
                  value: ThemeMode.light,
                  currentValue: currentTheme,
                  icon: Icons.light_mode_outlined,
                ),
                Divider(height: 1, color: colors.border),
                _buildThemeOption(
                  context,
                  ref,
                  title: l10n.dark,
                  subtitle: l10n.alwaysDarkTheme,
                  value: ThemeMode.dark,
                  currentValue: currentTheme,
                  icon: Icons.dark_mode_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.language,
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildLanguageSection(context, ref, colors),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.data,
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
                l10n.resetAllData,
                style: AppTypography.body(color: colors.danger),
              ),
              subtitle: Text(
                l10n.deleteAllProfilesAndMeasurements,
                style: AppTypography.caption(color: colors.textSecondary),
              ),
              onTap: () => _showResetAllConfirmation(context, ref),
            ),
          ),
          // Debug section - only visible in dev mode (debug, profile, or ENABLE_DEV_OPTIONS flag)
          if (isDevOptionsEnabled) ...[
            const SizedBox(height: AppSpacing.xl),
            Text(
              l10n.developerOptions,
              style: AppTypography.title(color: colors.textPrimary),
            ),
            const SizedBox(height: AppSpacing.md),
            _buildDebugSection(context, ref, colors),
          ],
        ],
      ),
    );
  }

  Widget _buildDebugSection(BuildContext context, WidgetRef ref, AppColorScheme colors) {
    final l10n = AppLocalizations.of(context)!;
    final debugOverride = ref.watch(debugPremiumOverrideProvider);
    final isPremium = ref.watch(isPremiumProvider);

    String statusText;
    if (debugOverride == true) {
      statusText = l10n.simulatingPremium;
    } else if (debugOverride == false) {
      statusText = l10n.simulatingFree;
    } else {
      statusText = l10n.usingRealStatus;
    }

    return Container(
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.warning.withValues(alpha: 0.3)),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Icon(
              Icons.bug_report_outlined,
              color: colors.warning,
            ),
            title: Text(
              l10n.premiumStatusOverride,
              style: AppTypography.body(color: colors.textPrimary),
            ),
            subtitle: Text(
              '$statusText (${l10n.actual}: ${isPremium ? l10n.premium : l10n.free})',
              style: AppTypography.caption(color: colors.textSecondary),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Row(
              children: [
                Expanded(
                  child: _buildDebugButton(
                    context,
                    ref,
                    label: l10n.free,
                    isSelected: debugOverride == false,
                    onTap: () => ref.read(debugPremiumOverrideProvider.notifier).state = false,
                    colors: colors,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDebugButton(
                    context,
                    ref,
                    label: l10n.premium,
                    isSelected: debugOverride == true,
                    onTap: () => ref.read(debugPremiumOverrideProvider.notifier).state = true,
                    colors: colors,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: _buildDebugButton(
                    context,
                    ref,
                    label: l10n.real,
                    isSelected: debugOverride == null,
                    onTap: () => ref.read(debugPremiumOverrideProvider.notifier).state = null,
                    colors: colors,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebugButton(
    BuildContext context,
    WidgetRef ref, {
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
    required AppColorScheme colors,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? colors.accent : colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected ? colors.accent : colors.border,
          ),
        ),
        child: Center(
          child: Text(
            label,
            style: AppTypography.caption(
              color: isSelected ? Colors.white : colors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoalSection(BuildContext context, WidgetRef ref, AppColorScheme colors) {
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(profileNotifierProvider);
    final goalValue = profile != null 
        ? ref.watch(vatGoalFamilyProvider(profile.id)) 
        : null;

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
          l10n.vatGoal,
          style: AppTypography.body(color: colors.textPrimary),
        ),
        subtitle: Text(
          goalValue != null ? '${goalValue.toStringAsFixed(0)} cm\u00B2' : l10n.notSet,
          style: AppTypography.caption(color: colors.textSecondary),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colors.textSecondary,
        ),
        onTap: profile != null 
            ? () => _showGoalDialog(context, ref, profile.id, goalValue) 
            : null,
      ),
    );
  }

  Widget _buildUnitsSection(BuildContext context, WidgetRef ref, AppColorScheme colors) {
    final l10n = AppLocalizations.of(context)!;
    final currentUnit = ref.watch(unitSystemProvider);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          _buildUnitOption(
            context,
            ref,
            title: l10n.metric,
            subtitle: l10n.metricUnits,
            value: UnitSystem.metric,
            currentValue: currentUnit,
            icon: Icons.straighten_outlined,
          ),
          Divider(height: 1, color: colors.border),
          _buildUnitOption(
            context,
            ref,
            title: l10n.imperial,
            subtitle: l10n.imperialUnits,
            value: UnitSystem.imperial,
            currentValue: currentUnit,
            icon: Icons.square_foot_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildUnitOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required String subtitle,
    required UnitSystem value,
    required UnitSystem currentValue,
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
        ref.read(unitSystemProvider.notifier).setUnitSystem(value);
      },
    );
  }

  Widget _buildLanguageSection(BuildContext context, WidgetRef ref, AppColorScheme colors) {
    final currentLocale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          _buildLanguageOption(
            context,
            ref,
            title: l10n.english,
            locale: const Locale('en'),
            currentLocale: currentLocale,
            flag: 'EN',
          ),
          Divider(height: 1, color: colors.border),
          _buildLanguageOption(
            context,
            ref,
            title: l10n.german,
            locale: const Locale('de'),
            currentLocale: currentLocale,
            flag: 'DE',
          ),
          Divider(height: 1, color: colors.border),
          _buildLanguageOption(
            context,
            ref,
            title: l10n.french,
            locale: const Locale('fr'),
            currentLocale: currentLocale,
            flag: 'FR',
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(
    BuildContext context,
    WidgetRef ref, {
    required String title,
    required Locale locale,
    required Locale? currentLocale,
    required String flag,
  }) {
    final colors = AppColors.of(context);
    final isSelected = currentLocale?.languageCode == locale.languageCode;

    return ListTile(
      leading: Container(
        width: 32,
        height: 32,
        decoration: BoxDecoration(
          color: isSelected ? colors.accent.withValues(alpha: 0.1) : colors.background,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(
            color: isSelected ? colors.accent : colors.border,
          ),
        ),
        child: Center(
          child: Text(
            flag,
            style: AppTypography.label(
              color: isSelected ? colors.accent : colors.textSecondary,
            ),
          ),
        ),
      ),
      title: Text(
        title,
        style: AppTypography.body(color: colors.textPrimary),
      ),
      trailing: isSelected
          ? Icon(Icons.check_circle, color: colors.accent)
          : null,
      onTap: () {
        ref.read(localeProvider.notifier).setLocale(locale);
      },
    );
  }

  Widget _buildRemindersSection(BuildContext context, WidgetRef ref, AppColorScheme colors) {
    final l10n = AppLocalizations.of(context)!;
    final reminderSettings = ref.watch(reminderSettingsProvider);
    
    String frequencyText;
    String subtitleText;
    
    switch (reminderSettings.frequency) {
      case ReminderFrequency.off:
        frequencyText = l10n.off;
        subtitleText = l10n.noRemindersScheduled;
      case ReminderFrequency.weekly:
        final time = TimeOfDay(hour: reminderSettings.hour, minute: reminderSettings.minute);
        final dayName = _getLocalizedDayName(l10n, reminderSettings.dayOfWeek);
        frequencyText = l10n.weekly;
        subtitleText = l10n.everyDayAt(dayName, time.format(context));
      case ReminderFrequency.monthly:
        final time = TimeOfDay(hour: reminderSettings.hour, minute: reminderSettings.minute);
        final dayOrdinal = _getDayOrdinal(reminderSettings.dayOfMonth);
        frequencyText = l10n.monthly;
        subtitleText = l10n.everyOrdinalAt(dayOrdinal, time.format(context));
    }

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: ListTile(
        leading: Icon(
          Icons.notifications_outlined,
          color: colors.textSecondary,
        ),
        title: Text(
          frequencyText,
          style: AppTypography.body(color: colors.textPrimary),
        ),
        subtitle: Text(
          subtitleText,
          style: AppTypography.caption(color: colors.textSecondary),
        ),
        trailing: Icon(
          Icons.chevron_right,
          color: colors.textSecondary,
        ),
        onTap: () => _showReminderDialog(context, ref, reminderSettings),
      ),
    );
  }

  String _getLocalizedDayName(AppLocalizations l10n, int dayOfWeek) {
    switch (dayOfWeek) {
      case 1:
        return l10n.monday;
      case 2:
        return l10n.tuesday;
      case 3:
        return l10n.wednesday;
      case 4:
        return l10n.thursday;
      case 5:
        return l10n.friday;
      case 6:
        return l10n.saturday;
      case 7:
        return l10n.sunday;
      default:
        return l10n.monday;
    }
  }

  String _getDayOrdinal(int day) {
    // Just return the number - ordinal suffixes don't translate well
    return day.toString();
  }

  void _showReminderDialog(BuildContext context, WidgetRef ref, ReminderSettings currentSettings) {
    final colors = AppColors.of(context);
    var frequency = currentSettings.frequency;
    var hour = currentSettings.hour;
    var minute = currentSettings.minute;
    var dayOfWeek = currentSettings.dayOfWeek;
    var dayOfMonth = currentSettings.dayOfMonth;

    showDialog(
      context: context,
      builder: (context) {
        final dialogL10n = AppLocalizations.of(context)!;
        return StatefulBuilder(
          builder: (context, setState) => AlertDialog(
            backgroundColor: colors.surface,
            title: Text(
              dialogL10n.measurementReminder,
              style: AppTypography.title(color: colors.textPrimary),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  dialogL10n.frequency,
                  style: AppTypography.caption(color: colors.textSecondary),
                ),
                const SizedBox(height: AppSpacing.sm),
                SegmentedButton<ReminderFrequency>(
                  segments: [
                    ButtonSegment(value: ReminderFrequency.off, label: Text(dialogL10n.off)),
                    ButtonSegment(value: ReminderFrequency.weekly, label: Text(dialogL10n.weekly)),
                    ButtonSegment(value: ReminderFrequency.monthly, label: Text(dialogL10n.monthly)),
                  ],
                  selected: {frequency},
                  onSelectionChanged: (selected) {
                    setState(() => frequency = selected.first);
                  },
                ),
                if (frequency != ReminderFrequency.off) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    dialogL10n.time,
                    style: AppTypography.caption(color: colors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  InkWell(
                    onTap: () async {
                      final time = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(hour: hour, minute: minute),
                      );
                      if (time != null) {
                        setState(() {
                          hour = time.hour;
                          minute = time.minute;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: colors.border),
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            TimeOfDay(hour: hour, minute: minute).format(context),
                            style: AppTypography.body(color: colors.textPrimary),
                          ),
                          Icon(Icons.access_time, color: colors.textSecondary),
                        ],
                      ),
                    ),
                  ),
                ],
                if (frequency == ReminderFrequency.weekly) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    dialogL10n.dayOfWeek,
                    style: AppTypography.caption(color: colors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<int>(
                    initialValue: dayOfWeek,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    items: List.generate(7, (index) {
                      return DropdownMenuItem(
                        value: index + 1,
                        child: Text(_getLocalizedDayName(dialogL10n, index + 1)),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => dayOfWeek = value);
                      }
                    },
                  ),
                ],
                if (frequency == ReminderFrequency.monthly) ...[
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    dialogL10n.dayOfMonth,
                    style: AppTypography.caption(color: colors.textSecondary),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  DropdownButtonFormField<int>(
                    initialValue: dayOfMonth,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppRadius.sm),
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: AppSpacing.md,
                        vertical: AppSpacing.sm,
                      ),
                    ),
                    items: List.generate(28, (index) {
                      return DropdownMenuItem(
                        value: index + 1,
                        child: Text(_getDayOrdinal(index + 1)),
                      );
                    }),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => dayOfMonth = value);
                      }
                    },
                  ),
                ],
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  dialogL10n.cancel,
                  style: AppTypography.body(color: colors.textSecondary),
                ),
              ),
              TextButton(
                onPressed: () async {
                  final newSettings = ReminderSettings(
                    frequency: frequency,
                    hour: hour,
                    minute: minute,
                    dayOfWeek: dayOfWeek,
                    dayOfMonth: dayOfMonth,
                  );
                  
                  await ref.read(reminderSettingsProvider.notifier).updateSettings(newSettings);
                  
                  final notificationService = NotificationService();
                  
                  switch (frequency) {
                    case ReminderFrequency.off:
                      await notificationService.cancelAllReminders();
                    case ReminderFrequency.weekly:
                      await notificationService.requestPermissions();
                      await notificationService.scheduleWeeklyReminder(
                        dayOfWeek: dayOfWeek,
                        hour: hour,
                        minute: minute,
                      );
                    case ReminderFrequency.monthly:
                      await notificationService.requestPermissions();
                      await notificationService.scheduleMonthlyReminder(
                        dayOfMonth: dayOfMonth,
                        hour: hour,
                        minute: minute,
                      );
                  }
                  
                  if (context.mounted) {
                    Navigator.pop(context);
                  }
                },
                child: Text(
                  dialogL10n.save,
                  style: AppTypography.body(color: colors.accent),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showGoalDialog(BuildContext context, WidgetRef ref, String profileId, double? currentGoal) {
    final colors = AppColors.of(context);
    final controller = TextEditingController(
      text: currentGoal?.toStringAsFixed(0) ?? '',
    );

    showDialog(
      context: context,
      builder: (context) {
        final dialogL10n = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            dialogL10n.setVatGoal,
            style: AppTypography.title(color: colors.textPrimary),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                dialogL10n.setVatGoalDescription,
                style: AppTypography.caption(color: colors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Goal (cm\u00B2)',
                  hintText: dialogL10n.goalHint,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                dialogL10n.goalTip,
                style: AppTypography.caption(color: colors.success),
              ),
            ],
          ),
          actions: [
            if (currentGoal != null)
              TextButton(
                onPressed: () {
                  ref.read(vatGoalFamilyProvider(profileId).notifier).setGoal(null);
                  Navigator.pop(context);
                },
                child: Text(
                  dialogL10n.clear,
                  style: AppTypography.body(color: colors.danger),
                ),
              ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                dialogL10n.cancel,
                style: AppTypography.body(color: colors.textSecondary),
              ),
            ),
            TextButton(
              onPressed: () {
                final value = double.tryParse(controller.text);
                if (value != null && value > 0) {
                  ref.read(vatGoalFamilyProvider(profileId).notifier).setGoal(value);
                }
                Navigator.pop(context);
              },
              child: Text(
                dialogL10n.save,
                style: AppTypography.body(color: colors.accent),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildProfileItem(
    BuildContext context,
    WidgetRef ref, {
    required UserProfile profile,
    required bool isActive,
    required AppColorScheme colors,
  }) {
    final l10n = AppLocalizations.of(context)!;
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
        '${profile.sex == Sex.male ? l10n.male : l10n.female}, ${l10n.ageYears(profile.age)}',
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
      builder: (context) {
        final dialogL10n = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            dialogL10n.deleteProfile,
            style: AppTypography.title(color: colors.textPrimary),
          ),
          content: Text(
            dialogL10n.deleteProfileConfirmation(profile.name),
            style: AppTypography.body(color: colors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                dialogL10n.cancel,
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
                dialogL10n.delete,
                style: AppTypography.body(color: colors.danger),
              ),
            ),
          ],
        );
      },
    );
  }

  void _showResetAllConfirmation(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);

    showDialog(
      context: context,
      builder: (context) {
        final dialogL10n = AppLocalizations.of(context)!;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: Text(
            dialogL10n.resetAllData,
            style: AppTypography.title(color: colors.textPrimary),
          ),
          content: Text(
            dialogL10n.resetAllDataConfirmation,
            style: AppTypography.body(color: colors.textSecondary),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                dialogL10n.cancel,
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
                dialogL10n.reset,
                style: AppTypography.body(color: colors.danger),
              ),
            ),
          ],
        );
      },
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
