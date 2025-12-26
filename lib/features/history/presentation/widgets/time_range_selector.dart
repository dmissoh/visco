import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';

class TimeRangeSelector extends ConsumerWidget {
  const TimeRangeSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final selectedRange = ref.watch(timeRangeProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: TimeRange.values.map((range) {
        final isSelected = selectedRange == range;
        final label = switch (range) {
          TimeRange.oneMonth => '1M',
          TimeRange.threeMonths => '3M',
          TimeRange.sixMonths => '6M',
          TimeRange.oneYear => '1Y',
          TimeRange.all => 'All',
        };

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs),
          child: GestureDetector(
            onTap: () => ref.read(timeRangeProvider.notifier).state = range,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: isSelected ? colors.accent : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: isSelected ? colors.accent : colors.border,
                ),
              ),
              child: Text(
                label,
                style: AppTypography.label(
                  color: isSelected ? Colors.white : colors.textSecondary,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
