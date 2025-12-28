import 'package:visco/features/calculator/domain/models/measurement.dart';

/// Represents a projected health trajectory
class HealthTrajectory {
  /// Projected VAT values over time (months from now)
  final List<TrajectoryPoint> projections;

  /// Average monthly change in VAT
  final double monthlyChange;

  /// Estimated months to reach goal (null if not achievable or no goal)
  final int? monthsToGoal;

  /// Whether the trend is improving (decreasing VAT)
  final bool isImproving;

  const HealthTrajectory({
    required this.projections,
    required this.monthlyChange,
    this.monthsToGoal,
    required this.isImproving,
  });
}

/// A single point on the trajectory projection
class TrajectoryPoint {
  /// Months from current date
  final int month;

  /// Projected VAT value
  final double projectedVat;

  /// Whether this is in the healthy zone (<100 cm2)
  bool get isHealthy => projectedVat < 100;

  const TrajectoryPoint({
    required this.month,
    required this.projectedVat,
  });
}

/// Service for calculating health trajectory projections
class TrajectoryCalculator {
  /// Calculate trajectory projection based on measurement history
  ///
  /// Returns null if there aren't enough measurements to calculate a trend
  static HealthTrajectory? calculate({
    required List<Measurement> measurements,
    double? goalValue,
    int projectionMonths = 12,
  }) {
    // Need at least 2 measurements to calculate a trend
    if (measurements.length < 2) {
      return null;
    }

    // Sort by timestamp ascending
    final sorted = List<Measurement>.from(measurements)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    // Calculate the trend using linear regression
    final regression = _calculateLinearRegression(sorted);

    // Get current VAT (latest measurement)
    final currentVat = sorted.last.vatCm2;

    // Calculate monthly change rate
    // slope is in cm2 per day, convert to per month (30 days)
    final monthlyChange = regression.slope * 30;

    // Generate projections
    final projections = <TrajectoryPoint>[];
    for (var month = 1; month <= projectionMonths; month++) {
      // Project based on current VAT and monthly rate
      final projectedVat = currentVat + (monthlyChange * month);
      // Clamp to reasonable bounds (0 to 500)
      projections.add(TrajectoryPoint(
        month: month,
        projectedVat: projectedVat.clamp(0, 500),
      ));
    }

    // Calculate months to goal if improving and goal is set
    int? monthsToGoal;
    if (goalValue != null && monthlyChange < 0 && currentVat > goalValue) {
      final vatToLose = currentVat - goalValue;
      monthsToGoal = (vatToLose / monthlyChange.abs()).ceil();
      // Cap at 5 years
      if (monthsToGoal > 60) monthsToGoal = null;
    }

    return HealthTrajectory(
      projections: projections,
      monthlyChange: monthlyChange,
      monthsToGoal: monthsToGoal,
      isImproving: monthlyChange < -0.5, // Consider improving if losing > 0.5 cm2/month
    );
  }

  /// Calculate linear regression coefficients
  static _LinearRegression _calculateLinearRegression(List<Measurement> measurements) {
    final n = measurements.length;
    final firstDate = measurements.first.timestamp;

    // Convert to x (days since first measurement) and y (VAT)
    double sumX = 0;
    double sumY = 0;
    double sumXY = 0;
    double sumX2 = 0;

    for (final m in measurements) {
      final x = m.timestamp.difference(firstDate).inDays.toDouble();
      final y = m.vatCm2;

      sumX += x;
      sumY += y;
      sumXY += x * y;
      sumX2 += x * x;
    }

    // Calculate slope (m) and intercept (b) for y = mx + b
    final denominator = (n * sumX2) - (sumX * sumX);

    // Handle edge case of zero denominator (all measurements on same day)
    if (denominator.abs() < 0.0001) {
      return _LinearRegression(slope: 0, intercept: sumY / n);
    }

    final slope = ((n * sumXY) - (sumX * sumY)) / denominator;
    final intercept = (sumY - (slope * sumX)) / n;

    return _LinearRegression(slope: slope, intercept: intercept);
  }
}

class _LinearRegression {
  final double slope;
  final double intercept;

  const _LinearRegression({
    required this.slope,
    required this.intercept,
  });
}
