import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';

class MeasurementsSummary extends StatelessWidget {
  final Measurement measurement;

  const MeasurementsSummary({
    super.key,
    required this.measurement,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Measurements Used',
          style: AppTypography.title(color: colors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.md),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: colors.border),
          ),
          child: Column(
            children: [
              _buildRow(context, 'Waist', '${measurement.waistCm.toStringAsFixed(1)} cm'),
              Divider(height: 1, color: colors.border),
              _buildRow(context, 'Thigh', '${measurement.thighCm.toStringAsFixed(1)} cm'),
              Divider(height: 1, color: colors.border),
              _buildRow(context, 'Weight', '${measurement.weightKg.toStringAsFixed(1)} kg'),
              Divider(height: 1, color: colors.border),
              _buildRow(context, 'BMI', measurement.bmi.toStringAsFixed(2)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRow(BuildContext context, String label, String value) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: AppTypography.body(color: colors.textSecondary),
          ),
          Text(
            value,
            style: AppTypography.body(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }
}
