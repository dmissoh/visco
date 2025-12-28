import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_guide_modal.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_input_field.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  double? _weight;
  double? _waist;
  double? _thigh;
  bool _isLoading = false;

  bool get _canCalculate => _weight != null && _waist != null && _thigh != null;

  Future<void> _calculate() async {
    if (!_canCalculate) return;

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
    final colors = AppColors.of(context);
    final latestMeasurement = ref.watch(latestMeasurementProvider);
    final profile = ref.watch(profileNotifierProvider);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: Text(profile?.name ?? 'Calculate'),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline_rounded),
            onPressed: () => context.push('/help'),
            tooltip: 'Help',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart_rounded),
            onPressed: () => context.push('/history'),
            tooltip: 'History',
          ),
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            onPressed: () => context.push('/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: colors.accent.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      size: 20,
                      color: colors.accent,
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Text(
                        'Estimate your visceral fat using simple body measurements.',
                        style: AppTypography.caption(color: colors.textSecondary),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                "Today's Measurements",
                style: AppTypography.headline(color: colors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                dateFormat.format(DateTime.now()),
                style: AppTypography.caption(color: colors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.lg),
              MeasurementInputField(
                label: 'Weight',
                unit: 'kg',
                hint: 'Enter weight',
                minValue: 30,
                maxValue: 300,
                onChanged: (value) => setState(() => _weight = value),
              ),
              const SizedBox(height: AppSpacing.lg),
              MeasurementInputField(
                label: 'Waist Circumference',
                unit: 'cm',
                hint: 'Enter waist',
                minValue: 50,
                maxValue: 200,
                showInfoButton: true,
                onInfoPressed: () => _showMeasurementGuide('waist'),
                onChanged: (value) => setState(() => _waist = value),
              ),
              const SizedBox(height: AppSpacing.lg),
              MeasurementInputField(
                label: 'Thigh Circumference',
                unit: 'cm',
                hint: 'Enter thigh',
                minValue: 30,
                maxValue: 100,
                showInfoButton: true,
                onInfoPressed: () => _showMeasurementGuide('thigh'),
                onChanged: (value) => setState(() => _thigh = value),
              ),
              const SizedBox(height: AppSpacing.xl),
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
                      : const Text('Calculate VAT'),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Divider(color: colors.border),
              const SizedBox(height: AppSpacing.lg),
              Builder(
                builder: (context) {
                  final measurement = latestMeasurement;
                  if (measurement == null) {
                    return Text(
                      'No previous measurements',
                      style: AppTypography.caption(color: colors.textSecondary),
                      textAlign: TextAlign.center,
                    );
                  }

                  final isToday = DateUtils.isSameDay(
                    measurement.timestamp,
                    DateTime.now(),
                  );

                  return Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: colors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                      border: Border.all(color: colors.border),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Last Result: ${measurement.vatCm2.toStringAsFixed(2)} cm\u00B2',
                              style: AppTypography.body(color: colors.textPrimary),
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(
                              'Measured: ${isToday ? "Today" : dateFormat.format(measurement.timestamp)}',
                              style: AppTypography.caption(color: colors.textSecondary),
                            ),
                          ],
                        ),
                        Icon(
                          Icons.chevron_right,
                          color: colors.textSecondary,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
