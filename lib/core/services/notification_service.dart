import 'dart:developer' as dev;
import 'dart:io' show Platform;

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz_data;

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  static const _channelId = 'visco_reminders';
  static const _channelName = 'Measurement Reminders';
  static const _channelDescription = 'Reminders to take your measurements';

  bool _initialized = false;

  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      // Initialize timezone database
      tz_data.initializeTimeZones();
      
      // Get device timezone and set it as local
      final String timeZoneName = await FlutterTimezone.getLocalTimezone();
      tz.setLocalLocation(tz.getLocation(timeZoneName));
      dev.log('NotificationService: Timezone set to $timeZoneName');

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

      final result = await _notifications.initialize(
        initSettings,
        onDidReceiveNotificationResponse: (NotificationResponse response) {
          dev.log('NotificationService: Notification tapped: ${response.payload}');
        },
      );
      
      _initialized = result ?? false;
      dev.log('NotificationService: Initialized successfully: $_initialized');
    } catch (e, stack) {
      dev.log('NotificationService: Failed to initialize: $e');
      dev.log('NotificationService: Stack trace: $stack');
    }
  }

  Future<bool> requestPermissions() async {
    try {
      // Ensure initialized first
      if (!_initialized) {
        await initialize();
      }
      
      bool granted = false;

      if (Platform.isAndroid) {
        final android = _notifications.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();
        if (android != null) {
          // Request notification permission (Android 13+)
          granted = await android.requestNotificationsPermission() ?? false;
          dev.log('NotificationService: Android notification permission: $granted');
          
          // Request exact alarm permission (Android 12+)
          await android.requestExactAlarmsPermission();
        }
      }

      if (Platform.isIOS) {
        final iOS = _notifications.resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>();
        if (iOS != null) {
          granted = await iOS.requestPermissions(
                alert: true,
                badge: true,
                sound: true,
              ) ??
              false;
          dev.log('NotificationService: iOS notification permission: $granted');
        } else {
          dev.log('NotificationService: iOS implementation is null');
        }
      }

      return granted;
    } catch (e, stack) {
      dev.log('NotificationService: Failed to request permissions: $e');
      dev.log('NotificationService: Stack trace: $stack');
      return false;
    }
  }

  /// Show an immediate test notification to verify the system is working
  Future<bool> showTestNotification() async {
    try {
      // Ensure initialized
      if (!_initialized) {
        await initialize();
      }
      
      // Request permissions first
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        dev.log('NotificationService: No permission for test notification');
        return false;
      }

      await _notifications.show(
        999, // Test notification ID
        'Test Notification',
        'Notifications are working correctly!',
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
      );
      
      dev.log('NotificationService: Test notification shown');
      return true;
    } catch (e, stack) {
      dev.log('NotificationService: Failed to show test notification: $e');
      dev.log('NotificationService: Stack trace: $stack');
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

  Future<bool> scheduleMonthlyReminder({
    required int dayOfMonth, // 1-28
    required int hour,
    required int minute,
  }) async {
    try {
      await cancelAllReminders();

      final now = tz.TZDateTime.now(tz.local);
      
      // Clamp day to 1-28 to ensure it exists in all months
      final safeDay = dayOfMonth.clamp(1, 28);
      
      var scheduledDate = tz.TZDateTime(
        tz.local,
        now.year,
        now.month,
        safeDay,
        hour,
        minute,
      );

      // If the scheduled date is in the past, move to next month
      if (scheduledDate.isBefore(now)) {
        if (now.month == 12) {
          scheduledDate = tz.TZDateTime(
            tz.local,
            now.year + 1,
            1,
            safeDay,
            hour,
            minute,
          );
        } else {
          scheduledDate = tz.TZDateTime(
            tz.local,
            now.year,
            now.month + 1,
            safeDay,
            hour,
            minute,
          );
        }
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
        matchDateTimeComponents: DateTimeComponents.dayOfMonthAndTime,
      );
      
      dev.log('NotificationService: Monthly reminder scheduled for $scheduledDate');
      return true;
    } catch (e) {
      dev.log('NotificationService: Failed to schedule monthly reminder: $e');
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
