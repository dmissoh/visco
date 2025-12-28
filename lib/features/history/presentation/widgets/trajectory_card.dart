import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/history/domain/services/trajectory_calculator.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/premium/presentation/screens/paywall_screen.dart';
import 'package:visco/features/premium/providers/premium_provider.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';

/// Provider for trajectory calculations
final trajectoryProvider = Provider<HealthTrajectory?>((ref) {
  final measurements = ref.watch(measurementsProvider);
  final profile = ref.watch(profileNotifierProvider);
  final goalValue = profile != null
      ? ref.watch(vatGoalFamilyProvider(profile.id))
      : null;

  return TrajectoryCalculator.calculate(
    measurements: measurements,
    goalValue: goalValue,
  );
});

class TrajectoryCard extends ConsumerWidget {
  const TrajectoryCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final trajectory = ref.watch(trajectoryProvider);
    final isPremium = ref.watch(isPremiumProvider);
    final measurements = ref.watch(measurementsProvider);

    // Need at least 2 measurements
    if (measurements.length < 2) {
      return const SizedBox.shrink();
    }

    // No trajectory calculated
    if (trajectory == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: colors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.trending_up,
                color: trajectory.isImproving ? colors.success : colors.warning,
                size: 20,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Health Trajectory',
                style: AppTypography.title(color: colors.textPrimary),
              ),
              const Spacer(),
              if (!isPremium)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: colors.accent,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'PRO',
                    style: AppTypography.label(color: Colors.white)
                        .copyWith(fontSize: 10),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Summary text
          _buildSummaryText(trajectory, colors),
          const SizedBox(height: AppSpacing.md),
          // Chart or locked preview
          if (isPremium)
            _buildTrajectoryChart(context, trajectory, colors)
          else
            _buildLockedPreview(context, trajectory, colors),
          // Goal ETA
          if (isPremium && trajectory.monthsToGoal != null) ...[
            const SizedBox(height: AppSpacing.md),
            _buildGoalEta(trajectory, colors),
          ],
        ],
      ),
    );
  }

  Widget _buildSummaryText(HealthTrajectory trajectory, AppColorScheme colors) {
    final changeText = trajectory.monthlyChange.abs().toStringAsFixed(1);
    final direction = trajectory.monthlyChange < 0 ? 'decreasing' : 'increasing';
    final trendColor = trajectory.isImproving ? colors.success : colors.warning;

    return RichText(
      text: TextSpan(
        style: AppTypography.body(color: colors.textSecondary),
        children: [
          const TextSpan(text: 'Your visceral fat is '),
          TextSpan(
            text: direction,
            style: TextStyle(
              color: trendColor,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(text: ' by ~$changeText cm\u00B2/month'),
        ],
      ),
    );
  }

  Widget _buildTrajectoryChart(
    BuildContext context,
    HealthTrajectory trajectory,
    AppColorScheme colors,
  ) {
    final spots = trajectory.projections
        .map((p) => FlSpot(p.month.toDouble(), p.projectedVat))
        .toList();

    // Calculate Y bounds
    final values = spots.map((s) => s.y).toList();
    final minY = (values.reduce((a, b) => a < b ? a : b) - 20).clamp(0.0, double.infinity);
    final maxY = values.reduce((a, b) => a > b ? a : b) + 20;

    return SizedBox(
      height: 150,
      child: LineChart(
        LineChartData(
          minX: 1,
          maxX: 12,
          minY: minY,
          maxY: maxY,
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 30,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: colors.border,
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 24,
                interval: 3,
                getTitlesWidget: (value, meta) {
                  return Text(
                    '+${value.toInt()}m',
                    style: TextStyle(
                      color: colors.textTertiary,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 30,
                getTitlesWidget: (value, meta) {
                  return Text(
                    value.toInt().toString(),
                    style: TextStyle(
                      color: colors.textTertiary,
                      fontSize: 10,
                    ),
                  );
                },
              ),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          borderData: FlBorderData(show: false),
          lineBarsData: [
            // Projection line
            LineChartBarData(
              spots: spots,
              isCurved: false,
              color: trajectory.isImproving
                  ? colors.success.withValues(alpha: 0.7)
                  : colors.warning.withValues(alpha: 0.7),
              barWidth: 2,
              dashArray: [5, 5],
              dotData: const FlDotData(show: false),
              belowBarData: BarAreaData(
                show: true,
                gradient: LinearGradient(
                  colors: trajectory.isImproving
                      ? [
                          colors.success.withValues(alpha: 0.2),
                          colors.success.withValues(alpha: 0.0),
                        ]
                      : [
                          colors.warning.withValues(alpha: 0.2),
                          colors.warning.withValues(alpha: 0.0),
                        ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
            // Healthy threshold
            if (100 >= minY && 100 <= maxY)
              LineChartBarData(
                spots: [
                  const FlSpot(1, 100),
                  const FlSpot(12, 100),
                ],
                isCurved: false,
                color: colors.success.withValues(alpha: 0.5),
                barWidth: 1,
                dashArray: [3, 3],
                dotData: const FlDotData(show: false),
              ),
          ],
          lineTouchData: LineTouchData(
            enabled: true,
            touchTooltipData: LineTouchTooltipData(
              getTooltipColor: (_) => colors.surface,
              tooltipBorder: BorderSide(color: colors.border),
              getTooltipItems: (touchedSpots) {
                return touchedSpots.map((spot) {
                  if (spot.barIndex != 0) return null;
                  return LineTooltipItem(
                    '${spot.y.toStringAsFixed(1)} cm\u00B2\n+${spot.x.toInt()} months',
                    TextStyle(
                      color: colors.textPrimary,
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                    ),
                  );
                }).toList();
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLockedPreview(
    BuildContext context,
    HealthTrajectory trajectory,
    AppColorScheme colors,
  ) {
    return GestureDetector(
      onTap: () => showPaywall(context, featureName: 'Health Trajectory'),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          color: colors.border.withValues(alpha: 0.3),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Stack(
          children: [
            // Blurred placeholder chart lines
            CustomPaint(
              size: const Size(double.infinity, 120),
              painter: _BlurredChartPainter(
                isImproving: trajectory.isImproving,
                lineColor: trajectory.isImproving ? colors.success : colors.warning,
              ),
            ),
            // Lock overlay
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.lock_outline,
                    color: colors.textSecondary,
                    size: 32,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Unlock to see your 12-month projection',
                    style: AppTypography.caption(color: colors.textSecondary),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGoalEta(HealthTrajectory trajectory, AppColorScheme colors) {
    final months = trajectory.monthsToGoal!;
    final years = months ~/ 12;
    final remainingMonths = months % 12;

    String etaText;
    if (years > 0 && remainingMonths > 0) {
      etaText = '$years year${years > 1 ? 's' : ''} $remainingMonths month${remainingMonths > 1 ? 's' : ''}';
    } else if (years > 0) {
      etaText = '$years year${years > 1 ? 's' : ''}';
    } else {
      etaText = '$months month${months > 1 ? 's' : ''}';
    }

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.success.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.success.withValues(alpha: 0.3)),
      ),
      child: Row(
        children: [
          Icon(
            Icons.flag_outlined,
            color: colors.success,
            size: 20,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'At this rate, you\'ll reach your goal in ~$etaText',
              style: AppTypography.caption(color: colors.success),
            ),
          ),
        ],
      ),
    );
  }
}

/// Painter for a simple blurred chart placeholder
class _BlurredChartPainter extends CustomPainter {
  final bool isImproving;
  final Color lineColor;

  _BlurredChartPainter({
    required this.isImproving,
    required this.lineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor.withValues(alpha: 0.3)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path();
    path.moveTo(20, isImproving ? size.height * 0.3 : size.height * 0.7);

    // Draw a simple curved line
    if (isImproving) {
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.5,
        size.width - 20,
        size.height * 0.7,
      );
    } else {
      path.quadraticBezierTo(
        size.width * 0.5,
        size.height * 0.5,
        size.width - 20,
        size.height * 0.3,
      );
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
