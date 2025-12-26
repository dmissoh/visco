import 'package:hive/hive.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

class ProfileRepository {
  final Box<UserProfile> _box;

  ProfileRepository(this._box);

  UserProfile? getProfile() {
    if (_box.isEmpty) return null;
    return _box.getAt(0);
  }

  Future<void> saveProfile(UserProfile profile) async {
    if (_box.isEmpty) {
      await _box.add(profile);
    } else {
      await _box.putAt(0, profile);
    }
  }

  Future<void> updateProfile(UserProfile profile) async {
    await profile.save();
  }

  Future<void> deleteProfile() async {
    await _box.clear();
  }

  Stream<UserProfile?> watchProfile() {
    return _box.watch().map((_) => getProfile());
  }
}
