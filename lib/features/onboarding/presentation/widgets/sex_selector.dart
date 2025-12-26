import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

class SexSelector extends StatelessWidget {
  final Sex selectedSex;
  final ValueChanged<Sex> onChanged;

  const SexSelector({
    super.key,
    required this.selectedSex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Sex',
          style: AppTypography.caption(color: colors.textSecondary),
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: colors.border),
          ),
          child: Row(
            children: [
              Expanded(
                child: _SexOption(
                  label: 'Male',
                  isSelected: selectedSex == Sex.male,
                  onTap: () => onChanged(Sex.male),
                  isFirst: true,
                ),
              ),
              Container(
                width: 1,
                height: 48,
                color: colors.border,
              ),
              Expanded(
                child: _SexOption(
                  label: 'Female',
                  isSelected: selectedSex == Sex.female,
                  onTap: () => onChanged(Sex.female),
                  isFirst: false,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SexOption extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isFirst;

  const _SexOption({
    required this.label,
    required this.isSelected,
    required this.onTap,
    required this.isFirst,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: isSelected ? colors.accent.withValues(alpha: 0.1) : Colors.transparent,
          borderRadius: BorderRadius.horizontal(
            left: isFirst ? const Radius.circular(AppRadius.md) : Radius.zero,
            right: isFirst ? Radius.zero : const Radius.circular(AppRadius.md),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colors.accent : colors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.accent,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: AppSpacing.sm),
            Text(
              label,
              style: AppTypography.body(
                color: isSelected ? colors.accent : colors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
