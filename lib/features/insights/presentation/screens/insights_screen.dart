import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/insights/domain/data/insights_data.dart';
import 'package:visco/features/insights/presentation/providers/insights_provider.dart';
import 'package:visco/features/insights/presentation/widgets/health_risk_card.dart';
import 'package:visco/features/insights/presentation/widgets/health_tip_card.dart';
import 'package:visco/features/insights/presentation/widgets/risk_summary_header.dart';

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

    // In educational mode, show general content without personalization
    if (educationalMode) {
      return _buildEducationalContent(context, colors);
    }

    // Use measurement-specific insights if provided, otherwise use latest
    final insights = measurement != null
        ? ref.watch(measurementInsightsProvider(measurement!))
        : ref.watch(insightsProvider);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Health Insights'),
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
                title: insights.summaryTitle,
                description: insights.summaryDescription,
                isImproving: insights.isImproving,
              ),

              const SizedBox(height: AppSpacing.xl),

              // Health Risks Section
              _buildSectionHeader(
                context,
                title: 'Health Risks of Elevated Visceral Fat',
                subtitle:
                    'Understanding the risks can help motivate positive changes',
              ),
              const SizedBox(height: AppSpacing.md),
              ...insights.risks.map((risk) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: HealthRiskCard(risk: risk),
                  )),

              const SizedBox(height: AppSpacing.xl),

              // Health Tips Section
              _buildSectionHeader(
                context,
                title: 'Evidence-Based Tips',
                subtitle: 'Simple actions to help reduce visceral fat',
              ),
              const SizedBox(height: AppSpacing.md),

              // Priority tips for the user's risk level
              if (insights.riskCategory != RiskCategory.healthy) ...[
                _buildTipsSectionLabel(context, 'Recommended for You'),
                const SizedBox(height: AppSpacing.sm),
                ...insights.priorityTips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: HealthTipCard(tip: tip),
                    )),
              ] else ...[
                // For healthy users, show maintenance tips
                _buildTipsSectionLabel(context, 'Maintain Your Health'),
                const SizedBox(height: AppSpacing.sm),
                ...insights.priorityTips.map((tip) => Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.md),
                      child: HealthTipCard(tip: tip),
                    )),
                const SizedBox(height: AppSpacing.lg),
                _buildTipsSectionLabel(context, 'Additional Tips'),
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
              _buildDisclaimer(context),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationalContent(BuildContext context, AppColorScheme colors) {
    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Health Insights'),
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
              _buildEducationalHeader(context, colors),

              const SizedBox(height: AppSpacing.xl),

              // Health Risks Section
              _buildSectionHeader(
                context,
                title: 'Health Risks of Elevated Visceral Fat',
                subtitle:
                    'Understanding the risks can help motivate positive changes',
              ),
              const SizedBox(height: AppSpacing.md),
              ...InsightsData.risks.map((risk) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: HealthRiskCard(risk: risk),
                  )),

              const SizedBox(height: AppSpacing.xl),

              // Health Tips Section - show all tips
              _buildSectionHeader(
                context,
                title: 'Evidence-Based Tips',
                subtitle: 'Simple actions to help reduce visceral fat',
              ),
              const SizedBox(height: AppSpacing.md),
              ...InsightsData.tips.map((tip) => Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.md),
                    child: HealthTipCard(tip: tip),
                  )),

              const SizedBox(height: AppSpacing.xl),

              // Disclaimer
              _buildDisclaimer(context),

              const SizedBox(height: AppSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEducationalHeader(BuildContext context, AppColorScheme colors) {
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
                  'About Visceral Fat',
                  style: AppTypography.title(color: colors.textPrimary),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Visceral fat is stored deep within the abdominal cavity around internal organs. '
            'Unlike subcutaneous fat, it plays a hormonally active role and is linked to increased health risks. '
            'Learn about the risks and evidence-based ways to reduce it.',
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

  Widget _buildDisclaimer(BuildContext context) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.info_outline,
            size: 20,
            color: colors.textSecondary,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'This information is for educational purposes only and should not replace professional medical advice. Please consult a healthcare provider for personalized guidance.',
              style: AppTypography.caption(color: colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
