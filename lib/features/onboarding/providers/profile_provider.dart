import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:visco/core/providers/database_provider.dart';
import 'package:visco/features/onboarding/data/repositories/profile_repository.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';
import 'package:visco/features/settings/providers/settings_provider.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final box = ref.watch(profileBoxProvider);
  return ProfileRepository(box);
});

// Trigger to refresh profile list
final profileRefreshProvider = StateProvider<int>((ref) => 0);

// All profiles
final allProfilesProvider = Provider<List<UserProfile>>((ref) {
  ref.watch(profileRefreshProvider);
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getAllProfiles();
});

// Active profile ID (stored in settings)
final activeProfileIdProvider = StateProvider<String?>((ref) {
  final box = Hive.box(settingsBoxName);
  return box.get('activeProfileId') as String?;
});

// Current active profile
final profileNotifierProvider =
    NotifierProvider<ProfileNotifier, UserProfile?>(() => ProfileNotifier());

class ProfileNotifier extends Notifier<UserProfile?> {
  @override
  UserProfile? build() {
    ref.watch(profileRefreshProvider);
    final repository = ref.watch(profileRepositoryProvider);
    final activeId = ref.watch(activeProfileIdProvider);
    
    if (activeId != null) {
      final profile = repository.getProfileById(activeId);
      if (profile != null) return profile;
    }
    
    // Fall back to first profile if active not found
    return repository.getFirstProfile();
  }

  Future<void> saveProfile({
    required String name,
    required Sex sex,
    required DateTime birthDate,
    required double heightCm,
    String? id,
  }) async {
    final repository = ref.read(profileRepositoryProvider);

    final profile = UserProfile(
      id: id,
      name: name,
      sex: sex,
      birthDate: birthDate,
      heightCm: heightCm,
    );

    await repository.saveProfile(profile);
    await _setActiveProfile(profile.id);
    ref.invalidateSelf();
    ref.read(profileRefreshProvider.notifier).state++;
  }

  Future<void> switchProfile(String profileId) async {
    await _setActiveProfile(profileId);
    ref.invalidateSelf();
  }

  Future<void> _setActiveProfile(String profileId) async {
    final box = Hive.box(settingsBoxName);
    await box.put('activeProfileId', profileId);
    ref.read(activeProfileIdProvider.notifier).state = profileId;
  }

  Future<void> updateProfile({
    String? name,
    Sex? sex,
    DateTime? birthDate,
    double? heightCm,
  }) async {
    final currentProfile = state;
    if (currentProfile == null) return;

    final repository = ref.read(profileRepositoryProvider);

    final updatedProfile = UserProfile(
      id: currentProfile.id,
      name: name ?? currentProfile.name,
      sex: sex ?? currentProfile.sex,
      birthDate: birthDate ?? currentProfile.birthDate,
      heightCm: heightCm ?? currentProfile.heightCm,
    );

    await repository.saveProfile(updatedProfile);
    ref.invalidateSelf();
    ref.read(profileRefreshProvider.notifier).state++;
  }

  Future<void> deleteProfile([String? id]) async {
    final repository = ref.read(profileRepositoryProvider);
    final profileIdToDelete = id ?? state?.id;
    
    if (profileIdToDelete != null) {
      await repository.deleteProfile(profileIdToDelete);
      
      // If we deleted the active profile, switch to another
      if (state?.id == profileIdToDelete) {
        final remaining = repository.getAllProfiles();
        if (remaining.isNotEmpty) {
          await _setActiveProfile(remaining.first.id);
        } else {
          final box = Hive.box(settingsBoxName);
          await box.delete('activeProfileId');
          ref.read(activeProfileIdProvider.notifier).state = null;
        }
      }
    }
    
    ref.invalidateSelf();
    ref.read(profileRefreshProvider.notifier).state++;
  }

  Future<void> deleteAllProfiles() async {
    final repository = ref.read(profileRepositoryProvider);
    await repository.deleteAllProfiles();
    
    final box = Hive.box(settingsBoxName);
    await box.delete('activeProfileId');
    ref.read(activeProfileIdProvider.notifier).state = null;
    
    ref.invalidateSelf();
    ref.read(profileRefreshProvider.notifier).state++;
  }
}
