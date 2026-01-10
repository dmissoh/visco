import 'package:flutter/material.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/insights/domain/models/health_risk.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class HealthRiskCard extends StatefulWidget {
  final HealthRisk risk;
  final bool initiallyExpanded;

  const HealthRiskCard({
    super.key,
    required this.risk,
    this.initiallyExpanded = false,
  });

  @override
  State<HealthRiskCard> createState() => _HealthRiskCardState();
}

class _HealthRiskCardState extends State<HealthRiskCard> {
  late bool _isExpanded;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  Color _getSeverityColor(AppColorScheme colors) {
    switch (widget.risk.severity) {
      case RiskSeverity.veryHigh:
        return colors.danger;
      case RiskSeverity.high:
        return colors.warning;
      case RiskSeverity.moderate:
        return colors.textSecondary;
    }
  }

  IconData _getSeverityIcon() {
    switch (widget.risk.severity) {
      case RiskSeverity.veryHigh:
        return Icons.warning_rounded;
      case RiskSeverity.high:
        return Icons.error_outline;
      case RiskSeverity.moderate:
        return Icons.info_outline;
    }
  }

  String _getSeverityLabel(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (widget.risk.severity) {
      case RiskSeverity.veryHigh:
        return l10n.riskHigh;
      case RiskSeverity.high:
        return l10n.riskElevatedRisk;
      case RiskSeverity.moderate:
        return l10n.riskModerate;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final severityColor = _getSeverityColor(colors);

    return Container(
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: severityColor.withValues(alpha: 0.3),
        ),
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
                _buildHeader(context, colors, severityColor),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  widget.risk.description,
                  style: AppTypography.body(color: colors.textPrimary),
                ),
                if (_isExpanded) ...[
                  const SizedBox(height: AppSpacing.md),
                  _buildDetails(colors),
                  const SizedBox(height: AppSpacing.sm),
                  _buildSources(colors),
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

  Widget _buildHeader(BuildContext context, AppColorScheme colors, Color severityColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: severityColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Icon(
            _getSeverityIcon(),
            size: 20,
            color: severityColor,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.risk.title,
                style: AppTypography.title(color: colors.textPrimary),
              ),
              const SizedBox(height: 2),
              _buildSeverityBadge(context, colors, severityColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSeverityBadge(BuildContext context, AppColorScheme colors, Color severityColor) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: severityColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: severityColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            _getSeverityLabel(context),
            style: AppTypography.label(color: severityColor),
          ),
        ],
      ),
    );
  }

  Widget _buildDetails(AppColorScheme colors) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: widget.risk.details.map((detail) {
          return Padding(
            padding: const EdgeInsets.only(bottom: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\u2022 ',
                  style: AppTypography.body(color: colors.textSecondary),
                ),
                Expanded(
                  child: Text(
                    detail,
                    style: AppTypography.caption(color: colors.textPrimary),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildSources(AppColorScheme colors) {
    return Row(
      children: [
        Icon(
          Icons.science_outlined,
          size: 14,
          color: colors.textTertiary,
        ),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            'Sources: ${widget.risk.sources.join(', ')}',
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
