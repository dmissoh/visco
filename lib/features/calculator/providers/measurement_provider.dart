import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import 'package:visco/core/providers/database_provider.dart';
import 'package:visco/features/calculator/data/repositories/measurement_repository.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';
import 'package:visco/features/calculator/domain/services/vat_calculator.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';
import 'package:visco/features/onboarding/providers/profile_provider.dart';

const _uuid = Uuid();

// Refresh trigger for measurements
final measurementRefreshProvider = StateProvider<int>((ref) => 0);

final measurementRepositoryProvider = Provider<MeasurementRepository>((ref) {
  final box = ref.watch(measurementsBoxProvider);
  return MeasurementRepository(box);
});

// All measurements for current profile
final measurementsProvider = Provider<List<Measurement>>((ref) {
  final repository = ref.watch(measurementRepositoryProvider);
  ref.watch(activeProfileIdProvider); // Watch for profile switches
  ref.watch(measurementRefreshProvider); // Watch for measurement changes
  final profile = ref.watch(profileNotifierProvider);
  if (profile == null) return [];
  return repository.getMeasurementsForProfile(profile.id);
});

// Latest measurement for current profile
final latestMeasurementProvider = Provider<Measurement?>((ref) {
  final repository = ref.watch(measurementRepositoryProvider);
  ref.watch(activeProfileIdProvider); // Watch for profile switches
  ref.watch(measurementRefreshProvider); // Watch for measurement changes
  final profile = ref.watch(profileNotifierProvider);
  if (profile == null) return null;
  return repository.getLatestMeasurementForProfile(profile.id);
});

final measurementNotifierProvider =
    NotifierProvider<MeasurementNotifier, List<Measurement>>(
        () => MeasurementNotifier());

class MeasurementNotifier extends Notifier<List<Measurement>> {
  @override
  List<Measurement> build() {
    final repository = ref.watch(measurementRepositoryProvider);
    ref.watch(activeProfileIdProvider); // Watch for profile switches
    final profile = ref.watch(profileNotifierProvider);
    if (profile == null) return [];
    return repository.getMeasurementsForProfile(profile.id);
  }

  Future<Measurement> calculateAndSave({
    required UserProfile profile,
    required double waistCm,
    required double thighCm,
    required double weightKg,
  }) async {
    final repository = ref.read(measurementRepositoryProvider);

    final result = VatCalculator.calculate(
      sex: profile.sex,
      waistCm: waistCm,
      thighCm: thighCm,
      age: profile.age,
      weightKg: weightKg,
      heightCm: profile.heightCm,
    );

    final measurement = Measurement(
      id: _uuid.v4(),
      profileId: profile.id,
      timestamp: DateTime.now(),
      waistCm: waistCm,
      thighCm: thighCm,
      weightKg: weightKg,
      bmi: result.bmi,
      vatCm2: result.vatCm2,
      riskCategory: Measurement.calculateRiskCategory(result.vatCm2),
    );

    await repository.saveMeasurement(measurement);
    ref.read(measurementRefreshProvider.notifier).state++;
    ref.invalidateSelf();

    return measurement;
  }

  Future<void> deleteMeasurement(String id) async {
    final repository = ref.read(measurementRepositoryProvider);
    await repository.deleteMeasurement(id);
    ref.read(measurementRefreshProvider.notifier).state++;
    ref.invalidateSelf();
  }

  Future<void> deleteAllMeasurementsForProfile(String profileId) async {
    final repository = ref.read(measurementRepositoryProvider);
    await repository.deleteAllMeasurementsForProfile(profileId);
    ref.read(measurementRefreshProvider.notifier).state++;
    ref.invalidateSelf();
  }

  String exportToCsv() {
    final repository = ref.read(measurementRepositoryProvider);
    final profile = ref.read(profileNotifierProvider);
    if (profile == null) return '';
    return repository.exportToCsvForProfile(profile.id);
  }
}

enum TimeRange { oneMonth, threeMonths, sixMonths, oneYear, all }

final timeRangeProvider = StateProvider<TimeRange>((ref) => TimeRange.threeMonths);

final filteredMeasurementsProvider = Provider<List<Measurement>>((ref) {
  final measurements = ref.watch(measurementsProvider);
  final timeRange = ref.watch(timeRangeProvider);

  if (timeRange == TimeRange.all) return measurements;

  final now = DateTime.now();
  final cutoff = switch (timeRange) {
    TimeRange.oneMonth => now.subtract(const Duration(days: 30)),
    TimeRange.threeMonths => now.subtract(const Duration(days: 90)),
    TimeRange.sixMonths => now.subtract(const Duration(days: 180)),
    TimeRange.oneYear => now.subtract(const Duration(days: 365)),
    TimeRange.all => DateTime(1970),
  };

  return measurements
      .where((m) => m.timestamp.isAfter(cutoff))
      .toList();
});

// Trend data for VAT changes
enum TrendDirection { up, down, stable, unknown }

class VatTrend {
  final TrendDirection direction;
  final double? change; // Absolute change
  final double? percentChange; // Percentage change

  const VatTrend({
    required this.direction,
    this.change,
    this.percentChange,
  });

  static const unknown = VatTrend(direction: TrendDirection.unknown);
}

final vatTrendProvider = Provider<VatTrend>((ref) {
  final measurements = ref.watch(measurementsProvider);
  ref.watch(measurementRefreshProvider);

  if (measurements.length < 2) {
    return VatTrend.unknown;
  }

  // Sort by timestamp descending to get latest first
  final sorted = List<Measurement>.from(measurements)
    ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

  final latest = sorted[0];
  final previous = sorted[1];

  final change = latest.vatCm2 - previous.vatCm2;
  final percentChange = (change / previous.vatCm2) * 100;

  TrendDirection direction;
  if (change.abs() < 1) {
    direction = TrendDirection.stable;
  } else if (change > 0) {
    direction = TrendDirection.up;
  } else {
    direction = TrendDirection.down;
  }

  return VatTrend(
    direction: direction,
    change: change,
    percentChange: percentChange,
  );
});
