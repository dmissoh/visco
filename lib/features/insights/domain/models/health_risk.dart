/// Categories of health risks associated with visceral fat.
enum HealthRiskCategory {
  cardiometabolic,
  strokeMortality,
  inflammation,
  liverDisease,
  metabolicSyndrome,
  cancer,
}

/// Severity level of a health risk.
enum RiskSeverity {
  moderate,
  high,
  veryHigh,
}

/// Represents a health risk associated with elevated visceral fat.
class HealthRisk {
  final String id;
  final HealthRiskCategory category;
  final String title;
  final String description;
  final List<String> details;
  final RiskSeverity severity;
  final List<String> sources;

  const HealthRisk({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.details,
    required this.severity,
    required this.sources,
  });

  /// Returns a user-friendly category label.
  String get categoryLabel {
    switch (category) {
      case HealthRiskCategory.cardiometabolic:
        return 'Cardiometabolic';
      case HealthRiskCategory.strokeMortality:
        return 'Stroke & Mortality';
      case HealthRiskCategory.inflammation:
        return 'Inflammation';
      case HealthRiskCategory.liverDisease:
        return 'Liver Health';
      case HealthRiskCategory.metabolicSyndrome:
        return 'Metabolic Syndrome';
      case HealthRiskCategory.cancer:
        return 'Cancer Risk';
    }
  }
}
