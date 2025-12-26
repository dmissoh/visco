import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';

class MeasurementGuideModal extends StatelessWidget {
  final String measurementType;

  const MeasurementGuideModal({
    super.key,
    required this.measurementType,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final isWaist = measurementType == 'waist';

    return Container(
      margin: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 40),
                  Expanded(
                    child: Text(
                      isWaist ? 'How to Measure Waist' : 'How to Measure Thigh',
                      style: AppTypography.title(color: colors.textPrimary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: colors.textSecondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                height: 150,
                decoration: BoxDecoration(
                  color: colors.surface,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Center(
                  child: Icon(
                    isWaist ? Icons.straighten : Icons.accessibility_new,
                    size: 64,
                    color: colors.textSecondary,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              if (isWaist) ...[
                _buildStep(context, '1', 'Stand relaxed, feet together'),
                _buildStep(context, '2',
                    'Wrap tape horizontally at navel (belly button) level'),
                _buildStep(context, '3', 'Keep tape snug but not tight'),
                _buildStep(context, '4', 'Measure at end of normal exhale'),
              ] else ...[
                _buildStep(context, '1', 'Stand straight with feet shoulder-width apart'),
                _buildStep(context, '2',
                    'Measure at the proximal thigh (just below the gluteal fold)'),
                _buildStep(context, '3', 'Wrap tape around the thigh horizontally'),
                _buildStep(context, '4', 'Keep tape snug but not compressing'),
              ],
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text('Got it'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStep(BuildContext context, String number, String text) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Center(
              child: Text(
                number,
                style: AppTypography.label(color: colors.accent),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.body(color: colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
