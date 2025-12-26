import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';

class VatResultCard extends StatelessWidget {
  final Measurement measurement;

  const VatResultCard({
    super.key,
    required this.measurement,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final riskColor = switch (measurement.riskCategory) {
      RiskCategory.healthy => colors.success,
      RiskCategory.elevated => colors.warning,
      RiskCategory.obesity => colors.danger,
    };

    final riskLabel = switch (measurement.riskCategory) {
      RiskCategory.healthy => 'Healthy',
      RiskCategory.elevated => 'Elevated',
      RiskCategory.obesity => 'Visceral Obesity',
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '${measurement.vatCm2.toStringAsFixed(2)} cm\u00B2',
            style: AppTypography.display(color: colors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Visceral Fat Area',
            style: AppTypography.caption(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: riskColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: riskColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  riskLabel,
                  style: AppTypography.label(color: riskColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
