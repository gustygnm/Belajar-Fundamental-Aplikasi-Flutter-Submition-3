import 'dart:isolate';
import 'dart:ui';
import 'package:bobobox_restaurant/data/api/api_service.dart';
import 'package:bobobox_restaurant/utils/notification_helper.dart';

import '../main.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService _service;
  static const String _isolateName = 'isolate';
  static SendPort _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    _service ??= BackgroundService._createObject();
    return _service;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().listRestaurant();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {
    print('Execute some process');
  }
}