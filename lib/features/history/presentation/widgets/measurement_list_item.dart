import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';

class MeasurementListItem extends StatelessWidget {
  final Measurement measurement;
  final VoidCallback onDelete;

  const MeasurementListItem({
    super.key,
    required this.measurement,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    final riskColor = switch (measurement.riskCategory) {
      RiskCategory.healthy => colors.success,
      RiskCategory.elevated => colors.warning,
      RiskCategory.obesity => colors.danger,
    };

    return Dismissible(
      key: Key('measurement_${measurement.id}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDelete(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: AppSpacing.lg),
        decoration: BoxDecoration(
          color: colors.danger,
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: colors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 4,
              height: 40,
              decoration: BoxDecoration(
                color: riskColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    dateFormat.format(measurement.timestamp),
                    style: AppTypography.body(color: colors.textPrimary),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Waist: ${measurement.waistCm.toStringAsFixed(1)} cm',
                    style: AppTypography.caption(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  measurement.vatCm2.toStringAsFixed(2),
                  style: AppTypography.title(color: colors.textPrimary),
                ),
                Text(
                  'cm\u00B2',
                  style: AppTypography.caption(color: colors.textSecondary),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
