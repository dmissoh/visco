import 'package:hive/hive.dart';

enum RiskCategory {
  healthy,
  elevated,
  obesity,
}

class Measurement extends HiveObject {
  String id;
  String profileId;
  DateTime timestamp;
  double waistCm;
  double thighCm;
  double weightKg;
  double bmi;
  double vatCm2;
  RiskCategory riskCategory;

  Measurement({
    required this.id,
    required this.profileId,
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
    final numFields = reader.readByte();
    String id = '';
    String profileId = '';
    DateTime timestamp = DateTime.now();
    double waistCm = 0;
    double thighCm = 0;
    double weightKg = 0;
    double bmi = 0;
    double vatCm2 = 0;
    RiskCategory riskCategory = RiskCategory.healthy;

    for (int i = 0; i < numFields; i++) {
      final fieldId = reader.readByte();
      switch (fieldId) {
        case 0:
          id = reader.readString();
          break;
        case 1:
          profileId = reader.readString();
          break;
        case 2:
          timestamp = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
          break;
        case 3:
          waistCm = reader.readDouble();
          break;
        case 4:
          thighCm = reader.readDouble();
          break;
        case 5:
          weightKg = reader.readDouble();
          break;
        case 6:
          bmi = reader.readDouble();
          break;
        case 7:
          vatCm2 = reader.readDouble();
          break;
        case 8:
          riskCategory = RiskCategory.values[reader.readInt()];
          break;
      }
    }

    return Measurement(
      id: id,
      profileId: profileId,
      timestamp: timestamp,
      waistCm: waistCm,
      thighCm: thighCm,
      weightKg: weightKg,
      bmi: bmi,
      vatCm2: vatCm2,
      riskCategory: riskCategory,
    );
  }

  @override
  void write(BinaryWriter writer, Measurement obj) {
    writer.writeByte(9); // number of fields
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeString(obj.profileId);
    writer.writeByte(2);
    writer.writeInt(obj.timestamp.millisecondsSinceEpoch);
    writer.writeByte(3);
    writer.writeDouble(obj.waistCm);
    writer.writeByte(4);
    writer.writeDouble(obj.thighCm);
    writer.writeByte(5);
    writer.writeDouble(obj.weightKg);
    writer.writeByte(6);
    writer.writeDouble(obj.bmi);
    writer.writeByte(7);
    writer.writeDouble(obj.vatCm2);
    writer.writeByte(8);
    writer.writeInt(obj.riskCategory.index);
  }
}
