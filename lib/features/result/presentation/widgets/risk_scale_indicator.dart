import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';

class RiskScaleIndicator extends StatelessWidget {
  final double vatValue;

  const RiskScaleIndicator({
    super.key,
    required this.vatValue,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    // Calculate marker position (0 to 200 scale, capped)
    final clampedValue = vatValue.clamp(0.0, 200.0);
    final markerPosition = clampedValue / 200.0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final markerX = width * markerPosition;

                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Scale bar
                    Positioned(
                      top: 20,
                      left: 0,
                      right: 0,
                      child: Container(
                        height: 8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          children: [
                            // Healthy zone (0-100 = 0-50%)
                            Expanded(
                              flex: 50,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors.success,
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            // Elevated zone (100-130 = 50-65%)
                            Expanded(
                              flex: 15,
                              child: Container(
                                color: colors.warning,
                              ),
                            ),
                            // Obesity zone (130-200 = 65-100%)
                            Expanded(
                              flex: 35,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors.danger,
                                  borderRadius: const BorderRadius.horizontal(
                                    right: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Marker
                    Positioned(
                      top: 8,
                      left: markerX - 12,
                      child: Column(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: colors.background,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: colors.textPrimary,
                                width: 3,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildLabel(context, 'Healthy', '< 100'),
              _buildLabel(context, 'Elevated', '100-130'),
              _buildLabel(context, 'Obesity', '\u2265 130'),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: colors.accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              'You: ${vatValue.toStringAsFixed(2)} cm\u00B2',
              style: AppTypography.label(color: colors.accent),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLabel(BuildContext context, String label, String value) {
    final colors = AppColors.of(context);

    return Column(
      children: [
        Text(
          label,
          style: AppTypography.label(color: colors.textSecondary),
        ),
        Text(
          value,
          style: AppTypography.caption(color: colors.textTertiary),
        ),
      ],
    );
  }
}
