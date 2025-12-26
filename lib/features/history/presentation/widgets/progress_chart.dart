import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';

class ProgressChart extends StatelessWidget {
  final List<Measurement> measurements;

  const ProgressChart({
    super.key,
    required this.measurements,
  });

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    if (measurements.isEmpty) {
      return Center(
        child: Text(
          'No data to display',
          style: TextStyle(color: colors.textSecondary),
        ),
      );
    }

    // Sort by timestamp ascending for chart
    final sortedMeasurements = List<Measurement>.from(measurements)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Create spots from measurements
    final spots = sortedMeasurements.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value.vatCm2);
    }).toList();

    // Calculate min/max for Y axis
    final vatValues = sortedMeasurements.map((m) => m.vatCm2).toList();
    final minY = (vatValues.reduce((a, b) => a < b ? a : b) - 20).clamp(0.0, double.infinity);
    final maxY = vatValues.reduce((a, b) => a > b ? a : b) + 20;

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: (spots.length - 1).toDouble().clamp(0, double.infinity),
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
              reservedSize: 30,
              interval: _calculateInterval(spots.length),
              getTitlesWidget: (value, meta) {
                final index = value.toInt();
                if (index < 0 || index >= sortedMeasurements.length) {
                  return const SizedBox.shrink();
                }
                final date = sortedMeasurements[index].timestamp;
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat('MMM').format(date),
                    style: TextStyle(
                      color: colors.textSecondary,
                      fontSize: 10,
                    ),
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
                    color: colors.textSecondary,
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
          // VAT line
          LineChartBarData(
            spots: spots,
            isCurved: true,
            curveSmoothness: 0.3,
            color: colors.accent,
            barWidth: 3,
            isStrokeCapRound: true,
            dotData: FlDotData(
              show: true,
              getDotPainter: (spot, percent, barData, index) {
                return FlDotCirclePainter(
                  radius: 4,
                  color: colors.accent,
                  strokeWidth: 2,
                  strokeColor: colors.background,
                );
              },
            ),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  colors.accent.withValues(alpha: 0.3),
                  colors.accent.withValues(alpha: 0.0),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          // Healthy threshold line (100 cm2)
          LineChartBarData(
            spots: [
              const FlSpot(0, 100),
              FlSpot((spots.length - 1).toDouble().clamp(0, double.infinity), 100),
            ],
            isCurved: false,
            color: colors.success.withValues(alpha: 0.5),
            barWidth: 2,
            dashArray: [5, 5],
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
                if (spot.barIndex == 1) return null; // Skip threshold line
                final index = spot.x.toInt();
                if (index < 0 || index >= sortedMeasurements.length) {
                  return null;
                }
                final measurement = sortedMeasurements[index];
                return LineTooltipItem(
                  '${measurement.vatCm2.toStringAsFixed(1)} cm\u00B2\n${DateFormat('MMM d').format(measurement.timestamp)}',
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
    );
  }

  double _calculateInterval(int count) {
    if (count <= 5) return 1;
    if (count <= 10) return 2;
    if (count <= 20) return 4;
    return (count / 5).ceil().toDouble();
  }
}
