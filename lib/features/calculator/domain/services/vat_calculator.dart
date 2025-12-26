import 'dart:math';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

class VatCalculationResult {
  final double vatCm2;
  final double bmi;

  const VatCalculationResult({
    required this.vatCm2,
    required this.bmi,
  });
}

abstract class VatCalculator {
  /// Calculate visceral adipose tissue (VAT) using the Samouda anthropometric model.
  ///
  /// References:
  /// Samouda, H., et al. (2013). VAT=TAAT-SAAT: innovative anthropometric model
  /// to predict visceral adipose tissue without resort to CT-Scan or DXA.
  /// Obesity, 21(1), E41-E50. [PMC3618381]
  static VatCalculationResult calculate({
    required Sex sex,
    required double waistCm,
    required double thighCm,
    required int age,
    required double weightKg,
    required double heightCm,
  }) {
    final bmi = calculateBmi(weightKg: weightKg, heightCm: heightCm);
    double vat;

    if (sex == Sex.male) {
      // Male formula: VAT = (6 * waist) - (4.41 * thigh) + (1.19 * age) - 213.65
      // R² = 0.803, Sensitivity: 100%
      vat = (6 * waistCm) - (4.41 * thighCm) + (1.19 * age) - 213.65;
    } else {
      // Female formula: VAT = (2.15 * waist) - (3.63 * thigh) + (1.46 * age) + (6.22 * bmi) - 92.713
      // R² = 0.836, Sensitivity: 97.7%
      vat = (2.15 * waistCm) - (3.63 * thighCm) + (1.46 * age) + (6.22 * bmi) - 92.713;
    }

    // VAT cannot be negative
    vat = max(0, vat);

    return VatCalculationResult(
      vatCm2: vat,
      bmi: bmi,
    );
  }

  /// Calculate Body Mass Index (BMI)
  static double calculateBmi({
    required double weightKg,
    required double heightCm,
  }) {
    final heightM = heightCm / 100;
    return weightKg / (heightM * heightM);
  }

  /// Validate waist circumference (recommended range: 50-200 cm)
  static bool isValidWaist(double waistCm) {
    return waistCm >= 50 && waistCm <= 200;
  }

  /// Validate thigh circumference (recommended range: 30-100 cm)
  static bool isValidThigh(double thighCm) {
    return thighCm >= 30 && thighCm <= 100;
  }

  /// Validate age (validated range: 18-80 years)
  static bool isValidAge(int age) {
    return age >= 18 && age <= 80;
  }

  /// Check if all inputs are within validated ranges
  static bool areInputsValid({
    required double waistCm,
    required double thighCm,
    required int age,
  }) {
    return isValidWaist(waistCm) && isValidThigh(thighCm) && isValidAge(age);
  }
}
