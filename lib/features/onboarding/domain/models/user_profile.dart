import 'package:hive/hive.dart';

enum Sex {
  male,
  female,
}

class UserProfile extends HiveObject {
  Sex sex;
  DateTime birthDate;
  double heightCm;

  UserProfile({
    required this.sex,
    required this.birthDate,
    required this.heightCm,
  });

  int get age {
    final now = DateTime.now();
    int calculatedAge = now.year - birthDate.year;
    if (now.month < birthDate.month ||
        (now.month == birthDate.month && now.day < birthDate.day)) {
      calculatedAge--;
    }
    return calculatedAge;
  }
}

class SexAdapter extends TypeAdapter<Sex> {
  @override
  final int typeId = 0;

  @override
  Sex read(BinaryReader reader) {
    return Sex.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, Sex obj) {
    writer.writeInt(obj.index);
  }
}

class UserProfileAdapter extends TypeAdapter<UserProfile> {
  @override
  final int typeId = 1;

  @override
  UserProfile read(BinaryReader reader) {
    return UserProfile(
      sex: Sex.values[reader.readInt()],
      birthDate: DateTime.fromMillisecondsSinceEpoch(reader.readInt()),
      heightCm: reader.readDouble(),
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.writeInt(obj.sex.index);
    writer.writeInt(obj.birthDate.millisecondsSinceEpoch);
    writer.writeDouble(obj.heightCm);
  }
}
