import 'package:hive/hive.dart';
import 'package:visco/features/calculator/domain/models/measurement.dart';

class MeasurementRepository {
  final Box<Measurement> _box;

  MeasurementRepository(this._box);

  List<Measurement> getAllMeasurements() {
    final measurements = _box.values.toList();
    measurements.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return measurements;
  }

  List<Measurement> getMeasurementsForProfile(String profileId) {
    final measurements = _box.values
        .where((m) => m.profileId == profileId || m.profileId.isEmpty)
        .toList();
    measurements.sort((a, b) => b.timestamp.compareTo(a.timestamp));
    return measurements;
  }

  Measurement? getLatestMeasurement() {
    if (_box.isEmpty) return null;
    final measurements = getAllMeasurements();
    return measurements.isNotEmpty ? measurements.first : null;
  }

  Measurement? getLatestMeasurementForProfile(String profileId) {
    final measurements = getMeasurementsForProfile(profileId);
    return measurements.isNotEmpty ? measurements.first : null;
  }

  List<Measurement> getMeasurementsInRange({
    required DateTime start,
    required DateTime end,
  }) {
    return _box.values
        .where((m) =>
            m.timestamp.isAfter(start) && m.timestamp.isBefore(end))
        .toList()
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));
  }

  Future<void> saveMeasurement(Measurement measurement) async {
    await _box.put(measurement.id, measurement);
  }

  Future<void> deleteMeasurement(String id) async {
    await _box.delete(id);
  }

  Future<void> deleteAllMeasurements() async {
    await _box.clear();
  }

  Future<void> deleteAllMeasurementsForProfile(String profileId) async {
    final toDelete = _box.values
        .where((m) => m.profileId == profileId)
        .map((m) => m.id)
        .toList();
    for (final id in toDelete) {
      await _box.delete(id);
    }
  }

  Stream<List<Measurement>> watchMeasurements() {
    return _box.watch().map((_) => getAllMeasurements());
  }

  String exportToCsv() {
    final measurements = getAllMeasurements();
    return _buildCsv(measurements);
  }

  String exportToCsvForProfile(String profileId) {
    final measurements = getMeasurementsForProfile(profileId);
    return _buildCsv(measurements);
  }

  String _buildCsv(List<Measurement> measurements) {
    final buffer = StringBuffer();

    buffer.writeln('Date,Waist (cm),Thigh (cm),Weight (kg),BMI,VAT (cm2),Risk');

    for (final m in measurements) {
      buffer.writeln(
        '${m.timestamp.toIso8601String()},'
        '${m.waistCm},'
        '${m.thighCm},'
        '${m.weightKg},'
        '${m.bmi.toStringAsFixed(2)},'
        '${m.vatCm2.toStringAsFixed(2)},'
        '${m.riskCategory.name}',
      );
    }

    return buffer.toString();
  }
}
