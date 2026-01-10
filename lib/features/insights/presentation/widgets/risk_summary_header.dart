import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class RiskSummaryHeader extends StatelessWidget {
  final RiskCategory riskCategory;
  final double vatValue;
  final String title;
  final String description;
  final bool isImproving;

  const RiskSummaryHeader({
    super.key,
    required this.riskCategory,
    required this.vatValue,
    required this.title,
    required this.description,
    required this.isImproving,
  });

  Color _getBackgroundColor(AppColorScheme colors) {
    switch (riskCategory) {
      case RiskCategory.healthy:
        return colors.success;
      case RiskCategory.elevated:
        return colors.warning;
      case RiskCategory.obesity:
        return colors.danger;
    }
  }

  IconData _getIcon() {
    switch (riskCategory) {
      case RiskCategory.healthy:
        return Icons.check_circle;
      case RiskCategory.elevated:
        return Icons.warning_amber;
      case RiskCategory.obesity:
        return Icons.error;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final backgroundColor = _getBackgroundColor(colors);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            backgroundColor,
            backgroundColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.sm),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  _getIcon(),
                  size: 28,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppTypography.title(color: Colors.white),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        Text(
                          '${vatValue.toStringAsFixed(1)} cm\u00B2',
                          style: AppTypography.headline(color: Colors.white),
                        ),
                        if (isImproving) ...[
                          const SizedBox(width: AppSpacing.sm),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.sm,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(AppRadius.full),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.trending_down,
                                  size: 14,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  l10n.improving,
                                  style: AppTypography.label(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            description,
            style: AppTypography.body(
              color: Colors.white.withValues(alpha: 0.9),
            ),
          ),
        ],
      ),
    );
  }
}
