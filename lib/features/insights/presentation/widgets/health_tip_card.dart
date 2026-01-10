import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/insights/domain/models/health_tip.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class HealthTipCard extends StatefulWidget {
  final HealthTip tip;
  final bool initiallyExpanded;

  const HealthTipCard({
    super.key,
    required this.tip,
    this.initiallyExpanded = false,
  });

  @override
  State<HealthTipCard> createState() => _HealthTipCardState();
}

class _HealthTipCardState extends State<HealthTipCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  Color _getCategoryColor(AppColorScheme colors) {
    switch (widget.tip.category) {
      case TipCategory.activity:
        return colors.success;
      case TipCategory.diet:
        return colors.accent;
      case TipCategory.weightManagement:
        return colors.warning;
      case TipCategory.lifestyle:
        return const Color(0xFF6366F1); // Indigo
      case TipCategory.sleepStress:
        return const Color(0xFF8B5CF6); // Purple
      case TipCategory.alcohol:
        return colors.warning;
      case TipCategory.smoking:
        return colors.danger;
    }
  }

  String _getLocalizedTitle(AppLocalizations l10n) {
    switch (widget.tip.category) {
      case TipCategory.activity:
        return l10n.tipActivity;
      case TipCategory.diet:
        return l10n.tipDiet;
      case TipCategory.weightManagement:
        return l10n.tipWeight;
      case TipCategory.lifestyle:
        return l10n.tipSedentary;
      case TipCategory.sleepStress:
        return l10n.tipSleepStress;
      case TipCategory.alcohol:
        return l10n.tipAlcohol;
      case TipCategory.smoking:
        return l10n.tipSmoking;
    }
  }

  String _getLocalizedDescription(AppLocalizations l10n) {
    switch (widget.tip.category) {
      case TipCategory.activity:
        return l10n.tipActivityDesc;
      case TipCategory.diet:
        return l10n.tipDietDesc;
      case TipCategory.weightManagement:
        return l10n.tipWeightDesc;
      case TipCategory.lifestyle:
        return l10n.tipSedentaryDesc;
      case TipCategory.sleepStress:
        return l10n.tipSleepStressDesc;
      case TipCategory.alcohol:
        return l10n.tipAlcoholDesc;
      case TipCategory.smoking:
        return l10n.tipSmokingDesc;
    }
  }

  List<String> _getLocalizedActionItems(AppLocalizations l10n) {
    switch (widget.tip.category) {
      case TipCategory.activity:
        return [
          l10n.tipActivityAction1,
          l10n.tipActivityAction2,
          l10n.tipActivityAction3,
          l10n.tipActivityAction4,
        ];
      case TipCategory.diet:
        return [
          l10n.tipDietAction1,
          l10n.tipDietAction2,
          l10n.tipDietAction3,
          l10n.tipDietAction4,
          l10n.tipDietAction5,
        ];
      case TipCategory.weightManagement:
        return [
          l10n.tipWeightAction1,
          l10n.tipWeightAction2,
          l10n.tipWeightAction3,
          l10n.tipWeightAction4,
        ];
      case TipCategory.lifestyle:
        return [
          l10n.tipSedentaryAction1,
          l10n.tipSedentaryAction2,
          l10n.tipSedentaryAction3,
          l10n.tipSedentaryAction4,
          l10n.tipSedentaryAction5,
        ];
      case TipCategory.sleepStress:
        return [
          l10n.tipSleepStressAction1,
          l10n.tipSleepStressAction2,
          l10n.tipSleepStressAction3,
          l10n.tipSleepStressAction4,
          l10n.tipSleepStressAction5,
        ];
      case TipCategory.alcohol:
        return [
          l10n.tipAlcoholAction1,
          l10n.tipAlcoholAction2,
          l10n.tipAlcoholAction3,
          l10n.tipAlcoholAction4,
        ];
      case TipCategory.smoking:
        return [
          l10n.tipSmokingAction1,
          l10n.tipSmokingAction2,
          l10n.tipSmokingAction3,
          l10n.tipSmokingAction4,
        ];
    }
  }

  String _getLocalizedCategoryLabel(AppLocalizations l10n) {
    switch (widget.tip.category) {
      case TipCategory.activity:
        return l10n.categoryPhysicalActivity;
      case TipCategory.diet:
        return l10n.categoryDiet;
      case TipCategory.weightManagement:
        return l10n.categoryWeightManagement;
      case TipCategory.lifestyle:
        return l10n.categoryLifestyle;
      case TipCategory.sleepStress:
        return l10n.categorySleepStress;
      case TipCategory.alcohol:
        return l10n.categoryAlcohol;
      case TipCategory.smoking:
        return l10n.categorySmoking;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final categoryColor = _getCategoryColor(colors);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => setState(() => _isExpanded = !_isExpanded),
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(colors, categoryColor, l10n),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  _getLocalizedDescription(l10n),
                  style: AppTypography.body(color: colors.textPrimary),
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: AppSpacing.md),
                  _buildActionItems(context, colors, categoryColor, l10n),
                  const SizedBox(height: AppSpacing.sm),
                  _buildSource(colors),
                ],
                const SizedBox(height: AppSpacing.sm),
                _buildExpandButton(colors),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(AppColorScheme colors, Color categoryColor, AppLocalizations l10n) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: categoryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            widget.tip.icon,
            size: 20,
            color: categoryColor,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _getLocalizedTitle(l10n),
                style: AppTypography.title(color: colors.textPrimary),
              ),
              const SizedBox(height: 2),
              _buildCategoryBadge(colors, categoryColor, l10n),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(AppColorScheme colors, Color categoryColor, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Text(
        _getLocalizedCategoryLabel(l10n),
        style: AppTypography.label(color: categoryColor),
      ),
    );
  }

  Widget _buildActionItems(BuildContext context, AppColorScheme colors, Color categoryColor, AppLocalizations l10n) {
    final actionItems = _getLocalizedActionItems(l10n);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: categoryColor.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(
          color: categoryColor.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.checklist,
                size: 16,
                color: categoryColor,
              ),
              const SizedBox(width: 4),
              Text(
                l10n.actionItems,
                style: AppTypography.label(color: categoryColor),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ...actionItems.map((item) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.check_circle_outline,
                    size: 16,
                    color: categoryColor,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      item,
                      style: AppTypography.caption(color: colors.textPrimary),
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSource(AppColorScheme colors) {
    return Row(
      children: [
        Icon(
          Icons.menu_book_outlined,
          size: 14,
          color: colors.textTertiary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'Source: ${widget.tip.evidenceSource}',
            style: AppTypography.caption(color: colors.textTertiary),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  Widget _buildExpandButton(AppColorScheme colors) {
    return Center(
      child: Icon(
        _isExpanded ? Icons.expand_less : Icons.expand_more,
        size: 20,
        color: colors.textTertiary,
      ),
    );
  }
}
