import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

const settingsBoxName = 'settings';

// Supported locales
const supportedLocales = [
  Locale('en'),
  Locale('de'),
  Locale('fr'),
];

// Unit system enum
enum UnitSystem { metric, imperial }

// Locale provider
final localeProvider = NotifierProvider<LocaleNotifier, Locale?>(() {
  return LocaleNotifier();
});

class LocaleNotifier extends Notifier<Locale?> {
  late Box _box;

  @override
  Locale? build() {
    _box = Hive.box(settingsBoxName);
    final localeCode = _box.get('locale') as String?;
    if (localeCode == null) {
      // Use system locale if available and supported, otherwise null (system default)
      final systemLocale = PlatformDispatcher.instance.locale;
      final matchingLocale = supportedLocales.where(
        (l) => l.languageCode == systemLocale.languageCode
      ).firstOrNull;
      return matchingLocale;
    }
    return Locale(localeCode);
  }

  Future<void> setLocale(Locale? locale) async {
    if (locale == null) {
      await _box.delete('locale');
    } else {
      await _box.put('locale', locale.languageCode);
    }
    state = locale;
  }
}

// Theme provider
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

// Unit system provider
final unitSystemProvider = NotifierProvider<UnitSystemNotifier, UnitSystem>(() {
  return UnitSystemNotifier();
});

class UnitSystemNotifier extends Notifier<UnitSystem> {
  late Box _box;

  @override
  UnitSystem build() {
    _box = Hive.box(settingsBoxName);
    final unitIndex = _box.get('unitSystem', defaultValue: 0) as int;
    return UnitSystem.values[unitIndex];
  }

  Future<void> setUnitSystem(UnitSystem system) async {
    await _box.put('unitSystem', system.index);
    state = system;
  }
}

// Unit conversion helpers
class UnitConverter {
  // Weight conversions
  static double kgToLbs(double kg) => kg * 2.20462;
  static double lbsToKg(double lbs) => lbs / 2.20462;
  
  // Length conversions (cm to inches)
  static double cmToInches(double cm) => cm / 2.54;
  static double inchesToCm(double inches) => inches * 2.54;
  
  // Height conversions (cm to feet/inches)
  static (int feet, double inches) cmToFeetInches(double cm) {
    final totalInches = cmToInches(cm);
    final feet = (totalInches / 12).floor();
    final inches = totalInches % 12;
    return (feet, inches);
  }
  
  static double feetInchesToCm(int feet, double inches) {
    final totalInches = (feet * 12) + inches;
    return inchesToCm(totalInches);
  }
  
  // Display helpers
  static String formatWeight(double kg, UnitSystem system) {
    if (system == UnitSystem.imperial) {
      return '${kgToLbs(kg).toStringAsFixed(1)} lbs';
    }
    return '${kg.toStringAsFixed(1)} kg';
  }
  
  static String formatLength(double cm, UnitSystem system) {
    if (system == UnitSystem.imperial) {
      return '${cmToInches(cm).toStringAsFixed(1)} in';
    }
    return '${cm.toStringAsFixed(1)} cm';
  }
  
  static String formatHeight(double cm, UnitSystem system) {
    if (system == UnitSystem.imperial) {
      final (feet, inches) = cmToFeetInches(cm);
      return "$feet'${inches.toStringAsFixed(0)}\"";
    }
    return '${cm.toStringAsFixed(0)} cm';
  }
  
  static String weightUnit(UnitSystem system) => system == UnitSystem.imperial ? 'lbs' : 'kg';
  static String lengthUnit(UnitSystem system) => system == UnitSystem.imperial ? 'in' : 'cm';
}

// Reminder frequency enum
enum ReminderFrequency { off, weekly, monthly }

// Reminder settings provider
final reminderSettingsProvider = NotifierProvider<ReminderSettingsNotifier, ReminderSettings>(() {
  return ReminderSettingsNotifier();
});

class ReminderSettings {
  final ReminderFrequency frequency;
  final int hour;
  final int minute;
  final int dayOfWeek; // 1 = Monday, 7 = Sunday (for weekly)
  final int dayOfMonth; // 1-28 (for monthly, capped at 28 for safety)

  const ReminderSettings({
    this.frequency = ReminderFrequency.off,
    this.hour = 9,
    this.minute = 0,
    this.dayOfWeek = 1,
    this.dayOfMonth = 1,
  });

  ReminderSettings copyWith({
    ReminderFrequency? frequency,
    int? hour,
    int? minute,
    int? dayOfWeek,
    int? dayOfMonth,
  }) {
    return ReminderSettings(
      frequency: frequency ?? this.frequency,
      hour: hour ?? this.hour,
      minute: minute ?? this.minute,
      dayOfWeek: dayOfWeek ?? this.dayOfWeek,
      dayOfMonth: dayOfMonth ?? this.dayOfMonth,
    );
  }
}

class ReminderSettingsNotifier extends Notifier<ReminderSettings> {
  late Box _box;

  @override
  ReminderSettings build() {
    _box = Hive.box(settingsBoxName);
    final frequencyIndex = _box.get('reminderFrequency', defaultValue: 0) as int;
    final hour = _box.get('reminderHour', defaultValue: 9) as int;
    final minute = _box.get('reminderMinute', defaultValue: 0) as int;
    final dayOfWeek = _box.get('reminderDayOfWeek', defaultValue: 1) as int;
    final dayOfMonth = _box.get('reminderDayOfMonth', defaultValue: 1) as int;
    
    // Handle migration from old daily frequency (index 1) to off
    // Old: off=0, daily=1, weekly=2
    // New: off=0, weekly=1, monthly=2
    final safeFrequencyIndex = frequencyIndex.clamp(0, ReminderFrequency.values.length - 1);
    
    return ReminderSettings(
      frequency: ReminderFrequency.values[safeFrequencyIndex],
      hour: hour,
      minute: minute,
      dayOfWeek: dayOfWeek,
      dayOfMonth: dayOfMonth,
    );
  }

  Future<void> updateSettings(ReminderSettings settings) async {
    await _box.put('reminderFrequency', settings.frequency.index);
    await _box.put('reminderHour', settings.hour);
    await _box.put('reminderMinute', settings.minute);
    await _box.put('reminderDayOfWeek', settings.dayOfWeek);
    await _box.put('reminderDayOfMonth', settings.dayOfMonth);
    state = settings;
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
    // Default goal is 100 cm² (healthy threshold)
    return _box.get(_goalKey, defaultValue: 100.0) as double?;
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
