import 'package:hive/hive.dart';

enum RiskCategory {
  healthy,
  elevated,
  obesity,
}

class Measurement extends HiveObject {
  String id;
  DateTime timestamp;
  double waistCm;
  double thighCm;
  double weightKg;
  double bmi;
  double vatCm2;
  RiskCategory riskCategory;

  Measurement({
    required this.id,
    required this.timestamp,
    required this.waistCm,
    required this.thighCm,
    required this.weightKg,
    required this.bmi,
    required this.vatCm2,
    required this.riskCategory,
  });

  static RiskCategory calculateRiskCategory(double vat) {
    if (vat < 100) {
      return RiskCategory.healthy;
    } else if (vat < 130) {
      return RiskCategory.elevated;
    } else {
      return RiskCategory.obesity;
    }
  }
}

class RiskCategoryAdapter extends TypeAdapter<RiskCategory> {
  @override
  final int typeId = 2;

  @override
  RiskCategory read(BinaryReader reader) {
    return RiskCategory.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, RiskCategory obj) {
    writer.writeInt(obj.index);
  }
}

class MeasurementAdapter extends TypeAdapter<Measurement> {
  @override
  final int typeId = 3;

  @override
  Measurement read(BinaryReader reader) {
    return Measurement(
      id: reader.readString(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      waistCm: reader.readDouble(),
      thighCm: reader.readDouble(),
      weightKg: reader.readDouble(),
      bmi: reader.readDouble(),
      vatCm2: reader.readDouble(),
      riskCategory: RiskCategory.values[reader.readInt()],
    );
  }

  @override
  void write(BinaryWriter writer, Measurement obj) {
    writer.writeString(obj.id);
    writer.writeInt(obj.timestamp.millisecondsSinceEpoch);
    writer.writeDouble(obj.waistCm);
    writer.writeDouble(obj.thighCm);
    writer.writeDouble(obj.weightKg);
    writer.writeDouble(obj.bmi);
    writer.writeDouble(obj.vatCm2);
    writer.writeInt(obj.riskCategory.index);
  }
}
