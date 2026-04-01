import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'dart:math';
import 'package:ai_fitness/core/constants/app_constants.dart';
import 'package:ai_fitness/core/utils/app_logger.dart';

abstract class NotificationService {
  Future<void> initialize();
  Future<void> scheduleDailyMotivation(
    int hour,
    int minute,
  );
  Future<void> cancelScheduledNotification();
  Future<void> showInstantNotification(String title, String body);
}

class NotificationServiceImpl implements NotificationService {
  final FlutterLocalNotificationsPlugin _notificationsPlugin;

  NotificationServiceImpl(this._notificationsPlugin);

  @override
  Future<void> initialize() async {
    try {
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const InitializationSettings initializationSettings =
          InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await _notificationsPlugin.initialize(initializationSettings);

      // Create notification channel for Android
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        AppConstants.notificationChannelId,
        AppConstants.notificationChannelName,
        description: AppConstants.notificationChannelDescription,
        importance: Importance.high,
      );

      await _notificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      AppLogger.info('Notification service initialized');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to initialize notifications', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> scheduleDailyMotivation(int hour, int minute) async {
    try {
      final randomMessage = AppConstants
          .motivationMessages[Random().nextInt(
        AppConstants.motivationMessages.length,
      )];

      // Schedule for every day at the specified time
      await _notificationsPlugin.zonedSchedule(
        AppConstants.notificationId,
        'Daily Motivation 💪',
        randomMessage,
        _nextInstanceOfTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            AppConstants.notificationChannelId,
            AppConstants.notificationChannelName,
            channelDescription: AppConstants.notificationChannelDescription,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
          iOS: DarwinNotificationDetails(
            sound: 'default',
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAndAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.utcRelativeToPhoneTimezone,
        matchDateTimeComponents: DateTimeComponents.time,
      );

      AppLogger.info('Daily motivation scheduled for $hour:$minute');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to schedule notification', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> cancelScheduledNotification() async {
    try {
      await _notificationsPlugin.cancel(AppConstants.notificationId);
      AppLogger.info('Notification cancelled');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to cancel notification', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<void> showInstantNotification(String title, String body) async {
    try {
      const NotificationDetails platformChannelSpecifics = NotificationDetails(
        android: AndroidNotificationDetails(
          AppConstants.notificationChannelId,
          AppConstants.notificationChannelName,
          channelDescription: AppConstants.notificationChannelDescription,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          sound: 'default',
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await _notificationsPlugin.show(
        0,
        title,
        body,
        platformChannelSpecifics,
      );

      AppLogger.info('Instant notification shown: $title');
    } catch (e, stackTrace) {
      AppLogger.error('Failed to show notification', e, stackTrace);
      rethrow;
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
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

    return scheduledDate;
  }
}
