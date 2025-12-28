import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';

enum BmiCategory {
  underweight,
  normal,
  overweight,
  obese,
}

class BmiResultCard extends StatelessWidget {
  final double bmi;

  const BmiResultCard({
    super.key,
    required this.bmi,
  });

  BmiCategory get category {
    if (bmi < 18.5) return BmiCategory.underweight;
    if (bmi < 25) return BmiCategory.normal;
    if (bmi < 30) return BmiCategory.overweight;
    return BmiCategory.obese;
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    final categoryColor = switch (category) {
      BmiCategory.underweight => colors.warning,
      BmiCategory.normal => colors.success,
      BmiCategory.overweight => colors.warning,
      BmiCategory.obese => colors.danger,
    };

    final categoryLabel = switch (category) {
      BmiCategory.underweight => 'Underweight',
      BmiCategory.normal => 'Normal',
      BmiCategory.overweight => 'Overweight',
      BmiCategory.obese => 'Obese',
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          Text(
            bmi.toStringAsFixed(1),
            style: AppTypography.display(color: colors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Body Mass Index',
            style: AppTypography.caption(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: categoryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: categoryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  categoryLabel,
                  style: AppTypography.label(color: categoryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
