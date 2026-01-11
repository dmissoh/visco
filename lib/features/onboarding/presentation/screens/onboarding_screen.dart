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
import 'package:visco/l10n/generated/app_localizations.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  final bool isAddingNewProfile;
  
  const OnboardingScreen({super.key, this.isAddingNewProfile = false});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _pageController = PageController();
  final _nameController = TextEditingController();
  Sex _selectedSex = Sex.female;
  DateTime _birthDate = DateTime(1985, 1, 1);
  double _heightCm = 170;
  bool _isLoading = false;
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _saveProfile() async {
    final l10n = AppLocalizations.of(context)!;
    final name = _nameController.text.trim();
    if (name.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.pleaseEnterProfileName)),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      await ref.read(profileNotifierProvider.notifier).saveProfile(
            name: name,
            sex: _selectedSex,
            birthDate: _birthDate,
            heightCm: _heightCm,
          );

      // Mark onboarding as completed (check mounted before using ref)
      if (mounted) {
        await markOnboardingCompleted(ref);
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

    // For adding new profile, skip intro pages
    if (widget.isAddingNewProfile) {
      return _buildProfileSetupPage(colors, isStandalone: true);
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: [
                  _buildWelcomePage(colors),
                  _buildWhatIsVatPage(colors),
                  _buildHowItWorksPage(colors),
                  _buildProfileSetupPage(colors, isStandalone: false),
                ],
              ),
            ),
            _buildPageIndicator(colors),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _buildPageIndicator(AppColorScheme colors) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(4, (index) {
          final isActive = index == _currentPage;
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 4),
            width: isActive ? 24 : 8,
            height: 8,
            decoration: BoxDecoration(
              color: isActive ? colors.accent : colors.border,
              borderRadius: BorderRadius.circular(4),
            ),
          );
        }),
      ),
    );
  }

  Future<void> _skipOnboarding() async {
    await markOnboardingCompleted(ref);
    if (mounted) {
      context.go('/');
    }
  }

  Widget _buildWelcomePage(AppColorScheme colors) {
    final l10n = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            l10n.welcomeTitle,
            style: AppTypography.display(color: colors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.welcomeSubtitle,
            style: AppTypography.body(color: colors.textSecondary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text(l10n.getStarted),
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextButton(
            onPressed: _skipOnboarding,
            child: Text(
              l10n.skipAndExplore,
              style: AppTypography.body(color: colors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatIsVatPage(AppColorScheme colors) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Icon(
              Icons.info_outline,
              size: 64,
              color: colors.accent,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.whatIsVatTitle,
            style: AppTypography.headline(color: colors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildInfoCard(
            colors,
            icon: Icons.layers_outlined,
            title: l10n.hiddenFatTitle,
            description: l10n.hiddenFatDesc,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildInfoCard(
            colors,
            icon: Icons.warning_amber_outlined,
            title: l10n.healthRisksTitle,
            description: l10n.healthRisksDesc,
          ),
          const SizedBox(height: AppSpacing.md),
          _buildInfoCard(
            colors,
            icon: Icons.visibility_outlined,
            title: l10n.notVisibleTitle,
            description: l10n.notVisibleDesc,
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text(l10n.continueButton),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHowItWorksPage(AppColorScheme colors) {
    final l10n = AppLocalizations.of(context)!;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: Icon(
              Icons.straighten_outlined,
              size: 64,
              color: colors.accent,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text(
            l10n.howItWorksTitle,
            style: AppTypography.headline(color: colors.textPrimary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
          _buildStepCard(colors, step: '1', title: l10n.stepMeasure, description: l10n.stepMeasureDesc),
          const SizedBox(height: AppSpacing.md),
          _buildStepCard(colors, step: '2', title: l10n.stepCalculate, description: l10n.stepCalculateDesc),
          const SizedBox(height: AppSpacing.md),
          _buildStepCard(colors, step: '3', title: l10n.stepTrack, description: l10n.stepTrackDesc),
          const SizedBox(height: AppSpacing.lg),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: colors.success.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(color: colors.success.withValues(alpha: 0.3)),
            ),
            child: Row(
              children: [
                Icon(Icons.science_outlined, color: colors.success),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Text(
                    l10n.scientificNote,
                    style: AppTypography.caption(color: colors.success),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          SizedBox(
            width: double.infinity,
            height: 56,
            child: ElevatedButton(
              onPressed: _nextPage,
              child: Text(l10n.setUpProfile),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(
    AppColorScheme colors, {
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: colors.accent, size: 28),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.title(color: colors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography.body(color: colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(
    AppColorScheme colors, {
    required String step,
    required String title,
    required String description,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: colors.accent,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                step,
                style: AppTypography.title(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTypography.title(color: colors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: AppTypography.body(color: colors.textSecondary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSetupPage(AppColorScheme colors, {required bool isStandalone}) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: isStandalone
          ? AppBar(
              backgroundColor: colors.background,
              foregroundColor: colors.textPrimary,
              elevation: 0,
              title: Text(l10n.newProfileTitle),
            )
          : null,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (!isStandalone) ...[
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.profileSetupTitle,
                style: AppTypography.headline(color: colors.textPrimary),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.profileSetupSubtitle,
                style: AppTypography.body(color: colors.textSecondary),
              ),
            ] else ...[
              Text(
                l10n.createNewProfile,
                style: AppTypography.headline(color: colors.textPrimary),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: l10n.profileName,
                hintText: l10n.profileNameHint,
                labelStyle: AppTypography.caption(color: colors.textSecondary),
              ),
              style: AppTypography.body(color: colors.textPrimary),
            ),
            const SizedBox(height: AppSpacing.lg),
            SexSelector(
              selectedSex: _selectedSex,
              onChanged: (sex) => setState(() => _selectedSex = sex),
            ),
            const SizedBox(height: AppSpacing.lg),
            DatePickerField(
              label: l10n.dateOfBirth,
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
                    : Text(isStandalone ? l10n.createProfile : l10n.startTracking),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
