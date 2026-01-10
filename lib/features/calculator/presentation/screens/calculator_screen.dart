import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/insights/presentation/widgets/insights_card.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/l10n/generated/app_localizations.dart';
import 'package:visco/shared/widgets/trend_indicator.dart';

class CalculatorScreen extends ConsumerWidget {
  const CalculatorScreen({super.key});

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final latestMeasurement = ref.watch(latestMeasurementProvider);
    final profile = ref.watch(profileNotifierProvider);
    final trend = ref.watch(vatTrendProvider);
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Show create profile prompt if no profile exists
    if (profile == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.navCalculate),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_rounded),
              onPressed: () => context.push('/help'),
              tooltip: l10n.help,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 80,
                  color: colors.textTertiary,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.createProfileToStart,
                  style: AppTypography.headline(color: colors.textPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.createProfileExplanation,
                  style: AppTypography.body(color: colors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => context.push('/new-profile'),
                    child: Text(l10n.createProfile),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () => context.push('/settings'),
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                backgroundImage: profile.profileImagePath != null
                    ? FileImage(File(profile.profileImagePath!))
                    : null,
                child: profile.profileImagePath == null
                    ? Text(
                        _getInitials(profile.name),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                profile.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/help'),
            icon: const Icon(Icons.help_outline_rounded, size: 20),
            label: Text(l10n.help),
          ),
        ],
      ),
      body: SafeArea(
        child: latestMeasurement == null
            ? _buildEmptyState(context, colors, l10n)
            : _buildDashboard(context, colors, l10n, latestMeasurement, trend, dateFormat),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, AppColorScheme colors, AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.add_circle_outline,
            size: 80,
            color: colors.textTertiary,
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.noMeasurementsYet,
            style: AppTypography.headline(color: colors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.tapToAddMeasurement,
            style: AppTypography.body(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildDashboard(
    BuildContext context,
    AppColorScheme colors,
    AppLocalizations l10n,
    dynamic measurement,
    dynamic trend,
    DateFormat dateFormat,
  ) {
    final isToday = DateUtils.isSameDay(
      measurement.timestamp,
      DateTime.now(),
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Latest Measurement Section
          Text(
            l10n.latestMeasurement,
            style: AppTypography.headline(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          GestureDetector(
            onTap: () => context.push('/result', extra: measurement),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(
                color: colors.surface,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: colors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'VAT',
                            style: AppTypography.caption(color: colors.textSecondary),
                          ),
                          const SizedBox(height: AppSpacing.xs),
                          Row(
                            children: [
                              Text(
                                '${measurement.vatCm2.toStringAsFixed(1)} cm\u00B2',
                                style: AppTypography.headline(color: colors.textPrimary),
                              ),
                              const SizedBox(width: AppSpacing.sm),
                              TrendIndicator(trend: trend),
                            ],
                          ),
                        ],
                      ),
                      Icon(
                        Icons.chevron_right,
                        color: colors.textSecondary,
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Divider(color: colors.border),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'BMI',
                              style: AppTypography.caption(color: colors.textSecondary),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              measurement.bmi.toStringAsFixed(1),
                              style: AppTypography.body(color: colors.textPrimary),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n.measured,
                              style: AppTypography.caption(color: colors.textSecondary),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              isToday ? l10n.today : dateFormat.format(measurement.timestamp),
                              style: AppTypography.body(color: colors.textPrimary),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          // Insights Card
          const InsightsCard(),
        ],
      ),
    );
  }
}
