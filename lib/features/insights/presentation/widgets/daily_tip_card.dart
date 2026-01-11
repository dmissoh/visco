import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

/// Model for a health tip
class HealthTip {
  final String title;
  final String description;
  final IconData icon;

  const HealthTip({
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Provider that selects a random tip once per app session
final dailyTipIndexProvider = StateProvider<int>((ref) {
  return Random().nextInt(7); // 7 tips available
});

/// A card that displays a random health tip on the home screen
class DailyTipCard extends ConsumerWidget {
  const DailyTipCard({super.key});

  List<HealthTip> _getTips(AppLocalizations l10n) {
    return [
      HealthTip(
        title: l10n.tipActivity,
        description: l10n.tipActivityDesc,
        icon: Icons.directions_run,
      ),
      HealthTip(
        title: l10n.tipDiet,
        description: l10n.tipDietDesc,
        icon: Icons.restaurant,
      ),
      HealthTip(
        title: l10n.tipWeight,
        description: l10n.tipWeightDesc,
        icon: Icons.monitor_weight_outlined,
      ),
      HealthTip(
        title: l10n.tipSedentary,
        description: l10n.tipSedentaryDesc,
        icon: Icons.chair_outlined,
      ),
      HealthTip(
        title: l10n.tipSleepStress,
        description: l10n.tipSleepStressDesc,
        icon: Icons.bedtime_outlined,
      ),
      HealthTip(
        title: l10n.tipAlcohol,
        description: l10n.tipAlcoholDesc,
        icon: Icons.no_drinks_outlined,
      ),
      HealthTip(
        title: l10n.tipSmoking,
        description: l10n.tipSmokingDesc,
        icon: Icons.smoke_free,
      ),
    ];
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final tipIndex = ref.watch(dailyTipIndexProvider);
    final tips = _getTips(l10n);
    final tip = tips[tipIndex % tips.length];

    return GestureDetector(
      onTap: () => context.push('/insights'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              colors.accent.withValues(alpha: 0.12),
              colors.accent.withValues(alpha: 0.04),
            ],
          ),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: colors.accent.withValues(alpha: 0.25),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: colors.accent.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(
                    tip.icon,
                    size: 20,
                    color: colors.accent,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Text(
                    tip.title,
                    style: AppTypography.title(color: colors.textPrimary),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: colors.textSecondary,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Padding(
              padding: const EdgeInsets.only(left: 44), // Align with title
              child: Text(
                tip.description,
                style: AppTypography.caption(color: colors.textSecondary),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
