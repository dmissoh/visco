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

// VAT Goal provider
final vatGoalProvider = NotifierProvider<VatGoalNotifier, double?>(() {
  return VatGoalNotifier();
});

class VatGoalNotifier extends Notifier<double?> {
  late Box _box;

  @override
  double? build() {
    _box = Hive.box(settingsBoxName);
    final goal = _box.get('vatGoal') as double?;
    return goal;
  }

  Future<void> setGoal(double? goal) async {
    if (goal == null) {
      await _box.delete('vatGoal');
    } else {
      await _box.put('vatGoal', goal);
    }
    state = goal;
  }
}
