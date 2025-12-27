import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visco/app.dart';
import 'package:visco/core/providers/database_provider.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(SexAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(RiskCategoryAdapter());
  Hive.registerAdapter(MeasurementAdapter());

  // Open boxes
  await Hive.openBox<UserProfile>(profileBoxName);
  await Hive.openBox<Measurement>(measurementsBoxName);
  await Hive.openBox(settingsBoxName);

  runApp(
    const ProviderScope(
      child: ViscoApp(),
    ),
  );
}
