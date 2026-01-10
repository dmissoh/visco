import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: Text(l10n.help),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroduction(context, l10n),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: l10n.howToMeasureWaist,
              child: _buildWaistMeasurementGuide(context, l10n),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: l10n.howToMeasureThigh,
              child: _buildThighMeasurementGuide(context, l10n),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: l10n.settingGoalTitle,
              child: _buildGoalExplanation(context, l10n),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: l10n.trendIndicatorTitle,
              child: _buildTrendExplanation(context, l10n),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: l10n.calculationTitle,
              child: _buildCalculationExplanation(context, l10n),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: l10n.understandingResultsTitle,
              child: _buildResultsExplanation(context, l10n),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: l10n.scientificReference,
              child: _buildReference(context, l10n),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduction(BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.aboutVisqo,
            style: AppTypography.title(color: colors.accent),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.aboutVisqoDescription,
            style: AppTypography.body(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required Widget child,
  }) {
    final colors = AppColors.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTypography.headline(color: colors.textPrimary),
        ),
        const SizedBox(height: AppSpacing.md),
        child,
      ],
    );
  }

  Widget _buildCalculationExplanation(
      BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.calculationDescription,
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.calculationModelDescription,
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildFormulaCard(
            context,
            title: l10n.formulaForMen,
            formula: l10n.formulaMen,
            accuracy: l10n.accuracyMen,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildFormulaCard(
            context,
            title: l10n.formulaForWomen,
            formula: l10n.formulaWomen,
            accuracy: l10n.accuracyWomen,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.resultUnit,
            style: AppTypography.caption(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildFormulaCard(
    BuildContext context, {
    required String title,
    required String formula,
    required String accuracy,
  }) {
    final colors = AppColors.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.accent.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTypography.label(color: colors.accent),
          ),
          const SizedBox(height: 4),
          Text(
            formula,
            style: AppTypography.caption(color: colors.textPrimary),
          ),
          const SizedBox(height: 4),
          Text(
            accuracy,
            style: AppTypography.caption(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildWaistMeasurementGuide(
      BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMeasurementDiagram(
            context,
            type: 'waist',
            l10n: l10n,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.instructions}:',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInstructionStep(
            context,
            step: '1',
            text: l10n.waistStep1,
          ),
          _buildInstructionStep(
            context,
            step: '2',
            text: l10n.waistStep2,
          ),
          _buildInstructionStep(
            context,
            step: '3',
            text: l10n.waistStep3,
          ),
          _buildInstructionStep(
            context,
            step: '4',
            text: l10n.waistStep4,
          ),
          _buildInstructionStep(
            context,
            step: '5',
            text: l10n.waistStep5,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTip(
            context,
            l10n.waistTip,
          ),
        ],
      ),
    );
  }

  Widget _buildThighMeasurementGuide(
      BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMeasurementDiagram(
            context,
            type: 'thigh',
            l10n: l10n,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.instructions}:',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInstructionStep(
            context,
            step: '1',
            text: l10n.thighStep1,
          ),
          _buildInstructionStep(
            context,
            step: '2',
            text: l10n.thighStep2,
          ),
          _buildInstructionStep(
            context,
            step: '3',
            text: l10n.thighStep3,
          ),
          _buildInstructionStep(
            context,
            step: '4',
            text: l10n.thighStep4,
          ),
          _buildInstructionStep(
            context,
            step: '5',
            text: l10n.thighStep5,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTip(
            context,
            l10n.thighTip,
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementDiagram(
    BuildContext context, {
    required String type,
    required AppLocalizations l10n,
  }) {
    final colors = AppColors.of(context);
    final isWaist = type == 'waist';

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: colors.border),
      ),
      child: CustomPaint(
        painter: _MeasurementDiagramPainter(
          isWaist: isWaist,
          primaryColor: colors.accent,
          secondaryColor: colors.textSecondary,
          backgroundColor: colors.background,
          waistLabel: l10n.waist,
          proximalThighLabel: l10n.proximalThigh,
          lowerRibLabel: l10n.lowerRib,
          hipBoneLabel: l10n.hipBone,
          midpointLabel: l10n.midpoint,
          glutealCreaseLabel: l10n.glutealCrease,
          justBelowCreaseLabel: l10n.justBelowCrease,
        ),
      ),
    );
  }

  Widget _buildInstructionStep(
    BuildContext context, {
    required String step,
    required String text,
  }) {
    final colors = AppColors.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: colors.accent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: AppTypography.label(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 2),
              child: Text(
                text,
                style: AppTypography.body(color: colors.textPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTip(BuildContext context, String text) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: colors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.lightbulb_outline,
            size: 20,
            color: colors.success,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTypography.caption(color: colors.success),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalExplanation(BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.settingGoalDescription,
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${l10n.instructions}:',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInstructionStep(
            context,
            step: '1',
            text: l10n.settingGoalStep1,
          ),
          _buildInstructionStep(
            context,
            step: '2',
            text: l10n.settingGoalStep2,
          ),
          _buildInstructionStep(
            context,
            step: '3',
            text: l10n.settingGoalStep3,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.goalChartDescription,
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTip(
            context,
            l10n.goalHealthTip,
          ),
        ],
      ),
    );
  }

  Widget _buildTrendExplanation(BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.trendIndicatorDescription,
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildTrendItem(
            context,
            icon: Icons.arrow_downward,
            color: colors.success,
            label: l10n.trendDecreasing,
            description: l10n.trendDecreasingDesc,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTrendItem(
            context,
            icon: Icons.arrow_upward,
            color: colors.danger,
            label: l10n.trendIncreasing,
            description: l10n.trendIncreasingDesc,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTrendItem(
            context,
            icon: Icons.remove,
            color: colors.textSecondary,
            label: l10n.trendStable,
            description: l10n.trendStableDesc,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.trendMagnitudeNote,
            style: AppTypography.caption(color: colors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
    required String description,
  }) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: color,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: AppTypography.label(color: color),
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTypography.caption(color: colors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResultsExplanation(BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.resultsIntro,
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildRiskLevel(
            context,
            color: colors.success,
            label: l10n.riskHealthy,
            range: l10n.riskHealthyRange,
            description: l10n.riskHealthyDesc,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRiskLevel(
            context,
            color: colors.warning,
            label: l10n.riskElevated,
            range: l10n.riskElevatedRange,
            description: l10n.riskElevatedDesc,
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRiskLevel(
            context,
            color: colors.danger,
            label: l10n.riskHighRisk,
            range: l10n.riskHighRiskRange,
            description: l10n.riskHighRiskDesc,
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildHealthInsightsLink(context, colors, l10n),
        ],
      ),
    );
  }

  Widget _buildHealthInsightsLink(
      BuildContext context, AppColorScheme colors, AppLocalizations l10n) {
    return GestureDetector(
      onTap: () => context.push('/insights?educational=true'),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: colors.accent.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: colors.accent.withValues(alpha: 0.3)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              size: 20,
              color: colors.accent,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.learnMoreHealthRisks,
                    style: AppTypography.label(color: colors.accent),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    l10n.learnMoreHealthRisksDesc,
                    style: AppTypography.caption(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: colors.accent,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRiskLevel(
    BuildContext context, {
    required Color color,
    required String label,
    required String range,
    required String description,
  }) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 12,
            height: 12,
            margin: const EdgeInsets.only(top: 4),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      label,
                      style: AppTypography.label(color: color),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      range,
                      style: AppTypography.caption(color: colors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  description,
                  style: AppTypography.caption(color: colors.textPrimary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReference(BuildContext context, AppLocalizations l10n) {
    final colors = AppColors.of(context);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.referenceIntro,
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.sm),
            decoration: BoxDecoration(
              color: colors.background,
              borderRadius: BorderRadius.circular(AppRadius.sm),
              border: Border.all(color: colors.border),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.referenceAuthors,
                  style: AppTypography.caption(color: colors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.referenceTitle,
                  style: AppTypography.caption(color: colors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.referenceJournal,
                  style: AppTypography.caption(color: colors.textSecondary),
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: () async {
                    final url = Uri.parse(
                        'https://pmc.ncbi.nlm.nih.gov/articles/PMC3618381/');
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    }
                  },
                  child: Row(
                    children: [
                      Icon(
                        Icons.link,
                        size: 14,
                        color: colors.accent,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'PMC3618381',
                        style: AppTypography.caption(color: colors.accent),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MeasurementDiagramPainter extends CustomPainter {
  final bool isWaist;
  final Color primaryColor;
  final Color secondaryColor;
  final Color backgroundColor;
  final String waistLabel;
  final String proximalThighLabel;
  final String lowerRibLabel;
  final String hipBoneLabel;
  final String midpointLabel;
  final String glutealCreaseLabel;
  final String justBelowCreaseLabel;

  _MeasurementDiagramPainter({
    required this.isWaist,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
    required this.waistLabel,
    required this.proximalThighLabel,
    required this.lowerRibLabel,
    required this.hipBoneLabel,
    required this.midpointLabel,
    required this.glutealCreaseLabel,
    required this.justBelowCreaseLabel,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    final fillPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = secondaryColor.withValues(alpha: 0.1);

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    if (isWaist) {
      _drawWaistDiagram(canvas, size, centerX, centerY, paint, fillPaint);
    } else {
      _drawThighDiagram(canvas, size, centerX, centerY, paint, fillPaint);
    }
  }

  void _drawWaistDiagram(
    Canvas canvas,
    Size size,
    double centerX,
    double centerY,
    Paint paint,
    Paint fillPaint,
  ) {
    // Draw simplified torso outline
    final torsoPath = Path();

    // Shoulders
    torsoPath.moveTo(centerX - 50, centerY - 70);
    torsoPath.lineTo(centerX - 40, centerY - 60);

    // Left side
    torsoPath.quadraticBezierTo(
      centerX - 35,
      centerY - 30,
      centerX - 30,
      centerY, // Waist
    );
    torsoPath.quadraticBezierTo(
      centerX - 35,
      centerY + 30,
      centerX - 45,
      centerY + 70, // Hip
    );

    // Bottom
    torsoPath.lineTo(centerX + 45, centerY + 70);

    // Right side
    torsoPath.quadraticBezierTo(
      centerX + 35,
      centerY + 30,
      centerX + 30,
      centerY, // Waist
    );
    torsoPath.quadraticBezierTo(
      centerX + 35,
      centerY - 30,
      centerX + 40,
      centerY - 60,
    );

    // Right shoulder
    torsoPath.lineTo(centerX + 50, centerY - 70);

    canvas.drawPath(torsoPath, fillPaint);
    paint.color = secondaryColor;
    canvas.drawPath(torsoPath, paint);

    // Draw waist measurement line
    paint.color = primaryColor;
    paint.strokeWidth = 3;

    // Dashed line effect for tape measure
    final measureY = centerY;
    final startX = centerX - 45;
    final endX = centerX + 45;

    // Draw measurement tape
    final tapePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawLine(Offset(startX, measureY), Offset(endX, measureY), tapePaint);

    // Draw arrows on both ends
    _drawArrow(canvas, Offset(startX, measureY), true, primaryColor);
    _drawArrow(canvas, Offset(endX, measureY), false, primaryColor);

    // Draw labels
    _drawLabel(
      canvas,
      waistLabel,
      Offset(centerX, measureY - 20),
      primaryColor,
    );

    // Draw reference markers
    paint.strokeWidth = 1;
    paint.color = secondaryColor.withValues(alpha: 0.5);

    // Rib marker
    canvas.drawLine(
      Offset(centerX - 60, centerY - 35),
      Offset(centerX + 60, centerY - 35),
      paint..strokeWidth = 1,
    );
    _drawLabel(
      canvas,
      lowerRibLabel,
      Offset(centerX + 70, centerY - 35),
      secondaryColor,
      fontSize: 10,
      align: TextAlign.left,
    );

    // Hip marker
    canvas.drawLine(
      Offset(centerX - 60, centerY + 35),
      Offset(centerX + 60, centerY + 35),
      paint,
    );
    _drawLabel(
      canvas,
      hipBoneLabel,
      Offset(centerX + 70, centerY + 35),
      secondaryColor,
      fontSize: 10,
      align: TextAlign.left,
    );

    // Midpoint indicator
    _drawLabel(
      canvas,
      midpointLabel,
      Offset(centerX - 70, measureY),
      primaryColor,
      fontSize: 10,
      align: TextAlign.right,
    );
  }

  void _drawThighDiagram(
    Canvas canvas,
    Size size,
    double centerX,
    double centerY,
    Paint paint,
    Paint fillPaint,
  ) {
    // Draw simplified leg outline (upper portion)
    final legPath = Path();

    // Left leg outline
    legPath.moveTo(centerX - 40, centerY - 70); // Hip
    legPath.quadraticBezierTo(
      centerX - 35,
      centerY - 40,
      centerX - 30,
      centerY - 20, // Upper thigh
    );
    legPath.quadraticBezierTo(
      centerX - 28,
      centerY + 20,
      centerX - 25,
      centerY + 70, // Lower thigh
    );

    // Across bottom
    legPath.lineTo(centerX + 25, centerY + 70);

    // Right side
    legPath.quadraticBezierTo(
      centerX + 28,
      centerY + 20,
      centerX + 30,
      centerY - 20, // Upper thigh
    );
    legPath.quadraticBezierTo(
      centerX + 35,
      centerY - 40,
      centerX + 40,
      centerY - 70, // Hip
    );

    canvas.drawPath(legPath, fillPaint);
    paint.color = secondaryColor;
    paint.strokeWidth = 2;
    canvas.drawPath(legPath, paint);

    // Draw gluteal crease marker
    paint.color = secondaryColor.withValues(alpha: 0.5);
    paint.strokeWidth = 1;
    canvas.drawLine(
      Offset(centerX - 55, centerY - 45),
      Offset(centerX + 55, centerY - 45),
      paint,
    );
    _drawLabel(
      canvas,
      glutealCreaseLabel,
      Offset(centerX + 60, centerY - 45),
      secondaryColor,
      fontSize: 10,
      align: TextAlign.left,
    );

    // Draw thigh measurement line (just below gluteal crease)
    final measureY = centerY - 30;
    final startX = centerX - 45;
    final endX = centerX + 45;

    // Draw measurement tape
    final tapePaint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawLine(Offset(startX, measureY), Offset(endX, measureY), tapePaint);

    // Draw arrows on both ends
    _drawArrow(canvas, Offset(startX, measureY), true, primaryColor);
    _drawArrow(canvas, Offset(endX, measureY), false, primaryColor);

    // Draw labels
    _drawLabel(
      canvas,
      proximalThighLabel,
      Offset(centerX, measureY - 20),
      primaryColor,
    );

    _drawLabel(
      canvas,
      justBelowCreaseLabel,
      Offset(centerX - 60, measureY),
      primaryColor,
      fontSize: 10,
      align: TextAlign.right,
    );
  }

  void _drawArrow(Canvas canvas, Offset position, bool pointLeft, Color color) {
    final arrowPaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path();
    final direction = pointLeft ? -1 : 1;

    path.moveTo(position.dx, position.dy);
    path.lineTo(position.dx + (8 * direction), position.dy - 6);
    path.lineTo(position.dx + (8 * direction), position.dy + 6);
    path.close();

    canvas.drawPath(path, arrowPaint);
  }

  void _drawLabel(
    Canvas canvas,
    String text,
    Offset position,
    Color color, {
    double fontSize = 12,
    TextAlign align = TextAlign.center,
  }) {
    final textSpan = TextSpan(
      text: text,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: FontWeight.w500,
      ),
    );
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textAlign: align,
    );
    textPainter.layout();

    double offsetX;
    switch (align) {
      case TextAlign.left:
        offsetX = 0;
      case TextAlign.right:
        offsetX = -textPainter.width;
      default:
        offsetX = -textPainter.width / 2;
    }

    textPainter.paint(
      canvas,
      Offset(position.dx + offsetX, position.dy - textPainter.height / 2),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
