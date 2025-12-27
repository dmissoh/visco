import 'package:hive/hive.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

class ProfileRepository {
  final Box<UserProfile> _box;

  ProfileRepository(this._box);

  List<UserProfile> getAllProfiles() {
    return _box.values.toList();
  }

  UserProfile? getProfileById(String id) {
    try {
      return _box.values.firstWhere((p) => p.id == id);
    } catch (_) {
      return null;
    }
  }

  UserProfile? getFirstProfile() {
    if (_box.isEmpty) return null;
    return _box.getAt(0);
  }

  Future<void> saveProfile(UserProfile profile) async {
    // Check if profile with this ID already exists
    final existingIndex = _box.values.toList().indexWhere((p) => p.id == profile.id);
    
    if (existingIndex >= 0) {
      await _box.putAt(existingIndex, profile);
    } else {
      await _box.add(profile);
    }
  }

  Future<void> deleteProfile(String id) async {
    final index = _box.values.toList().indexWhere((p) => p.id == id);
    if (index >= 0) {
      await _box.deleteAt(index);
    }
  }

  Future<void> deleteAllProfiles() async {
    await _box.clear();
  }

  int get profileCount => _box.length;

  Stream<List<UserProfile>> watchProfiles() {
    return _box.watch().map((_) => getAllProfiles());
  }
}
