import 'dart:convert';
import 'package:bobobox_restaurant/common/navigation.dart';
import 'package:bobobox_restaurant/data/model/list_restaurant_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/subjects.dart';
final selectNotificationSubject = BehaviorSubject<String>();
 
class NotificationHelper {
  static NotificationHelper _instance;
 
  NotificationHelper._internal() {
    _instance = this;
  }
 
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();
 
  Future<void> initNotifications(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        const AndroidInitializationSettings('app_icon');
 
    var initializationSettingsIOS = const IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
 
    var initializationSettings = InitializationSettings(
       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
 
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }
 
  Future<void> showNotification(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
     ListRestaurantModel articles) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding news channel"; 
 
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, 
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: const DefaultStyleInformation(true, true));
 
    var iOSPlatformChannelSpecifics = const IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
 
    var titleNotification = "<b>Top Restaurant</b>";
    var titleNews = articles.restaurants[0].name;
 
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleNews, platformChannelSpecifics,
        payload: json.encode(articles.toJson()));
  }
 
  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = ListRestaurantModel.fromJson(json.decode(payload));
        var article = data.restaurants[0];
        Navigation.intentWithData(route, article);
      },
    );
  }
}