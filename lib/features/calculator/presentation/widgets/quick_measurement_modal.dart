import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_guide_modal.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_input_field.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';
import 'package:visco/l10n/generated/app_localizations.dart';

class QuickMeasurementModal extends ConsumerStatefulWidget {
  const QuickMeasurementModal({super.key});

  /// Shows the modal and returns true if a measurement was saved
  static Future<bool> show(BuildContext context) async {
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickMeasurementModal(),
    );
    return result ?? false;
  }

  @override
  ConsumerState<QuickMeasurementModal> createState() =>
      _QuickMeasurementModalState();
}

class _QuickMeasurementModalState extends ConsumerState<QuickMeasurementModal> {
  double? _weight;
  double? _waist;
  double? _thigh;
  bool _isLoading = false;

  bool get _canCalculate => _weight != null && _waist != null && _thigh != null;

  Future<void> _calculate() async {
    if (!_canCalculate) return;

    // Dismiss keyboard
    FocusScope.of(context).unfocus();

    final profile = ref.read(profileNotifierProvider);
    if (profile == null) return;

    setState(() => _isLoading = true);

    try {
      final measurement =
          await ref.read(measurementNotifierProvider.notifier).calculateAndSave(
                profile: profile,
                waistCm: _waist!,
                thighCm: _thigh!,
                weightKg: _weight!,
              );

      if (mounted) {
        // Close modal and return true to indicate success
        Navigator.of(context).pop(true);
        // Navigate to result screen
        context.push('/result', extra: measurement);
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
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
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    final unitSystem = ref.watch(unitSystemProvider);
    final profile = ref.watch(profileNotifierProvider);

    // If no profile, show message
    if (profile == null) {
      return Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.createProfileToStart,
                style: AppTypography.headline(color: colors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    context.push('/new-profile');
                  },
                  child: Text(l10n.createProfile),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.md,
          bottom: MediaQuery.of(context).viewInsets.bottom + AppSpacing.lg,
        ),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Handle bar
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: colors.border,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                // Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.newMeasurement,
                      style: AppTypography.headline(color: colors.textPrimary),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      icon: Icon(Icons.close, color: colors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                // Weight input
                MeasurementInputField(
                  label: l10n.weight,
                  unit: 'kg',
                  hint: l10n.enterWeight,
                  minValue: 30,
                  maxValue: 300,
                  measurementType: MeasurementType.weight,
                  unitSystem: unitSystem,
                  onChanged: (value) => setState(() => _weight = value),
                ),
                const SizedBox(height: AppSpacing.md),
                // Waist input
                MeasurementInputField(
                  label: l10n.waistCircumference,
                  unit: 'cm',
                  hint: l10n.enterWaist,
                  minValue: 50,
                  maxValue: 200,
                  measurementType: MeasurementType.length,
                  unitSystem: unitSystem,
                  showInfoButton: true,
                  onInfoPressed: () => _showMeasurementGuide('waist'),
                  onChanged: (value) => setState(() => _waist = value),
                ),
                const SizedBox(height: AppSpacing.md),
                // Thigh input
                MeasurementInputField(
                  label: l10n.thighCircumference,
                  unit: 'cm',
                  hint: l10n.enterThigh,
                  minValue: 30,
                  maxValue: 100,
                  measurementType: MeasurementType.length,
                  unitSystem: unitSystem,
                  showInfoButton: true,
                  onInfoPressed: () => _showMeasurementGuide('thigh'),
                  onChanged: (value) => setState(() => _thigh = value),
                ),
                const SizedBox(height: AppSpacing.xl),
                // Calculate button
                SizedBox(
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _canCalculate && !_isLoading ? _calculate : null,
                    child: _isLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(l10n.calculateAndSave),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
