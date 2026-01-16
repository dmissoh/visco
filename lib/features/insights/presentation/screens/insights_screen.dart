import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/insights/domain/data/insights_data.dart';
import 'package:visco/features/insights/presentation/providers/insights_provider.dart';
import 'package:visco/features/insights/presentation/widgets/health_tip_card.dart';
import 'package:visco/features/insights/presentation/widgets/risk_summary_header.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class InsightsScreen extends ConsumerWidget {
  final Measurement? measurement;
  
  /// When true, shows general educational content without personalized header
  final bool educationalMode;

  const InsightsScreen({
    super.key,
    this.measurement,
    this.educationalMode = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    // In educational mode, show general content without personalization
    if (educationalMode) {
      return _buildEducationalContent(context, colors, l10n);
    }

    // Use measurement-specific insights if provided, otherwise use latest
    final insights = measurement != null
        ? ref.watch(measurementInsightsProvider(measurement!))
        : ref.watch(insightsProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.healthInsights),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Risk Summary Header
              RiskSummaryHeader(
                riskCategory: insights.riskCategory,
                vatValue: insights.vatValue,
                title: _getSummaryTitle(l10n, insights.riskCategory, insights.hasMeasurement),
                description: _getSummaryDescription(l10n, insights.riskCategory, insights.isImproving, insights.hasMeasurement),
                isImproving: insights.isImproving,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Scientific Source Citation (prominently displayed)
              _buildScientificSourceCard(context, colors, l10n),

              const SizedBox(height: AppSpacing.xl),

              // Health Tips Section
              _buildSectionHeader(
                context,
                title: l10n.evidenceBasedTips,
                subtitle: l10n.evidenceBasedTipsSubtitle,
              ),
              const SizedBox(height: AppSpacing.md),

              // Priority tips for the user's risk level
              if (insights.riskCategory != RiskCategory.healthy) ...[
                _buildTipsSectionLabel(context, l10n.recommendedForYou),
                const SizedBox(height: AppSpacing.sm),
                ...insights.priorityTips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: HealthTipCard(tip: tip),
                    )),
              ] else ...[
                // For healthy users, show maintenance tips
                _buildTipsSectionLabel(context, l10n.maintainYourHealth),
                const SizedBox(height: AppSpacing.sm),
                ...insights.priorityTips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: HealthTipCard(tip: tip),
                    )),
                const SizedBox(height: AppSpacing.lg),
                _buildTipsSectionLabel(context, l10n.additionalTips),
                const SizedBox(height: AppSpacing.sm),
                ...insights.allTips
                    .where((tip) => !insights.priorityTips.contains(tip))
                    .map((tip) => Padding(
                          padding: const EdgeInsets.only(bottom: AppSpacing.md),
                          child: HealthTipCard(tip: tip),
                        )),
              ],

              const SizedBox(height: AppSpacing.xl),

              // Disclaimer
              _buildDisclaimer(context, l10n),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationalContent(BuildContext context, AppColorScheme colors, AppLocalizations l10n) {
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.healthInsights),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Educational intro instead of personalized header
              _buildEducationalHeader(context, colors, l10n),

              const SizedBox(height: AppSpacing.xl),

              // Scientific Source Citation (prominently displayed)
              _buildScientificSourceCard(context, colors, l10n),

              const SizedBox(height: AppSpacing.xl),

              // Health Tips Section - show all tips
              _buildSectionHeader(
                context,
                title: l10n.evidenceBasedTips,
                subtitle: l10n.evidenceBasedTipsSubtitle,
              ),
              const SizedBox(height: AppSpacing.md),
              ...InsightsData.tips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: HealthTipCard(tip: tip),
                  )),

              const SizedBox(height: AppSpacing.xl),

              // Disclaimer
              _buildDisclaimer(context, l10n),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationalHeader(BuildContext context, AppColorScheme colors, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: colors.accent.withValues(alpha: 0.3),
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
                  color: colors.accent.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  Icons.school_outlined,
                  size: 28,
                  color: colors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  l10n.aboutVisceralFat,
                  style: AppTypography.title(color: colors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.aboutVisceralFatDescription,
            style: AppTypography.body(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context, {
    required String title,
    required String subtitle,
  }) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.headline(color: colors.textPrimary),
        ),
        const SizedBox(height: 4),
        Text(
          subtitle,
          style: AppTypography.caption(color: colors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildTipsSectionLabel(BuildContext context, String label) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Text(
        label,
        style: AppTypography.label(color: colors.accent),
      ),
    );
  }

  Widget _buildScientificSourceCard(BuildContext context, AppColorScheme colors, AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.accent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.science_outlined,
                size: 20,
                color: colors.accent,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.calculationMethodTitle,
                style: AppTypography.title(color: colors.textPrimary),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.methodDescription,
            style: AppTypography.body(color: colors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.surface,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: colors.border),
            ),
            child: Text(
              l10n.fullCitation,
              style: AppTypography.caption(color: colors.textSecondary).copyWith(
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          InkWell(
            onTap: () => _launchUrl(l10n.scientificSourceUrl),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              decoration: BoxDecoration(
                color: colors.accent,
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.open_in_new,
                    size: 16,
                    color: Colors.white,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Text(
                    l10n.viewScientificSource,
                    style: AppTypography.label(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          InkWell(
            onTap: () => _launchUrl(l10n.calculatorSourceUrl),
            child: Row(
              children: [
                Icon(
                  Icons.link,
                  size: 14,
                  color: colors.accent,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    l10n.calculatorSourceInfo,
                    style: AppTypography.caption(color: colors.accent).copyWith(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisclaimer(BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.warning.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.warning.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.medical_information_outlined,
            size: 20,
            color: colors.warning,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              l10n.disclaimer,
              style: AppTypography.caption(color: colors.textPrimary),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  String _getSummaryTitle(AppLocalizations l10n, RiskCategory category, bool hasMeasurement) {
    if (!hasMeasurement) {
      return l10n.vatSummaryNoMeasurementTitle;
    }
    switch (category) {
      case RiskCategory.healthy:
        return l10n.vatSummaryHealthyTitle;
      case RiskCategory.elevated:
        return l10n.vatSummaryElevatedTitle;
      case RiskCategory.obesity:
        return l10n.vatSummaryHighTitle;
    }
  }

  String _getSummaryDescription(AppLocalizations l10n, RiskCategory category, bool isImproving, bool hasMeasurement) {
    if (!hasMeasurement) {
      return l10n.vatSummaryNoMeasurementDesc;
    }
    switch (category) {
      case RiskCategory.healthy:
        return isImproving ? l10n.vatSummaryHealthyDescImproving : l10n.vatSummaryHealthyDesc;
      case RiskCategory.elevated:
        return isImproving ? l10n.vatSummaryElevatedDescImproving : l10n.vatSummaryElevatedDesc;
      case RiskCategory.obesity:
        return isImproving ? l10n.vatSummaryHighDescImproving : l10n.vatSummaryHighDesc;
    }
  }
}
