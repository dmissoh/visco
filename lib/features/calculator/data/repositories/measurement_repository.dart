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

  Measurement? getLatestMeasurement() {
    if (_box.isEmpty) return null;
    final measurements = getAllMeasurements();
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

  Stream<List<Measurement>> watchMeasurements() {
    return _box.watch().map((_) => getAllMeasurements());
  }

  String exportToCsv() {
    final measurements = getAllMeasurements();
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
