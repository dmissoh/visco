import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';

class BmiScaleIndicator extends StatelessWidget {
  final double bmiValue;

  const BmiScaleIndicator({
    super.key,
    required this.bmiValue,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    // BMI scale: 15 to 40 range for display
    final minBmi = 15.0;
    final maxBmi = 40.0;
    final clampedValue = bmiValue.clamp(minBmi, maxBmi);
    final markerPosition = (clampedValue - minBmi) / (maxBmi - minBmi);

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
            height: 50,
            child: LayoutBuilder(
              builder: (context, constraints) {
                final width = constraints.maxWidth;
                final markerX = width * markerPosition;

                // Calculate segment positions (15-40 range = 25 units)
                // Underweight: 15-18.5 = 3.5 units = 14%
                // Normal: 18.5-25 = 6.5 units = 26%
                // Overweight: 25-30 = 5 units = 20%
                // Obese: 30-40 = 10 units = 40%

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
                            // Underweight (15-18.5)
                            Expanded(
                              flex: 14,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: colors.warning,
                                  borderRadius: const BorderRadius.horizontal(
                                    left: Radius.circular(4),
                                  ),
                                ),
                              ),
                            ),
                            // Normal (18.5-25)
                            Expanded(
                              flex: 26,
                              child: Container(
                                color: colors.success,
                              ),
                            ),
                            // Overweight (25-30)
                            Expanded(
                              flex: 20,
                              child: Container(
                                color: colors.warning,
                              ),
                            ),
                            // Obese (30-40)
                            Expanded(
                              flex: 40,
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
                      child: Container(
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
              Text('18.5', style: AppTypography.caption(color: colors.textSecondary)),
              Text('25', style: AppTypography.caption(color: colors.textSecondary)),
              Text('30', style: AppTypography.caption(color: colors.textSecondary)),
            ],
          ),
        ],
      ),
    );
  }
}
