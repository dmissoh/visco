import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/export/services/pdf_export_service.dart';
import 'package:visco/features/history/presentation/widgets/measurement_list_item.dart';
import 'package:visco/features/history/presentation/widgets/progress_chart.dart';
import 'package:visco/features/history/presentation/widgets/time_range_selector.dart';
import 'package:visco/features/history/presentation/widgets/trajectory_card.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/premium/presentation/screens/paywall_screen.dart';
import 'package:visco/features/premium/providers/premium_provider.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final measurements = ref.watch(filteredMeasurementsProvider);
    final profile = ref.watch(profileNotifierProvider);
    final goalValue = profile != null 
        ? ref.watch(vatGoalFamilyProvider(profile.id)) 
        : null;
    final hasLockedMeasurements = ref.watch(hasLockedMeasurementsProvider);
    final lockedCount = ref.watch(lockedMeasurementsCountProvider);
    final isPremium = ref.watch(isPremiumProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.navProgress),
        actions: [
          if (measurements.isNotEmpty && profile != null)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () async {
                // Doctor's Report is a premium feature
                if (!isPremium) {
                  final upgraded = await showPaywall(
                    context,
                    featureName: l10n.doctorsReport,
                  );
                  if (!upgraded) return;
                }
                if (context.mounted) {
                  PdfExportService.exportMeasurements(
                    profile: profile,
                    measurements: measurements,
                  );
                }
              },
              tooltip: l10n.doctorsReport,
            ),
        ],
      ),
      body: SafeArea(
        child: measurements.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.bar_chart_rounded,
                      size: 64,
                      color: colors.textTertiary,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      l10n.noMeasurementsYet,
                      style: AppTypography.body(color: colors.textSecondary),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.startTrackingToSeeProgress,
                      style: AppTypography.caption(color: colors.textTertiary),
                    ),
                  ],
                ),
              )
            : CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.visceralFatTrend,
                            style:
                                AppTypography.headline(color: colors.textPrimary),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          SizedBox(
                            height: 200,
                            child: ProgressChart(
                              measurements: measurements,
                              goalValue: goalValue,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          const TimeRangeSelector(),
                          const SizedBox(height: AppSpacing.xl),
                          const TrajectoryCard(),
                          const SizedBox(height: AppSpacing.xl),
                          Text(
                            l10n.history,
                            style: AppTypography.title(color: colors.textPrimary),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          final measurement = measurements[index];
                          return Padding(
                            padding:
                                const EdgeInsets.only(bottom: AppSpacing.md),
                            child: MeasurementListItem(
                              measurement: measurement,
                              onDelete: () {
                                ref
                                    .read(measurementNotifierProvider.notifier)
                                    .deleteMeasurement(measurement.id);
                              },
                            ),
                          );
                        },
                        childCount: measurements.length,
                      ),
                    ),
                  ),
                  // Show locked measurements upsell
                  if (hasLockedMeasurements)
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.all(AppSpacing.lg),
                        child: _LockedHistoryCard(
                          lockedCount: lockedCount,
                          colors: colors,
                          l10n: l10n,
                        ),
                      ),
                    ),
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: AppSpacing.xl),
                  ),
                ],
              ),
      ),
    );
  }
}

class _LockedHistoryCard extends StatelessWidget {
  final int lockedCount;
  final AppColorScheme colors;
  final AppLocalizations l10n;

  const _LockedHistoryCard({
    required this.lockedCount,
    required this.colors,
    required this.l10n,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPaywall(context, featureName: l10n.unlimitedHistory),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: colors.accent.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Icon(
                Icons.lock_outline,
                color: colors.accent,
                size: 24,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.olderMeasurements(lockedCount),
                    style: AppTypography.body(color: colors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.unlockFullProgress,
                    style: AppTypography.caption(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
