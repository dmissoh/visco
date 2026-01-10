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
import 'package:visco/l10n/generated/app_localizations.dart';

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
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/'),
        ),
        title: Text(l10n.result),
        actions: [
          if (profile != null)
            IconButton(
              icon: const Icon(Icons.share_outlined),
              onPressed: () => PdfExportService.exportSingleMeasurement(
                profile: profile,
                measurement: measurement,
              ),
              tooltip: l10n.shareResult,
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
                  label: Text(l10n.viewHealthInsights),
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
                    l10n.viewProgressChart,
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
