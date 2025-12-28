import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';

class TrendIndicator extends StatelessWidget {
  final VatTrend trend;
  final bool showLabel;

  const TrendIndicator({
    super.key,
    required this.trend,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    if (trend.direction == TrendDirection.unknown) {
      return const SizedBox.shrink();
    }

    final (icon, color, label) = switch (trend.direction) {
      TrendDirection.up => (Icons.trending_up, colors.danger, 'Up'),
      TrendDirection.down => (Icons.trending_down, colors.success, 'Down'),
      TrendDirection.stable => (Icons.trending_flat, colors.textSecondary, 'Stable'),
      TrendDirection.unknown => (Icons.remove, colors.textSecondary, ''),
    };

    final changeText = trend.change != null
        ? '${trend.change! > 0 ? '+' : ''}${trend.change!.toStringAsFixed(1)}'
        : '';

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: color),
          if (showLabel && changeText.isNotEmpty) ...[
            const SizedBox(width: AppSpacing.xs),
            Text(
              changeText,
              style: AppTypography.caption(color: color),
            ),
          ],
        ],
      ),
    );
  }
}
