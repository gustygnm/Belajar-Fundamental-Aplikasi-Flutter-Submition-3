import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:bobobox_restaurant/common/navigation.dart';
import 'package:bobobox_restaurant/provider/preference_provider.dart';
import 'package:bobobox_restaurant/ui/detail_restaurant/detail_restaurant_page.dart';
import 'package:bobobox_restaurant/ui/search_restaurant_page.dart';
import 'package:bobobox_restaurant/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/shared/preferences_helper..dart';
import 'ui/favorite_page.dart';
import 'ui/home_page.dart';
import 'ui/setting_page.dart';
import 'utils/background_service.dart';
import 'utils/notification_helper.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return
        MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (_) => PreferencesProvider(
              preferencesHelper: PreferencesHelper(
                sharedPreferences: SharedPreferences.getInstance(),
              ),
            ),
          ),
        ],
        child:
        ScreenUtilInit(
      designSize: const Size(360, 640),
      builder: () => MaterialApp(
        navigatorKey: navigatorKey,
        title: 'Bobobox Restaurant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const SplashPage(),
        routes: {
          HomePage.routeName: (context) => HomePage(),
          FavoritePage.routeName: (context) => FavoritePage(),
          SearchRestaurantPage.routeName: (context) => SearchRestaurantPage(),
          SettingPage.routeName: (context) => SettingPage(),
          DetailRestaurantPage.routeName: (context) => DetailRestaurantPage(
              restaurant: ModalRoute.of(context).settings.arguments),
        },
      ),
    )
      ,
    );
  }
}

class SearchPage {}
