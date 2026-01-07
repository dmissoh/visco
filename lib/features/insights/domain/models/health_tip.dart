import 'package:flutter/material.dart';

/// Categories of health tips for reducing visceral fat.
enum TipCategory {
  activity,
  diet,
  weightManagement,
  lifestyle,
  sleepStress,
  alcohol,
  smoking,
}

/// Represents an evidence-based tip for reducing visceral fat.
class HealthTip {
  final String id;
  final TipCategory category;
  final String title;
  final String description;
  final List<String> actionItems;
  final String evidenceSource;
  final IconData icon;

  const HealthTip({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.actionItems,
    required this.evidenceSource,
    required this.icon,
  });

  /// Returns a user-friendly category label.
  String get categoryLabel {
    switch (category) {
      case TipCategory.activity:
        return 'Physical Activity';
      case TipCategory.diet:
        return 'Diet';
      case TipCategory.weightManagement:
        return 'Weight Management';
      case TipCategory.lifestyle:
        return 'Lifestyle';
      case TipCategory.sleepStress:
        return 'Sleep & Stress';
      case TipCategory.alcohol:
        return 'Alcohol';
      case TipCategory.smoking:
        return 'Smoking';
    }
  }
}
