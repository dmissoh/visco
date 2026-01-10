import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/insights/domain/data/insights_data.dart';
import 'package:visco/features/insights/domain/models/health_risk.dart';
import 'package:visco/features/insights/domain/models/health_tip.dart';

/// Personalized insights based on user's current VAT measurement.
class PersonalizedInsights {
  final RiskCategory riskCategory;
  final double vatValue;
  final List<HealthRisk> risks;
  final List<HealthTip> priorityTips;
  final List<HealthTip> allTips;
  final bool isImproving;
  final bool hasMeasurement;

  const PersonalizedInsights({
    required this.riskCategory,
    required this.vatValue,
    required this.risks,
    required this.priorityTips,
    required this.allTips,
    required this.isImproving,
    this.hasMeasurement = true,
  });

  /// Creates default insights when no measurement is available.
  factory PersonalizedInsights.empty() {
    return PersonalizedInsights(
      riskCategory: RiskCategory.healthy,
      vatValue: 0,
      risks: InsightsData.risks,
      priorityTips: InsightsData.priorityTips,
      allTips: InsightsData.tips,
      isImproving: false,
      hasMeasurement: false,
    );
  }
}

/// Provider for personalized health insights based on latest measurement.
final insightsProvider = Provider<PersonalizedInsights>((ref) {
  final latestMeasurement = ref.watch(latestMeasurementProvider);
  final trend = ref.watch(vatTrendProvider);

  if (latestMeasurement == null) {
    return PersonalizedInsights.empty();
  }

  return _generateInsights(
    measurement: latestMeasurement,
    isImproving: trend.direction == TrendDirection.down,
  );
});

/// Provider for insights based on a specific measurement.
final measurementInsightsProvider =
    Provider.family<PersonalizedInsights, Measurement>((ref, measurement) {
  final trend = ref.watch(vatTrendProvider);

  return _generateInsights(
    measurement: measurement,
    isImproving: trend.direction == TrendDirection.down,
  );
});

PersonalizedInsights _generateInsights({
  required Measurement measurement,
  required bool isImproving,
}) {
  final riskCategory = measurement.riskCategory;
  final vatValue = measurement.vatCm2;

  // Sort risks by severity (most severe first)
  final sortedRisks = List<HealthRisk>.from(InsightsData.risks)
    ..sort((a, b) => b.severity.index.compareTo(a.severity.index));

  // Filter and prioritize tips based on risk category
  final priorityTips = _getPriorityTips(riskCategory);
  final allTips = InsightsData.tips;

  return PersonalizedInsights(
    riskCategory: riskCategory,
    vatValue: vatValue,
    risks: sortedRisks,
    priorityTips: priorityTips,
    allTips: allTips,
    isImproving: isImproving,
  );
}

List<HealthTip> _getPriorityTips(RiskCategory category) {
  switch (category) {
    case RiskCategory.healthy:
      // For healthy users, focus on maintenance tips
      return InsightsData.tips
          .where((t) =>
              t.category == TipCategory.activity ||
              t.category == TipCategory.diet)
          .toList();
    case RiskCategory.elevated:
      // For elevated users, focus on activity, diet, and lifestyle
      return InsightsData.tips
          .where((t) =>
              t.category == TipCategory.activity ||
              t.category == TipCategory.diet ||
              t.category == TipCategory.lifestyle ||
              t.category == TipCategory.sleepStress)
          .toList();
    case RiskCategory.obesity:
      // For high-risk users, show all tips as priorities
      return InsightsData.tips;
  }
}
