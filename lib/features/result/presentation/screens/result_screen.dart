import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/export/services/pdf_export_service.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/result/presentation/widgets/bmi_result_card.dart';
import 'package:visco/features/result/presentation/widgets/bmi_scale_indicator.dart';
import 'package:visco/features/result/presentation/widgets/measurements_summary.dart';
import 'package:visco/features/result/presentation/widgets/risk_scale_indicator.dart';
import 'package:visco/features/result/presentation/widgets/vat_result_card.dart';

class ResultScreen extends ConsumerWidget {
  final Measurement measurement;

  const ResultScreen({
    super.key,
    required this.measurement,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colors = AppColors.of(context);
    final trend = ref.watch(vatTrendProvider);
    final profile = ref.watch(profileNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: const Text('Result'),
        actions: [
          if (profile != null)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => PdfExportService.exportSingleMeasurement(
                profile: profile,
                measurement: measurement,
              ),
              tooltip: 'Share Result',
            ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              VatResultCard(measurement: measurement, trend: trend),
              const SizedBox(height: AppSpacing.md),
              RiskScaleIndicator(vatValue: measurement.vatCm2),
              const SizedBox(height: AppSpacing.md),
              SizedBox(
                height: 48,
                child: FilledButton.icon(
                  onPressed: () => context.push('/insights', extra: measurement),
                  icon: const Icon(Icons.lightbulb_outline, size: 20),
                  label: const Text('View Health Insights'),
                  style: FilledButton.styleFrom(
                    backgroundColor: colors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              BmiResultCard(bmi: measurement.bmi),
              const SizedBox(height: AppSpacing.md),
              BmiScaleIndicator(bmiValue: measurement.bmi),
              const SizedBox(height: AppSpacing.xl),
              MeasurementsSummary(measurement: measurement),
              const SizedBox(height: AppSpacing.xl),
              SizedBox(
                height: 56,
                child: OutlinedButton(
                  onPressed: () => context.push('/history'),
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: colors.accent),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                  child: Text(
                    'View Progress Chart',
                    style: AppTypography.body(color: colors.accent),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
