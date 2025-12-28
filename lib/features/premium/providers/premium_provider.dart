import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:visco/core/services/revenuecat_service.dart';

/// Debug override for premium status during development
/// Set to true to simulate premium user, false for free user, null to use real status
final debugPremiumOverrideProvider = StateProvider<bool?>((ref) {
  // In debug mode, default to premium for easier testing
  // Set to null to test real RevenueCat flow
  return kDebugMode ? true : null;
});

/// Provider for RevenueCat service singleton
final revenueCatServiceProvider = Provider<RevenueCatService>((ref) {
  return RevenueCatService();
});

/// Provider for premium status - async because it needs to check RevenueCat
final premiumStatusProvider =
    AsyncNotifierProvider<PremiumStatusNotifier, bool>(
  () => PremiumStatusNotifier(),
);

class PremiumStatusNotifier extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final service = ref.read(revenueCatServiceProvider);
    return await service.isPremium();
  }

  /// Refresh premium status from RevenueCat
  Future<void> refresh() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final service = ref.read(revenueCatServiceProvider);
      return await service.isPremium();
    });
  }

  /// Update premium status (called after successful purchase)
  void setPremium(bool isPremium) {
    state = AsyncValue.data(isPremium);
  }
}

/// Provider for available offerings
final offeringsProvider = FutureProvider<Offerings?>((ref) async {
  final service = ref.read(revenueCatServiceProvider);
  return await service.getOfferings();
});

/// Provider for customer info
final customerInfoProvider = FutureProvider<CustomerInfo?>((ref) async {
  final service = ref.read(revenueCatServiceProvider);
  return await service.getCustomerInfo();
});

/// Convenience provider to check if user is premium (synchronous with default false)
final isPremiumProvider = Provider<bool>((ref) {
  // Check for debug override first
  final debugOverride = ref.watch(debugPremiumOverrideProvider);
  if (debugOverride != null) {
    return debugOverride;
  }
  
  // Otherwise use real premium status
  final premiumStatus = ref.watch(premiumStatusProvider);
  return premiumStatus.valueOrNull ?? false;
});

/// Provider for handling purchases
final purchaseProvider =
    StateNotifierProvider<PurchaseNotifier, PurchaseState>((ref) {
  return PurchaseNotifier(ref);
});

class PurchaseState {
  final bool isLoading;
  final String? error;
  final bool purchaseSuccess;

  const PurchaseState({
    this.isLoading = false,
    this.error,
    this.purchaseSuccess = false,
  });

  PurchaseState copyWith({
    bool? isLoading,
    String? error,
    bool? purchaseSuccess,
  }) {
    return PurchaseState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      purchaseSuccess: purchaseSuccess ?? this.purchaseSuccess,
    );
  }
}

class PurchaseNotifier extends StateNotifier<PurchaseState> {
  final Ref _ref;

  PurchaseNotifier(this._ref) : super(const PurchaseState());

  Future<bool> purchasePackage(Package package) async {
    state = state.copyWith(isLoading: true, error: null, purchaseSuccess: false);

    final service = _ref.read(revenueCatServiceProvider);
    final result = await service.purchasePackage(package);

    if (result.success) {
      // Update premium status
      _ref.read(premiumStatusProvider.notifier).setPremium(true);
      state = state.copyWith(isLoading: false, purchaseSuccess: true);
      return true;
    } else {
      state = state.copyWith(isLoading: false, error: result.displayError);
      return false;
    }
  }

  Future<bool> restorePurchases() async {
    state = state.copyWith(isLoading: true, error: null, purchaseSuccess: false);

    final service = _ref.read(revenueCatServiceProvider);
    final result = await service.restorePurchases();

    if (result.success) {
      _ref.read(premiumStatusProvider.notifier).setPremium(result.isPremium);
      state = state.copyWith(
        isLoading: false,
        purchaseSuccess: result.isPremium,
        error: result.isPremium ? null : 'No previous purchases found',
      );
      return result.isPremium;
    } else {
      state = state.copyWith(
        isLoading: false,
        error: result.errorMessage ?? 'Failed to restore purchases',
      );
      return false;
    }
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSuccess() {
    state = state.copyWith(purchaseSuccess: false);
  }
}
