import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      backgroundColor: colors.background,
      appBar: AppBar(
        title: const Text('Help'),
        backgroundColor: colors.background,
        foregroundColor: colors.textPrimary,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildIntroduction(context),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: 'How to Measure Waist Circumference',
              child: _buildWaistMeasurementGuide(context),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: 'How to Measure Thigh Circumference',
              child: _buildThighMeasurementGuide(context),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: 'How is Visceral Fat Calculated?',
              child: _buildCalculationExplanation(context),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: 'Understanding Your Results',
              child: _buildResultsExplanation(context),
            ),
            const SizedBox(height: AppSpacing.xl),
            _buildSection(
              context,
              title: 'Scientific Reference',
              child: _buildReference(context),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildIntroduction(BuildContext context) {
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
            'About Visco',
            style: AppTypography.title(color: colors.accent),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Visco helps you estimate your visceral fat using simple body measurements. '
            'Visceral fat is the fat stored around your internal organs and is linked to '
            'increased health risks. By tracking your measurements over time, you can '
            'monitor your progress toward a healthier body composition.',
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

  Widget _buildCalculationExplanation(BuildContext context) {
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
            'Visco uses the Samouda Anthropometric Model to estimate visceral '
            'adipose tissue (VAT) area without requiring expensive imaging like '
            'CT scans or MRI.',
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'The model uses simple body measurements combined with your age and '
            'BMI to predict VAT with high accuracy:',
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildFormulaCard(
            context,
            title: 'For Men',
            formula: 'VAT = 6 x Waist - 4.41 x Thigh + 1.19 x Age - 213.65',
            accuracy: 'Explains 80.3% of VAT variance',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildFormulaCard(
            context,
            title: 'For Women',
            formula:
                'VAT = 2.15 x Waist - 3.63 x Thigh + 1.46 x Age + 6.22 x BMI - 92.713',
            accuracy: 'Explains 83.6% of VAT variance',
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'The result is expressed in cm\u00B2, representing the estimated '
            'cross-sectional area of visceral fat tissue.',
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

  Widget _buildWaistMeasurementGuide(BuildContext context) {
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
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Instructions:',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInstructionStep(
            context,
            step: '1',
            text:
                'Stand upright with your feet together and arms relaxed at your sides.',
          ),
          _buildInstructionStep(
            context,
            step: '2',
            text:
                'Locate the bottom of your ribs and the top of your hip bones (iliac crest).',
          ),
          _buildInstructionStep(
            context,
            step: '3',
            text:
                'Place the tape measure midway between these two points, roughly at your navel level.',
          ),
          _buildInstructionStep(
            context,
            step: '4',
            text:
                'Wrap the tape around your waist, keeping it parallel to the floor.',
          ),
          _buildInstructionStep(
            context,
            step: '5',
            text:
                'Breathe out normally and take the reading without pulling the tape too tight.',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTip(
            context,
            'Measure directly on skin or over light clothing for accuracy.',
          ),
        ],
      ),
    );
  }

  Widget _buildThighMeasurementGuide(BuildContext context) {
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
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            'Instructions:',
            style: AppTypography.title(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildInstructionStep(
            context,
            step: '1',
            text:
                'Stand upright with your weight evenly distributed on both legs.',
          ),
          _buildInstructionStep(
            context,
            step: '2',
            text:
                'Identify the gluteal crease (the fold where your buttock meets your thigh).',
          ),
          _buildInstructionStep(
            context,
            step: '3',
            text:
                'Position the tape measure just below (distal to) the gluteal crease.',
          ),
          _buildInstructionStep(
            context,
            step: '4',
            text:
                'Wrap the tape horizontally around your thigh, keeping it perpendicular to the thigh axis.',
          ),
          _buildInstructionStep(
            context,
            step: '5',
            text:
                'Keep your muscles relaxed and read the measurement without compressing the skin.',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildTip(
            context,
            'Measure both thighs and use the average if they differ significantly.',
          ),
        ],
      ),
    );
  }

  Widget _buildMeasurementDiagram(
    BuildContext context, {
    required String type,
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

  Widget _buildResultsExplanation(BuildContext context) {
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
            'Your VAT result is categorized into three risk levels:',
            style: AppTypography.body(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.md),
          _buildRiskLevel(
            context,
            color: colors.success,
            label: 'Healthy',
            range: 'Less than 100 cm\u00B2',
            description:
                'Normal visceral fat levels associated with lower health risks.',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRiskLevel(
            context,
            color: colors.warning,
            label: 'Elevated',
            range: '100 - 130 cm\u00B2',
            description:
                'Moderately elevated levels. Consider lifestyle changes.',
          ),
          const SizedBox(height: AppSpacing.sm),
          _buildRiskLevel(
            context,
            color: colors.danger,
            label: 'High Risk',
            range: 'Greater than 130 cm\u00B2',
            description:
                'High visceral fat associated with increased metabolic health risks.',
          ),
        ],
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

  Widget _buildReference(BuildContext context) {
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
            'The calculation method used in this app is based on peer-reviewed research:',
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
                  'Samouda, H., Dutour, A., Chaumoitre, K., Panuel, M., Dutour, O., & Dadoun, F.',
                  style: AppTypography.caption(color: colors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  'VAT=TAAT-SAAT: innovative anthropometric model to predict visceral adipose tissue without resort to CT-Scan or DXA.',
                  style: AppTypography.caption(color: colors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  'Obesity (2013), 21(1), E41-E50.',
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

  _MeasurementDiagramPainter({
    required this.isWaist,
    required this.primaryColor,
    required this.secondaryColor,
    required this.backgroundColor,
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
      'Waist',
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
      'Lower rib',
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
      'Hip bone',
      Offset(centerX + 70, centerY + 35),
      secondaryColor,
      fontSize: 10,
      align: TextAlign.left,
    );

    // Midpoint indicator
    _drawLabel(
      canvas,
      'Midpoint',
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
      'Gluteal crease',
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
      'Proximal Thigh',
      Offset(centerX, measureY - 20),
      primaryColor,
    );

    _drawLabel(
      canvas,
      'Just below crease',
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
