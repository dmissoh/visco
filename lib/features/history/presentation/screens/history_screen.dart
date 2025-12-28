import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/history/presentation/widgets/measurement_list_item.dart';
import 'package:visco/features/history/presentation/widgets/progress_chart.dart';
import 'package:visco/features/history/presentation/widgets/time_range_selector.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';

class HistoryScreen extends ConsumerWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final measurements = ref.watch(filteredMeasurementsProvider);
    final goalValue = ref.watch(vatGoalProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
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
                      'No measurements yet',
                      style: AppTypography.body(color: colors.textSecondary),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      'Start tracking to see your progress',
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
                            'Visceral Fat Trend',
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
                          Text(
                            'History',
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
                  const SliverPadding(
                    padding: EdgeInsets.only(bottom: AppSpacing.xl),
                  ),
                ],
              ),
      ),
    );
  }
}
