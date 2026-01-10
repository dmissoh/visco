import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_guide_modal.dart';
import 'package:visco/features/calculator/presentation/widgets/measurement_input_field.dart';
import 'package:visco/features/calculator/providers/measurement_provider.dart';
import 'package:visco/features/insights/presentation/widgets/insights_card.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';
import 'package:visco/l10n/generated/app_localizations.dart';
import 'package:visco/shared/widgets/trend_indicator.dart';

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

  String _getInitials(String name) {
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts.first[0]}${parts.last[0]}'.toUpperCase();
    }
    return name.isNotEmpty ? name[0].toUpperCase() : '?';
  }

  Future<void> _pickProfileImage() async {
    final l10n = AppLocalizations.of(context)!;
    final colors = AppColors.of(context);
    
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: Text(l10n.takePhoto),
              onTap: () => Navigator.pop(context, ImageSource.camera),
            ),
            ListTile(
              leading: const Icon(Icons.photo_library),
              title: Text(l10n.chooseFromGallery),
              onTap: () => Navigator.pop(context, ImageSource.gallery),
            ),
            if (ref.read(profileNotifierProvider)?.profileImagePath != null)
              ListTile(
                leading: Icon(Icons.delete, color: colors.danger),
                title: Text(l10n.removePhoto, style: TextStyle(color: colors.danger)),
                onTap: () => Navigator.pop(context, null),
              ),
          ],
        ),
      ),
    );

    if (source == null && ref.read(profileNotifierProvider)?.profileImagePath != null) {
      // Remove photo
      await ref.read(profileNotifierProvider.notifier).updateProfileImage(null);
      return;
    }

    if (source == null) return;

    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
      imageQuality: 85,
    );

    if (pickedFile == null) return;

    // Save to app documents directory
    final appDir = await getApplicationDocumentsDirectory();
    final profileId = ref.read(profileNotifierProvider)?.id ?? 'unknown';
    final fileName = 'profile_$profileId.jpg';
    final savedPath = '${appDir.path}/$fileName';

    // Copy file to app directory
    await File(pickedFile.path).copy(savedPath);

    // Update profile with new image path
    await ref.read(profileNotifierProvider.notifier).updateProfileImage(savedPath);
  }

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
    final latestMeasurement = ref.watch(latestMeasurementProvider);
    final profile = ref.watch(profileNotifierProvider);
    final trend = ref.watch(vatTrendProvider);
    final unitSystem = ref.watch(unitSystemProvider);
    final dateFormat = DateFormat('dd/MM/yyyy');

    // Show create profile prompt if no profile exists
    if (profile == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(l10n.navCalculate),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline_rounded),
              onPressed: () => context.push('/help'),
              tooltip: l10n.help,
            ),
          ],
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person_outline,
                  size: 80,
                  color: colors.textTertiary,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.createProfileToStart,
                  style: AppTypography.headline(color: colors.textPrimary),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.createProfileExplanation,
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
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: _pickProfileImage,
              child: CircleAvatar(
                radius: 16,
                backgroundColor: Theme.of(context).colorScheme.primaryContainer,
                backgroundImage: profile.profileImagePath != null
                    ? FileImage(File(profile.profileImagePath!))
                    : null,
                child: profile.profileImagePath == null
                    ? Text(
                        _getInitials(profile.name),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                      )
                    : null,
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                profile.name,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: () => context.push('/help'),
            icon: const Icon(Icons.help_outline_rounded, size: 20),
            label: Text(l10n.help),
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.todaysMeasurements,
                style: AppTypography.headline(color: colors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                dateFormat.format(DateTime.now()),
                style: AppTypography.caption(color: colors.textSecondary),
              ),
              const SizedBox(height: AppSpacing.lg),
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
              const SizedBox(height: AppSpacing.lg),
              MeasurementInputField(
                label: l10n.waistCircumference,
                unit: 'cm',
                hint: l10n.enterWaist,
                minValue: 50,
                measurementType: MeasurementType.length,
                unitSystem: unitSystem,
                maxValue: 200,
                showInfoButton: true,
                onInfoPressed: () => _showMeasurementGuide('waist'),
                onChanged: (value) => setState(() => _waist = value),
              ),
              const SizedBox(height: AppSpacing.lg),
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
              SizedBox(
                height: 56,
                width: double.infinity,
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
              const SizedBox(height: AppSpacing.xl),
              Divider(color: colors.border),
              const SizedBox(height: AppSpacing.lg),
              Builder(
                builder: (context) {
                  final measurement = latestMeasurement;
                  if (measurement == null) {
                    return Text(
                      l10n.noPreviousMeasurements,
                      style: AppTypography.caption(color: colors.textSecondary),
                      textAlign: TextAlign.center,
                    );
                  }

                  final isToday = DateUtils.isSameDay(
                    measurement.timestamp,
                    DateTime.now(),
                  );

                  return GestureDetector(
                    onTap: () => context.push('/result', extra: measurement),
                    child: Container(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      decoration: BoxDecoration(
                        color: colors.surface,
                        borderRadius: BorderRadius.circular(AppRadius.md),
                        border: Border.all(color: colors.border),
                      ),
                      child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'VAT: ${measurement.vatCm2.toStringAsFixed(2)}',
                                    style: AppTypography.body(color: colors.textPrimary),
                                  ),
                                  const SizedBox(width: AppSpacing.sm),
                                  TrendIndicator(trend: trend),
                                ],
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                'BMI: ${measurement.bmi.toStringAsFixed(1)}',
                                style: AppTypography.body(color: colors.textPrimary),
                              ),
                              const SizedBox(height: AppSpacing.xs),
                              Text(
                                '${l10n.measured} ${isToday ? l10n.today : dateFormat.format(measurement.timestamp)}',
                                style: AppTypography.caption(color: colors.textSecondary),
                              ),
                            ],
                          ),
                        ),
                          Icon(
                            Icons.chevron_right,
                            color: colors.textSecondary,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (latestMeasurement != null) ...[
                const SizedBox(height: AppSpacing.md),
                const InsightsCard(),
              ],
            ],
          ),
        ),
        ),
      ),
    );
  }
}
