import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class MeasurementGuideModal extends StatelessWidget {
  final String measurementType;

  const MeasurementGuideModal({
    super.key,
    required this.measurementType,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
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
                      isWaist ? l10n.howToMeasureWaistShort : l10n.howToMeasureThighShort,
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
                _buildStep(context, '1', l10n.guideWaistStep1),
                _buildStep(context, '2', l10n.guideWaistStep2),
                _buildStep(context, '3', l10n.guideWaistStep3),
                _buildStep(context, '4', l10n.guideWaistStep4),
              ] else ...[
                _buildStep(context, '1', l10n.guideThighStep1),
                _buildStep(context, '2', l10n.guideThighStep2),
                _buildStep(context, '3', l10n.guideThighStep3),
                _buildStep(context, '4', l10n.guideThighStep4),
              ],
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.gotIt),
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
