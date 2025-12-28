import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visco/app.dart';
import 'package:visco/core/providers/database_provider.dart';
import 'package:visco/core/services/notification_service.dart';
import 'package:visco/core/services/revenuecat_service.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    // Initialize Hive
    await Hive.initFlutter();
    
    // Initialize notifications
    await NotificationService().initialize();
    
    // Initialize RevenueCat
    await RevenueCatService().initialize();

    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(SexAdapter());
    }
    if (!Hive.isAdapterRegistered(1)) {
      Hive.registerAdapter(UserProfileAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(RiskCategoryAdapter());
    }
    if (!Hive.isAdapterRegistered(3)) {
      Hive.registerAdapter(MeasurementAdapter());
    }

    // Clear all boxes on first run after update to handle schema change
    await _openBoxSafely<UserProfile>(profileBoxName);
    await _openBoxSafely<Measurement>(measurementsBoxName);
    await _openBoxSafely<dynamic>(settingsBoxName);

    runApp(
      const ProviderScope(
        child: ViscoApp(),
      ),
    );
  } catch (e) {
    // If all else fails, show error screen
    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                'Error starting app: $e\n\nPlease reinstall the app.',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

Future<Box<T>> _openBoxSafely<T>(String boxName) async {
  try {
    if (Hive.isBoxOpen(boxName)) {
      return Hive.box<T>(boxName);
    }
    return await Hive.openBox<T>(boxName);
  } catch (e) {
    // Delete corrupted box and recreate
    await Hive.deleteBoxFromDisk(boxName);
    return await Hive.openBox<T>(boxName);
  }
}
