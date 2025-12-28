import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

const settingsBoxName = 'settings';

final settingsProvider = NotifierProvider<SettingsNotifier, ThemeMode>(() {
  return SettingsNotifier();
});

class SettingsNotifier extends Notifier<ThemeMode> {
  late Box _box;

  @override
  ThemeMode build() {
    _box = Hive.box(settingsBoxName);
    final themeIndex = _box.get('themeMode', defaultValue: 0) as int;
    return ThemeMode.values[themeIndex];
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _box.put('themeMode', mode.index);
    state = mode;
  }
}

// VAT Goal provider (profile-specific)
// Uses a family provider to store goals per profile
final vatGoalFamilyProvider = NotifierProviderFamily<VatGoalNotifier, double?, String>(VatGoalNotifier.new);

class VatGoalNotifier extends FamilyNotifier<double?, String> {
  late Box _box;

  String get _goalKey => 'vatGoal_$arg';

  @override
  double? build(String arg) {
    _box = Hive.box(settingsBoxName);
    return _box.get(_goalKey) as double?;
  }

  Future<void> setGoal(double? goal) async {
    if (goal == null) {
      await _box.delete(_goalKey);
    } else {
      await _box.put(_goalKey, goal);
    }
    state = goal;
  }
}
