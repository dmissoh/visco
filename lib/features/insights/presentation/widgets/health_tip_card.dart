import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/insights/domain/models/health_tip.dart';

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

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
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
                _buildHeader(colors, categoryColor),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.tip.description,
                  style: AppTypography.body(color: colors.textPrimary),
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: AppSpacing.md),
                  _buildActionItems(colors, categoryColor),
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

  Widget _buildHeader(AppColorScheme colors, Color categoryColor) {
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
                widget.tip.title,
                style: AppTypography.title(color: colors.textPrimary),
              ),
              const SizedBox(height: 2),
              _buildCategoryBadge(colors, categoryColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryBadge(AppColorScheme colors, Color categoryColor) {
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
        widget.tip.categoryLabel,
        style: AppTypography.label(color: categoryColor),
      ),
    );
  }

  Widget _buildActionItems(AppColorScheme colors, Color categoryColor) {
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
                'Action Items',
                style: AppTypography.label(color: categoryColor),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ...widget.tip.actionItems.map((item) {
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
