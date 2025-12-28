import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

/// RevenueCat API keys - Replace with your actual keys from RevenueCat dashboard
class RevenueCatConfig {
  // TODO: Replace with your actual RevenueCat API keys
  static const String appleApiKey = 'your_apple_api_key';
  static const String googleApiKey = 'your_google_api_key';

  // Entitlement ID configured in RevenueCat
  static const String premiumEntitlementId = 'pro_access';

  // Product IDs (configured in App Store Connect / Google Play Console)
  static const String monthlyProductId = 'visco_monthly';
  static const String annualProductId = 'visco_annual';
  static const String lifetimeProductId = 'visco_lifetime';
}

/// Service for handling RevenueCat subscriptions and purchases
class RevenueCatService {
  static final RevenueCatService _instance = RevenueCatService._internal();
  factory RevenueCatService() => _instance;
  RevenueCatService._internal();

  bool _isInitialized = false;

  /// Initialize RevenueCat SDK
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      final apiKey = Platform.isIOS
          ? RevenueCatConfig.appleApiKey
          : RevenueCatConfig.googleApiKey;

      final configuration = PurchasesConfiguration(apiKey);

      if (kDebugMode) {
        // Enable debug logs in development
        await Purchases.setLogLevel(LogLevel.debug);
      }

      await Purchases.configure(configuration);
      _isInitialized = true;

      debugPrint('RevenueCat initialized successfully');
    } catch (e) {
      debugPrint('Error initializing RevenueCat: $e');
      rethrow;
    }
  }

  /// Check if the user has premium access
  Future<bool> isPremium() async {
    try {
      final customerInfo = await Purchases.getCustomerInfo();
      return customerInfo
              .entitlements.all[RevenueCatConfig.premiumEntitlementId]
              ?.isActive ??
          false;
    } catch (e) {
      debugPrint('Error checking premium status: $e');
      return false;
    }
  }

  /// Get current customer info
  Future<CustomerInfo?> getCustomerInfo() async {
    try {
      return await Purchases.getCustomerInfo();
    } catch (e) {
      debugPrint('Error getting customer info: $e');
      return null;
    }
  }

  /// Get available offerings (products)
  Future<Offerings?> getOfferings() async {
    try {
      return await Purchases.getOfferings();
    } catch (e) {
      debugPrint('Error getting offerings: $e');
      return null;
    }
  }

  /// Purchase a package
  Future<PurchaseResultModel> purchasePackage(Package package) async {
    try {
      final result = await Purchases.purchase(PurchaseParams.package(package));
      final customerInfo = result.customerInfo;
      final isPremium = customerInfo
              .entitlements.all[RevenueCatConfig.premiumEntitlementId]
              ?.isActive ??
          false;

      return PurchaseResultModel(
        success: isPremium,
        customerInfo: customerInfo,
      );
    } on PurchasesErrorCode catch (e) {
      debugPrint('Purchase error code: $e');
      return PurchaseResultModel(
        success: false,
        errorCode: e,
      );
    } catch (e) {
      debugPrint('Purchase error: $e');
      return PurchaseResultModel(
        success: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Restore purchases
  Future<RestoreResult> restorePurchases() async {
    try {
      final customerInfo = await Purchases.restorePurchases();
      final isPremium = customerInfo
              .entitlements.all[RevenueCatConfig.premiumEntitlementId]
              ?.isActive ??
          false;

      return RestoreResult(
        success: true,
        isPremium: isPremium,
        customerInfo: customerInfo,
      );
    } catch (e) {
      debugPrint('Restore error: $e');
      return RestoreResult(
        success: false,
        isPremium: false,
        errorMessage: e.toString(),
      );
    }
  }

  /// Set user ID for attribution
  Future<void> setUserId(String userId) async {
    try {
      await Purchases.logIn(userId);
    } catch (e) {
      debugPrint('Error setting user ID: $e');
    }
  }

  /// Listen to customer info updates
  void addCustomerInfoUpdateListener(
      void Function(CustomerInfo) listener) {
    Purchases.addCustomerInfoUpdateListener(listener);
  }

  /// Remove customer info update listener
  void removeCustomerInfoUpdateListener(
      void Function(CustomerInfo) listener) {
    Purchases.removeCustomerInfoUpdateListener(listener);
  }
}

/// Result of a purchase attempt
class PurchaseResultModel {
  final bool success;
  final CustomerInfo? customerInfo;
  final PurchasesErrorCode? errorCode;
  final String? errorMessage;

  PurchaseResultModel({
    required this.success,
    this.customerInfo,
    this.errorCode,
    this.errorMessage,
  });

  String get displayError {
    if (errorCode != null) {
      switch (errorCode!) {
        case PurchasesErrorCode.purchaseCancelledError:
          return 'Purchase was cancelled';
        case PurchasesErrorCode.storeProblemError:
          return 'There was a problem with the App Store. Please try again.';
        case PurchasesErrorCode.purchaseNotAllowedError:
          return 'Purchase not allowed on this device';
        case PurchasesErrorCode.purchaseInvalidError:
          return 'Invalid purchase. Please try again.';
        case PurchasesErrorCode.productNotAvailableForPurchaseError:
          return 'This product is not available for purchase';
        case PurchasesErrorCode.networkError:
          return 'Network error. Please check your connection.';
        default:
          return 'An error occurred. Please try again.';
      }
    }
    return errorMessage ?? 'An unknown error occurred';
  }
}

/// Result of a restore attempt
class RestoreResult {
  final bool success;
  final bool isPremium;
  final CustomerInfo? customerInfo;
  final String? errorMessage;

  RestoreResult({
    required this.success,
    required this.isPremium,
    this.customerInfo,
    this.errorMessage,
  });
}
