import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class CustomNotification {
  final int id;
  final String title;
  final String body;
  final String payload;

  CustomNotification(
      {required this.id,
      required this.title,
      required this.body,
      required this.payload});
}

class NotifcationServirce{
  late FlutterLocalNotificationsPlugin localNotificationsPlugin;
  late AndroidNotificationDetails androidDetails;

  NotifcationServirce(){
    localNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _setupNotifications();
  }

  _setupNotifications()async{
    await _initializeNotification();
  }
  _initializeNotification()async{
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    await localNotificationsPlugin.initialize(
      const InitializationSettings(
        android: android
      ),
      onSelectNotification: (payload) => _onSelectNotification(payload: payload),
    );
  }
  void _onSelectNotification({String? payload}){
      if(payload != null && payload.isNotEmpty){
        print('teste payload');
      }
    }
  showNotification(CustomNotification notification){
    androidDetails = const AndroidNotificationDetails(
      'lembretes_notifications',
      'lembretes',
      importance: Importance.max,
      priority: Priority.max,
      );
      localNotificationsPlugin.show(notification.id, notification.title, notification.body, NotificationDetails(
        android: androidDetails
      ),
      payload: notification.payload
      );
  }
}