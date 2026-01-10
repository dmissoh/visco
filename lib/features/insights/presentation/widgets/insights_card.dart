import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/insights/presentation/providers/insights_provider.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class InsightsCard extends ConsumerWidget {
  const InsightsCard({super.key});

  Color _getRiskColor(AppColorScheme colors, RiskCategory category) {
    switch (category) {
      case RiskCategory.healthy:
        return colors.success;
      case RiskCategory.elevated:
        return colors.warning;
      case RiskCategory.obesity:
        return colors.danger;
    }
  }

  IconData _getRiskIcon(RiskCategory category) {
    switch (category) {
      case RiskCategory.healthy:
        return Icons.check_circle_outline;
      case RiskCategory.elevated:
        return Icons.warning_amber_outlined;
      case RiskCategory.obesity:
        return Icons.error_outline;
    }
  }

  String _getRiskLabel(BuildContext context, RiskCategory category) {
    final l10n = AppLocalizations.of(context)!;
    switch (category) {
      case RiskCategory.healthy:
        return l10n.riskHealthy;
      case RiskCategory.elevated:
        return l10n.riskElevated;
      case RiskCategory.obesity:
        return l10n.riskHighRisk;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final insights = ref.watch(insightsProvider);

    // Don't show if no measurement available
    if (insights.vatValue == 0) {
      return const SizedBox.shrink();
    }

    final riskColor = _getRiskColor(colors, insights.riskCategory);

    return GestureDetector(
      onTap: () => context.push('/insights'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              riskColor.withValues(alpha: 0.15),
              riskColor.withValues(alpha: 0.05),
            ],
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: riskColor.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: riskColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                Icons.lightbulb_outline,
                size: 24,
                color: riskColor,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.healthInsights,
                    style: AppTypography.title(color: colors.textPrimary),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        _getRiskIcon(insights.riskCategory),
                        size: 14,
                        color: riskColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        l10n.yourVisceralFatIs(_getRiskLabel(context, insights.riskCategory).toLowerCase()),
                        style: AppTypography.caption(color: colors.textSecondary),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
