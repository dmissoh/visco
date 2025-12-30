import 'dart:developer' as dev;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'visco_reminders';
  static const _channelName = 'Measurement Reminders';
  static const _channelDescription = 'Reminders to take your measurements';

  Future<void> initialize() async {
    try {
      tz_data.initializeTimeZones();

      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: false,
        requestBadgePermission: false,
        requestSoundPermission: false,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _notifications.initialize(initSettings);
    } catch (e) {
      dev.log('NotificationService: Failed to initialize: $e');
    }
  }

  Future<bool> requestPermissions() async {
    try {
      final android = _notifications.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      final iOS = _notifications.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();

      bool granted = false;

      if (android != null) {
        // Request notification permission (Android 13+)
        granted = await android.requestNotificationsPermission() ?? false;
        
        // Request exact alarm permission (Android 12+)
        await android.requestExactAlarmsPermission();
      }

      if (iOS != null) {
        granted = await iOS.requestPermissions(
              alert: true,
              badge: true,
              sound: true,
            ) ??
            false;
      }

      return granted;
    } catch (e) {
      dev.log('NotificationService: Failed to request permissions: $e');
      return false;
    }
  }

  Future<bool> scheduleWeeklyReminder({
    required int dayOfWeek, // 1 = Monday, 7 = Sunday
    required int hour,
    required int minute,
  }) async {
    try {
      await cancelAllReminders();

      final now = tz.TZDateTime.now(tz.local);
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      // Find the next occurrence of the specified day
      while (scheduledDate.weekday != dayOfWeek || scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await _notifications.zonedSchedule(
        0,
        'Time to Measure',
        'Track your visceral fat progress with Visqo',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      );
      
      dev.log('NotificationService: Weekly reminder scheduled for $scheduledDate');
      return true;
    } catch (e) {
      dev.log('NotificationService: Failed to schedule weekly reminder: $e');
      return false;
    }
  }

  Future<bool> scheduleDailyReminder({
    required int hour,
    required int minute,
  }) async {
    try {
      await cancelAllReminders();

      final now = tz.TZDateTime.now(tz.local);
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        now.day,
        hour,
        minute,
      );

      if (scheduledDate.isBefore(now)) {
        scheduledDate = scheduledDate.add(const Duration(days: 1));
      }

      await _notifications.zonedSchedule(
        0,
        'Time to Measure',
        'Track your visceral fat progress with Visqo',
        scheduledDate,
        NotificationDetails(
          android: AndroidNotificationDetails(
            _channelId,
            _channelName,
            channelDescription: _channelDescription,
            importance: Importance.high,
            priority: Priority.high,
          ),
          iOS: const DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.inexactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
      
      dev.log('NotificationService: Daily reminder scheduled for $scheduledDate');
      return true;
    } catch (e) {
      dev.log('NotificationService: Failed to schedule daily reminder: $e');
      return false;
    }
  }

  Future<void> cancelAllReminders() async {
    try {
      await _notifications.cancelAll();
      dev.log('NotificationService: All reminders cancelled');
    } catch (e) {
      dev.log('NotificationService: Failed to cancel reminders: $e');
    }
  }

  Future<List<PendingNotificationRequest>> getPendingReminders() async {
    try {
      return await _notifications.pendingNotificationRequests();
    } catch (e) {
      dev.log('NotificationService: Failed to get pending reminders: $e');
      return [];
    }
  }
}
