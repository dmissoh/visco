import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/calculator/domain/services/vat_calculator.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_guide_modal.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_input_field.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/result/presentation/widgets/risk_scale_indicator.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

/// A "What-If" calculator that lets users simulate VAT without saving
/// Great for goal planning - "What if I lose 5kg?" or "What waist do I need for healthy VAT?"
class WhatIfCalculatorScreen extends ConsumerStatefulWidget {
  const WhatIfCalculatorScreen({super.key});

  @override
  ConsumerState<WhatIfCalculatorScreen> createState() =>
      _WhatIfCalculatorScreenState();
}

class _WhatIfCalculatorScreenState extends ConsumerState<WhatIfCalculatorScreen> {
  double? _weight;
  double? _waist;
  double? _thigh;

  // Simulation result
  VatCalculationResult? _result;

  bool get _canCalculate => _weight != null && _waist != null && _thigh != null;

  void _calculate() {
    if (!_canCalculate) return;

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    final profile = ref.read(profileNotifierProvider);
    if (profile == null) return;

    final result = VatCalculator.calculate(
      sex: profile.sex,
      waistCm: _waist!,
      thighCm: _thigh!,
      age: profile.age,
      weightKg: _weight!,
      heightCm: profile.heightCm,
    );

    setState(() => _result = result);
  }

  void _showMeasurementGuide(String type) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => MeasurementGuideModal(measurementType: type),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final l10n = AppLocalizations.of(context)!;
    final profile = ref.watch(profileNotifierProvider);
    final unitSystem = ref.watch(unitSystemProvider);
    final goalValue = profile != null
        ? ref.watch(vatGoalFamilyProvider(profile.id))
        : null;

    // Show create profile prompt if no profile exists
    if (profile == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.whatIfCalculator),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.science_outlined,
                  size: 80,
                  color: colors.textTertiary,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.createProfileFirst,
                  style: AppTypography.headline(color: colors.textPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.whatIfNeedsProfile,
                  style: AppTypography.body(color: colors.textSecondary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () => context.push('/new-profile'),
                    child: Text(l10n.createProfile),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.whatIfCalculator),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Info card
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colors.accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: colors.accent.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: colors.accent,
                      size: 24,
                    ),
                    const SizedBox(width: AppSpacing.md),
                    Expanded(
                      child: Text(
                        l10n.simulateInstructions,
                        style: AppTypography.caption(color: colors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              Text(
                l10n.enterMeasurements,
                style: AppTypography.title(color: colors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.md),

              MeasurementInputField(
                label: l10n.targetWeight,
                unit: 'kg',
                hint: l10n.enterTargetWeight,
                minValue: 30,
                maxValue: 300,
                measurementType: MeasurementType.weight,
                unitSystem: unitSystem,
                onChanged: (value) {
                  setState(() {
                    _weight = value;
                    _result = null; // Clear result on change
                  });
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              MeasurementInputField(
                label: l10n.targetWaist,
                unit: 'cm',
                hint: l10n.enterTargetWaist,
                minValue: 50,
                maxValue: 200,
                measurementType: MeasurementType.length,
                unitSystem: unitSystem,
                showInfoButton: true,
                onInfoPressed: () => _showMeasurementGuide('waist'),
                onChanged: (value) {
                  setState(() {
                    _waist = value;
                    _result = null;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.lg),

              MeasurementInputField(
                label: l10n.targetThigh,
                unit: 'cm',
                hint: l10n.enterTargetThigh,
                minValue: 30,
                maxValue: 100,
                measurementType: MeasurementType.length,
                unitSystem: unitSystem,
                showInfoButton: true,
                onInfoPressed: () => _showMeasurementGuide('thigh'),
                onChanged: (value) {
                  setState(() {
                    _thigh = value;
                    _result = null;
                  });
                },
              ),
              const SizedBox(height: AppSpacing.xl),

              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _canCalculate ? _calculate : null,
                  child: Text(l10n.simulate),
                ),
              ),

              // Results section
              if (_result != null) ...[
                const SizedBox(height: AppSpacing.xl),
                Divider(color: colors.border),
                const SizedBox(height: AppSpacing.lg),
                
                // Risk scale indicator
                RiskScaleIndicator(vatValue: _result!.vatCm2),
                const SizedBox(height: AppSpacing.lg),
                
                _buildResultCard(context, colors, goalValue),
              ],
            ],
          ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultCard(BuildContext context, AppColorScheme colors, double? goalValue) {
    final l10n = AppLocalizations.of(context)!;
    final riskCategory = Measurement.calculateRiskCategory(_result!.vatCm2);
    final riskColor = switch (riskCategory) {
      RiskCategory.healthy => colors.success,
      RiskCategory.elevated => colors.warning,
      RiskCategory.obesity => colors.danger,
    };
    final riskLabel = switch (riskCategory) {
      RiskCategory.healthy => l10n.riskScaleHealthy,
      RiskCategory.elevated => l10n.riskScaleElevated,
      RiskCategory.obesity => l10n.riskHigh,
    };

    // Calculate difference from goal if set
    final goalDiff = goalValue != null ? _result!.vatCm2 - goalValue : null;
    final isAtGoal = goalDiff != null && goalDiff <= 0;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: riskColor.withValues(alpha: 0.5), width: 2),
      ),
      child: Column(
        children: [
          Text(
            l10n.simulatedResult,
            style: AppTypography.caption(color: colors.textSecondary),
          ),
          const SizedBox(height: AppSpacing.md),

          // VAT Value
          Text(
            '${_result!.vatCm2.toStringAsFixed(1)} cm\u00B2',
            style: AppTypography.display(color: colors.textPrimary),
          ),
          const SizedBox(height: AppSpacing.sm),

          // Risk badge
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.xs,
            ),
            decoration: BoxDecoration(
              color: riskColor,
              borderRadius: BorderRadius.circular(AppRadius.full),
            ),
            child: Text(
              riskLabel,
              style: AppTypography.label(color: Colors.white),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // BMI
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'BMI: ',
                style: AppTypography.body(color: colors.textSecondary),
              ),
              Text(
                _result!.bmi.toStringAsFixed(1),
                style: AppTypography.body(color: colors.textPrimary)
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text(
                ' (${_getBmiCategory(context, _result!.bmi)})',
                style: AppTypography.caption(color: colors.textSecondary),
              ),
            ],
          ),

          // Goal comparison
          if (goalValue != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Divider(color: colors.border),
            const SizedBox(height: AppSpacing.md),

            if (isAtGoal)
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check_circle, color: colors.success, size: 20),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      l10n.wouldAchieveGoal,
                      style: AppTypography.body(color: colors.success),
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colors.warning.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  children: [
                    Text(
                      l10n.aboveGoal(goalDiff!.toStringAsFixed(1)),
                      style: AppTypography.body(color: colors.warning),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.yourGoalValue(goalValue.toStringAsFixed(0)),
                      style: AppTypography.caption(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
          ],

          // Tip
          const SizedBox(height: AppSpacing.lg),
          Text(
            l10n.whatIfTip,
            style: AppTypography.caption(color: colors.textTertiary),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  String _getBmiCategory(BuildContext context, double bmi) {
    final l10n = AppLocalizations.of(context)!;
    if (bmi < 18.5) return l10n.bmiUnderweight;
    if (bmi < 25) return l10n.bmiNormal;
    if (bmi < 30) return l10n.bmiOverweight;
    return l10n.bmiObese;
  }
}
