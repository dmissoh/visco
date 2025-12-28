import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:visco/core/theme/app_colors.dart';
import 'package:visco/core/theme/app_typography.dart';
import 'package:visco/features/premium/providers/premium_provider.dart';

class PaywallScreen extends ConsumerStatefulWidget {
  final String? featureName;

  const PaywallScreen({
    super.key,
    this.featureName,
  });

  @override
  ConsumerState<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends ConsumerState<PaywallScreen> {
  Package? _selectedPackage;

  @override
  Widget build(BuildContext context) {
    final colors = AppColors.of(context);
    final offerings = ref.watch(offeringsProvider);
    final purchaseState = ref.watch(purchaseProvider);

    // Listen for purchase success
    ref.listen<PurchaseState>(purchaseProvider, (previous, next) {
      if (next.purchaseSuccess) {
        Navigator.of(context).pop(true);
        ref.read(purchaseProvider.notifier).clearSuccess();
      }
      if (next.error != null && previous?.error != next.error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: colors.danger,
          ),
        );
        ref.read(purchaseProvider.notifier).clearError();
      }
    });

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Close button
            Align(
              alignment: Alignment.topRight,
              child: IconButton(
                onPressed: () => Navigator.of(context).pop(false),
                icon: Icon(
                  Icons.close,
                  color: colors.textSecondary,
                ),
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Premium badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            colors.accent,
                            colors.success,
                          ],
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        'VISCO PRO',
                        style: AppTypography.label(color: Colors.white),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Headline
                    Text(
                      'Take Control of Your\nLong-Term Health',
                      style: AppTypography.headline(color: colors.textPrimary),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),

                    // Subtitle
                    Text(
                      widget.featureName != null
                          ? 'Unlock ${widget.featureName} and more premium features'
                          : 'Unlock medical-grade tracking and insights',
                      style:
                          AppTypography.caption(color: colors.textSecondary),
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 32),

                    // Benefits list
                    _buildBenefitsList(colors),

                    const SizedBox(height: 32),

                    // Offerings
                    offerings.when(
                      data: (data) {
                        if (data == null || data.current == null) {
                          return _buildPlaceholderPackages(colors);
                        }
                        return _buildPackagesList(
                            data.current!.availablePackages, colors);
                      },
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error, stack) => _buildPlaceholderPackages(colors),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom section with CTA
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: colors.surface,
                border: Border(
                  top: BorderSide(color: colors.border),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Purchase button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: purchaseState.isLoading || _selectedPackage == null
                          ? null
                          : () => _handlePurchase(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.accent,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        disabledBackgroundColor: colors.accent.withOpacity(0.5),
                      ),
                      child: purchaseState.isLoading
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.white,
                              ),
                            )
                          : Text(
                              _getButtonText(),
                              style: AppTypography.title(color: Colors.white),
                            ),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Restore purchases
                  TextButton(
                    onPressed: purchaseState.isLoading
                        ? null
                        : () => _handleRestore(),
                    child: Text(
                      'Restore Purchases',
                      style: AppTypography.caption(color: colors.textSecondary),
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Legal text
                  Text(
                    'Cancel anytime. Subscription auto-renews.',
                    style: AppTypography.label(color: colors.textTertiary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBenefitsList(AppColorScheme colors) {
    final benefits = [
      (Icons.history, 'Unlimited History', 'Track your complete health journey'),
      (Icons.people_outline, 'Multiple Profiles', 'Monitor your whole family'),
      (Icons.description_outlined, "Doctor's Report", 'Export professional PDF reports'),
      (Icons.trending_up, 'Health Projections', 'See your future health trajectory'),
      (Icons.favorite_outline, 'Health Sync', 'Connect to Apple Health & Google Fit'),
      (Icons.cloud_outlined, 'Cloud Backup', 'Never lose your data'),
    ];

    return Column(
      children: benefits.map((benefit) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: colors.accent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  benefit.$1,
                  color: colors.accent,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      benefit.$2,
                      style: AppTypography.body(color: colors.textPrimary),
                    ),
                    Text(
                      benefit.$3,
                      style: AppTypography.caption(color: colors.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPackagesList(List<Package> packages, AppColorScheme colors) {
    // Sort packages: annual first, then monthly, then lifetime
    final sortedPackages = List<Package>.from(packages);
    sortedPackages.sort((a, b) {
      final order = {
        PackageType.annual: 0,
        PackageType.monthly: 1,
        PackageType.lifetime: 2,
      };
      return (order[a.packageType] ?? 3).compareTo(order[b.packageType] ?? 3);
    });

    // Select annual by default if available
    if (_selectedPackage == null && sortedPackages.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _selectedPackage = sortedPackages.firstWhere(
            (p) => p.packageType == PackageType.annual,
            orElse: () => sortedPackages.first,
          );
        });
      });
    }

    return Column(
      children: sortedPackages.map((package) {
        return _buildPackageCard(package, colors);
      }).toList(),
    );
  }

  Widget _buildPackageCard(Package package, AppColorScheme colors) {
    final isSelected = _selectedPackage?.identifier == package.identifier;
    final isAnnual = package.packageType == PackageType.annual;

    String title;
    String? badge;

    switch (package.packageType) {
      case PackageType.monthly:
        title = 'Monthly';
        break;
      case PackageType.annual:
        title = 'Annual';
        badge = 'BEST VALUE';
        break;
      case PackageType.lifetime:
        title = 'Lifetime';
        badge = 'ONE TIME';
        break;
      default:
        title = package.storeProduct.title;
    }

    return GestureDetector(
      onTap: () => setState(() => _selectedPackage = package),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colors.accent.withOpacity(0.05) : colors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colors.accent : colors.border,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            // Radio indicator
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? colors.accent : colors.border,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors.accent,
                        ),
                      ),
                    )
                  : null,
            ),

            const SizedBox(width: 16),

            // Title and badge
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        title,
                        style: AppTypography.body(color: colors.textPrimary),
                      ),
                      if (badge != null) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: isAnnual ? colors.success : colors.accent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            badge,
                            style: AppTypography.label(color: Colors.white)
                                .copyWith(fontSize: 10),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (isAnnual)
                    Text(
                      '7 days free trial',
                      style: AppTypography.caption(color: colors.success),
                    ),
                ],
              ),
            ),

            // Price
            Text(
              package.storeProduct.priceString,
              style: AppTypography.title(color: colors.textPrimary),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaceholderPackages(AppColorScheme colors) {
    // Placeholder when RevenueCat isn't configured
    return Column(
      children: [
        _buildPlaceholderCard('Annual', '\$19.99/year', true, colors),
        _buildPlaceholderCard('Monthly', '\$2.99/month', false, colors),
        _buildPlaceholderCard('Lifetime', '\$49.99', false, colors),
      ],
    );
  }

  Widget _buildPlaceholderCard(
    String title,
    String price,
    bool isSelected,
    AppColorScheme colors,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? colors.accent.withOpacity(0.05) : colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isSelected ? colors.accent : colors.border,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? colors.accent : colors.border,
                width: 2,
              ),
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.accent,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: AppTypography.body(color: colors.textPrimary),
            ),
          ),
          Text(
            price,
            style: AppTypography.title(color: colors.textPrimary),
          ),
        ],
      ),
    );
  }

  String _getButtonText() {
    if (_selectedPackage == null) {
      return 'Select a Plan';
    }

    switch (_selectedPackage!.packageType) {
      case PackageType.annual:
        return 'Start Free Trial';
      case PackageType.lifetime:
        return 'Purchase Lifetime';
      default:
        return 'Subscribe Now';
    }
  }

  Future<void> _handlePurchase() async {
    if (_selectedPackage == null) return;
    await ref.read(purchaseProvider.notifier).purchasePackage(_selectedPackage!);
  }

  Future<void> _handleRestore() async {
    final result = await ref.read(purchaseProvider.notifier).restorePurchases();
    if (result && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Purchases restored successfully!'),
          backgroundColor: AppColors.of(context).success,
        ),
      );
    }
  }
}

/// Helper function to show the paywall
Future<bool> showPaywall(BuildContext context, {String? featureName}) async {
  final result = await Navigator.of(context).push<bool>(
    MaterialPageRoute(
      builder: (context) => PaywallScreen(featureName: featureName),
      fullscreenDialog: true,
    ),
  );
  return result ?? false;
}
