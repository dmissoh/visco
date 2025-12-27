import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:visco/core/providers/database_provider.dart';
import 'package:visco/features/onboarding/data/repositories/profile_repository.dart';
import 'package:visco/features/onboarding/domain/models/user_profile.dart';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final box = ref.watch(profileBoxProvider);
  return ProfileRepository(box);
});

final profileProvider = Provider<UserProfile?>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getProfile();
});

final profileNotifierProvider =
    NotifierProvider<ProfileNotifier, UserProfile?>(() => ProfileNotifier());

class ProfileNotifier extends Notifier<UserProfile?> {
  @override
  UserProfile? build() {
    final repository = ref.watch(profileRepositoryProvider);
    return repository.getProfile();
  }

  Future<void> saveProfile({
    required Sex sex,
    required DateTime birthDate,
    required double heightCm,
  }) async {
    final repository = ref.read(profileRepositoryProvider);

    final profile = UserProfile(
      sex: sex,
      birthDate: birthDate,
      heightCm: heightCm,
    );

    await repository.saveProfile(profile);
    ref.invalidateSelf();
  }

  Future<void> updateProfile({
    Sex? sex,
    DateTime? birthDate,
    double? heightCm,
  }) async {
    final currentProfile = state;
    if (currentProfile == null) return;

    final repository = ref.read(profileRepositoryProvider);

    final updatedProfile = UserProfile(
      sex: sex ?? currentProfile.sex,
      birthDate: birthDate ?? currentProfile.birthDate,
      heightCm: heightCm ?? currentProfile.heightCm,
    );

    await repository.saveProfile(updatedProfile);
    ref.invalidateSelf();
  }

  Future<void> deleteProfile() async {
    final repository = ref.read(profileRepositoryProvider);
    await repository.deleteProfile();
    ref.invalidateSelf();
  }
}
