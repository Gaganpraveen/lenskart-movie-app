import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  static final instance = NotificationService._();
  NotificationService._();

  final _plugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const settings = InitializationSettings(android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    await _plugin.initialize(settings);
    await _plugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  Future<void> showPlaying(String title) async {
    const details = NotificationDetails(
      android: AndroidNotificationDetails('playback', 'Playback', importance: Importance.high, priority: Priority.high),
    );
    await _plugin.show(0, 'Now Playing', '$title is Playing', details);
  }
}
