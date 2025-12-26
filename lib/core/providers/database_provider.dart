import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

const String profileBoxName = 'profile';
const String measurementsBoxName = 'measurements';

final hiveInitProvider = FutureProvider<void>((ref) async {
  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(SexAdapter());
  Hive.registerAdapter(UserProfileAdapter());
  Hive.registerAdapter(RiskCategoryAdapter());
  Hive.registerAdapter(MeasurementAdapter());

  // Open boxes
  await Hive.openBox<UserProfile>(profileBoxName);
  await Hive.openBox<Measurement>(measurementsBoxName);
});

final profileBoxProvider = Provider<Box<UserProfile>>((ref) {
  return Hive.box<UserProfile>(profileBoxName);
});

final measurementsBoxProvider = Provider<Box<Measurement>>((ref) {
  return Hive.box<Measurement>(measurementsBoxName);
});
