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

/// Tracks whether user has completed or skipped onboarding
final onboardingCompletedProvider = StateProvider<bool>((ref) {
  final box = Hive.box(settingsBoxName);
  return box.get('onboardingCompleted', defaultValue: false) as bool;
});

/// Mark onboarding as completed (or skipped)
Future<void> markOnboardingCompleted(WidgetRef ref) async {
  final box = Hive.box(settingsBoxName);
  await box.put('onboardingCompleted', true);
  ref.read(onboardingCompletedProvider.notifier).state = true;
}

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
    final refreshNotifier = ref.read(profileRefreshProvider.notifier);
    final activeIdNotifier = ref.read(activeProfileIdProvider.notifier);

    final profile = UserProfile(
      id: id,
      name: name,
      sex: sex,
      birthDate: birthDate,
      heightCm: heightCm,
    );

    await repository.saveProfile(profile);
    
    // Set active profile
    final box = Hive.box(settingsBoxName);
    await box.put('activeProfileId', profile.id);
    activeIdNotifier.state = profile.id;
    
    refreshNotifier.state++;
  }

  Future<void> switchProfile(String profileId) async {
    final activeIdNotifier = ref.read(activeProfileIdProvider.notifier);
    
    final box = Hive.box(settingsBoxName);
    await box.put('activeProfileId', profileId);
    activeIdNotifier.state = profileId;
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
    final refreshNotifier = ref.read(profileRefreshProvider.notifier);

    final updatedProfile = UserProfile(
      id: currentProfile.id,
      name: name ?? currentProfile.name,
      sex: sex ?? currentProfile.sex,
      birthDate: birthDate ?? currentProfile.birthDate,
      heightCm: heightCm ?? currentProfile.heightCm,
    );

    await repository.saveProfile(updatedProfile);
    refreshNotifier.state++;
  }

  Future<void> deleteProfile([String? id]) async {
    final repository = ref.read(profileRepositoryProvider);
    final refreshNotifier = ref.read(profileRefreshProvider.notifier);
    final activeIdNotifier = ref.read(activeProfileIdProvider.notifier);
    final profileIdToDelete = id ?? state?.id;
    final currentProfileId = state?.id;
    
    if (profileIdToDelete != null) {
      await repository.deleteProfile(profileIdToDelete);
      
      // If we deleted the active profile, switch to another
      if (currentProfileId == profileIdToDelete) {
        final remaining = repository.getAllProfiles();
        if (remaining.isNotEmpty) {
          final box = Hive.box(settingsBoxName);
          await box.put('activeProfileId', remaining.first.id);
          activeIdNotifier.state = remaining.first.id;
        } else {
          final box = Hive.box(settingsBoxName);
          await box.delete('activeProfileId');
          activeIdNotifier.state = null;
        }
      }
    }
    
    refreshNotifier.state++;
  }

  Future<void> deleteAllProfiles() async {
    final repository = ref.read(profileRepositoryProvider);
    final refreshNotifier = ref.read(profileRefreshProvider.notifier);
    final activeIdNotifier = ref.read(activeProfileIdProvider.notifier);
    
    await repository.deleteAllProfiles();
    
    final box = Hive.box(settingsBoxName);
    await box.delete('activeProfileId');
    activeIdNotifier.state = null;
    
    refreshNotifier.state++;
  }
}
