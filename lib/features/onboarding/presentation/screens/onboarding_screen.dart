import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:visco/core/constants/app_constants.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';
import 'package:visco/features/onboarding/presentation/widgets/date_picker_field.dart';
import 'package:visco/features/onboarding/presentation/widgets/height_input_field.dart';
import 'package:visco/features/onboarding/presentation/widgets/sex_selector.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  Sex _selectedSex = Sex.female;
  DateTime _birthDate = DateTime(1985, 1, 1);
  double _heightCm = 170;
  bool _isLoading = false;

  Future<void> _saveProfile() async {
    setState(() => _isLoading = true);

    try {
      await ref.read(profileNotifierProvider.notifier).saveProfile(
            sex: _selectedSex,
            birthDate: _birthDate,
            heightCm: _heightCm,
          );

      if (mounted) {
        context.go('/');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxl),
              Text(
                'Visco',
                style: AppTypography.display(color: colors.textPrimary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                'Visceral Fat Calculator',
                style: AppTypography.body(color: colors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text(
                "Let's set up your profile",
                style: AppTypography.headline(color: colors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.lg),
              SexSelector(
                selectedSex: _selectedSex,
                onChanged: (sex) => setState(() => _selectedSex = sex),
              ),
              const SizedBox(height: AppSpacing.lg),
              DatePickerField(
                label: 'Date of Birth',
                selectedDate: _birthDate,
                onChanged: (date) => setState(() => _birthDate = date),
              ),
              const SizedBox(height: AppSpacing.lg),
              HeightInputField(
                value: _heightCm,
                onChanged: (height) => setState(() => _heightCm = height),
              ),
              const SizedBox(height: AppSpacing.xxl),
              SizedBox(
                height: 56,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _saveProfile,
                  child: _isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
