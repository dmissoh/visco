import 'package:flutter/material.dart';
import 'package:visco/features/insights/domain/models/health_risk.dart';
import 'package:visco/features/insights/domain/models/health_tip.dart';

/// Static data for health risks and tips based on scientific evidence.
/// Sources: Samouda et al., PubMed, Harvard Health, Cleveland Clinic, PMC.
class InsightsData {
  InsightsData._();

  /// All health risks associated with elevated visceral fat.
  static const List<HealthRisk> risks = [
    HealthRisk(
      id: 'risk-cardiometabolic',
      category: HealthRiskCategory.cardiometabolic,
      title: 'Cardiometabolic Disease',
      description:
          'Elevated visceral fat significantly increases the risk of developing serious cardiovascular and metabolic conditions.',
      details: [
        'Increased risk of type 2 diabetes through insulin resistance',
        'Higher likelihood of hypertension (high blood pressure)',
        'Unfavorable cholesterol profile (dyslipidemia)',
        'Greater risk of coronary heart disease and heart failure',
      ],
      severity: RiskSeverity.veryHigh,
      sources: ['PubMed: 40622164', 'PMC3473928'],
    ),
    HealthRisk(
      id: 'risk-stroke-mortality',
      category: HealthRiskCategory.strokeMortality,
      title: 'Stroke and Mortality',
      description:
          'Higher visceral fat levels are associated with increased stroke risk and may contribute to higher all-cause mortality.',
      details: [
        'Elevated risk of ischemic stroke',
        'Association with higher all-cause mortality rates',
        'Risk persists even at normal BMI levels',
      ],
      severity: RiskSeverity.veryHigh,
      sources: ['PubMed: 40622164'],
    ),
    HealthRisk(
      id: 'risk-inflammation',
      category: HealthRiskCategory.inflammation,
      title: 'Chronic Inflammation',
      description:
          'Visceral fat tissue actively secretes inflammatory molecules that promote systemic inflammation throughout the body.',
      details: [
        'Secretes inflammatory cytokines (IL-6, TNF-alpha)',
        'Disrupts normal hormone signaling',
        'Creates low-level chronic inflammation',
        'Inflammation is a risk factor for many chronic diseases',
      ],
      severity: RiskSeverity.high,
      sources: ['Harvard Health', 'PMC3473928'],
    ),
    HealthRisk(
      id: 'risk-liver',
      category: HealthRiskCategory.liverDisease,
      title: 'Non-Alcoholic Fatty Liver Disease',
      description:
          'Visceral fat accumulation is strongly correlated with fat infiltration in the liver and elevated liver enzymes.',
      details: [
        'Fat deposits in liver tissue (hepatic steatosis)',
        'Elevated liver enzyme levels (ALT, AST)',
        'Can progress to more serious liver conditions',
        'Often reversible with lifestyle changes',
      ],
      severity: RiskSeverity.high,
      sources: ['Nature: s41598-017-09723-y'],
    ),
    HealthRisk(
      id: 'risk-metabolic-syndrome',
      category: HealthRiskCategory.metabolicSyndrome,
      title: 'Metabolic Syndrome',
      description:
          'Visceral adiposity is a core driver of metabolic syndrome, a cluster of conditions that increase disease risk.',
      details: [
        'Elevated blood sugar levels',
        'High blood pressure',
        'Abnormal cholesterol levels',
        'Central obesity (excess waist fat)',
        'Significantly increases heart disease and diabetes risk',
      ],
      severity: RiskSeverity.veryHigh,
      sources: ['PMC4268163'],
    ),
    HealthRisk(
      id: 'risk-cancer',
      category: HealthRiskCategory.cancer,
      title: 'Cancer Associations',
      description:
          'Emerging evidence links visceral fat with metabolic dysregulation and higher risk for certain cancers.',
      details: [
        'Altered hormone signaling may promote cancer growth',
        'Chronic inflammation creates favorable environment for cancer',
        'Associated with certain malignancies',
        'Research ongoing to understand mechanisms',
      ],
      severity: RiskSeverity.moderate,
      sources: ['ScienceDirect: Visceral Fat'],
    ),
  ];

  /// Evidence-based tips for reducing visceral fat.
  static const List<HealthTip> tips = [
    HealthTip(
      id: 'tip-activity',
      category: TipCategory.activity,
      title: 'Regular Physical Activity',
      description:
          'Consistent aerobic exercise and strength training are among the most effective ways to reduce visceral fat.',
      actionItems: [
        'Aim for 150+ minutes per week of moderate-intensity aerobic activity',
        'Include 2 or more days per week of strength training',
        'Walking, cycling, swimming, and jogging are excellent choices',
        'Strength training helps maintain lean muscle mass',
      ],
      evidenceSource: 'PubMed Clinical Reviews',
      icon: Icons.directions_run,
    ),
    HealthTip(
      id: 'tip-diet',
      category: TipCategory.diet,
      title: 'Balanced, Nutrient-Dense Diet',
      description:
          'Focus on whole foods and limit processed foods to help reduce visceral fat accumulation.',
      actionItems: [
        'Emphasize vegetables, fruits, and whole grains',
        'Choose lean proteins (fish, poultry, legumes)',
        'Limit added sugars and refined carbohydrates',
        'Reduce intake of highly processed foods',
        'Choose healthy fats (olive oil, nuts, avocado)',
      ],
      evidenceSource: 'Cleveland Clinic, Samouda et al.',
      icon: Icons.restaurant,
    ),
    HealthTip(
      id: 'tip-weight',
      category: TipCategory.weightManagement,
      title: 'Weight Management',
      description:
          'Maintaining a healthy weight through sustainable calorie control helps reduce visceral fat stores.',
      actionItems: [
        'Create a modest calorie deficit for gradual weight loss',
        'Track waist circumference as a progress indicator',
        'Monitor waist-to-height ratio (aim for < 0.5)',
        'Focus on sustainable changes, not crash diets',
      ],
      evidenceSource: 'Luxembourg Institute of Health',
      icon: Icons.monitor_weight_outlined,
    ),
    HealthTip(
      id: 'tip-sedentary',
      category: TipCategory.lifestyle,
      title: 'Reduce Sedentary Time',
      description:
          'Breaking up prolonged sitting with light movement contributes to overall energy expenditure.',
      actionItems: [
        'Stand up and move every 30-60 minutes',
        'Take walking breaks during work',
        'Use a standing desk when possible',
        'Choose stairs over elevators',
        'Even light activity helps reduce visceral fat',
      ],
      evidenceSource: 'PubMed: 40622164',
      icon: Icons.accessibility_new,
    ),
    HealthTip(
      id: 'tip-sleep-stress',
      category: TipCategory.sleepStress,
      title: 'Quality Sleep and Stress Management',
      description:
          'Poor sleep and chronic stress raise cortisol, a hormone linked to abdominal fat accumulation.',
      actionItems: [
        'Aim for 7-9 hours of quality sleep per night',
        'Maintain a consistent sleep schedule',
        'Practice stress-reducing activities (meditation, yoga)',
        'Limit screen time before bed',
        'Address sources of chronic stress',
      ],
      evidenceSource: 'Clinical Guidelines',
      icon: Icons.nightlight_round,
    ),
    HealthTip(
      id: 'tip-alcohol',
      category: TipCategory.alcohol,
      title: 'Limit Alcohol Consumption',
      description:
          'Alcohol adds calories and may promote visceral fat accumulation when consumed regularly in excess.',
      actionItems: [
        'Limit to moderate consumption (1 drink/day women, 2/day men)',
        'Choose lower-calorie options when drinking',
        'Avoid binge drinking episodes',
        'Consider alcohol-free days each week',
      ],
      evidenceSource: 'Buckhead Primary Care',
      icon: Icons.no_drinks,
    ),
    HealthTip(
      id: 'tip-smoking',
      category: TipCategory.smoking,
      title: 'Smoking Cessation',
      description:
          'Smoking is associated with central fat accumulation and amplifies cardiometabolic risk.',
      actionItems: [
        'Quit smoking to reduce visceral fat accumulation',
        'Seek support programs or medications if needed',
        'Benefits begin within days of quitting',
        'Reduces overall cardiovascular risk significantly',
      ],
      evidenceSource: 'Clinical Guidelines',
      icon: Icons.smoke_free,
    ),
  ];

  /// Returns risks filtered by severity.
  static List<HealthRisk> getRisksBySeverity(RiskSeverity severity) {
    return risks.where((r) => r.severity == severity).toList();
  }

  /// Returns tips filtered by category.
  static List<HealthTip> getTipsByCategory(TipCategory category) {
    return tips.where((t) => t.category == category).toList();
  }

  /// Returns the top priority tips (activity and diet are most impactful).
  static List<HealthTip> get priorityTips {
    return tips
        .where((t) =>
            t.category == TipCategory.activity ||
            t.category == TipCategory.diet ||
            t.category == TipCategory.sleepStress)
        .toList();
  }
}
