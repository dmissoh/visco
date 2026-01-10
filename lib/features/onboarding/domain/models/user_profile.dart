import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

enum Sex {
  male,
  female,
}

class UserProfile extends HiveObject {
  String id;
  String name;
  Sex sex;
  DateTime birthDate;
  double heightCm;
  String? profileImagePath;

  UserProfile({
    String? id,
    required this.name,
    required this.sex,
    required this.birthDate,
    required this.heightCm,
    this.profileImagePath,
  }) : id = id ?? const Uuid().v4();

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
    final numFields = reader.readByte();
    String id = '';
    String name = '';
    Sex sex = Sex.female;
    DateTime birthDate = DateTime.now();
    double heightCm = 170;
    String? profileImagePath;

    for (int i = 0; i < numFields; i++) {
      final fieldId = reader.readByte();
      switch (fieldId) {
        case 0:
          id = reader.readString();
          break;
        case 1:
          name = reader.readString();
          break;
        case 2:
          sex = Sex.values[reader.readInt()];
          break;
        case 3:
          birthDate = DateTime.fromMillisecondsSinceEpoch(reader.readInt());
          break;
        case 4:
          heightCm = reader.readDouble();
          break;
        case 5:
          final imagePath = reader.readString();
          profileImagePath = imagePath.isEmpty ? null : imagePath;
          break;
      }
    }

    return UserProfile(
      id: id.isEmpty ? null : id,
      name: name.isEmpty ? 'Profile' : name,
      sex: sex,
      birthDate: birthDate,
      heightCm: heightCm,
      profileImagePath: profileImagePath,
    );
  }

  @override
  void write(BinaryWriter writer, UserProfile obj) {
    writer.writeByte(6); // number of fields
    writer.writeByte(0);
    writer.writeString(obj.id);
    writer.writeByte(1);
    writer.writeString(obj.name);
    writer.writeByte(2);
    writer.writeInt(obj.sex.index);
    writer.writeByte(3);
    writer.writeInt(obj.birthDate.millisecondsSinceEpoch);
    writer.writeByte(4);
    writer.writeDouble(obj.heightCm);
    writer.writeByte(5);
    writer.writeString(obj.profileImagePath ?? '');
  }
}
