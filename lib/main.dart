import 'dart:io';

import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/setting_page.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'data/provider/providers.dart';
import 'ui/home_page.dart';
import 'utils/const.dart';

final flutterPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final _notificationHelper = NotificationHelper();
  final _service = BackgroundService();

  _service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterPlugin);

  runApp(GoNakamApp());
}

class GoNakamApp extends StatelessWidget {
  const GoNakamApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Repository>(create: (_) => Repository()),
        ChangeNotifierProvider<SettingProvider>(
            create: (_) => SettingProvider()),
      ],
      child: MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          primarySwatch: Colors.green,
          splashColor: Colors.lightGreen,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigatorKey,
        initialRoute: HomePage.routeName,
        routes: {
          HomePage.routeName: (_) => HomePage(),
          SearchPage.routeName: (_) => SearchPage(),
          FavoritePage.routeName: (_) => FavoritePage(),
          SettingPage.routeName: (_) => SettingPage(),
          DetailPage.routeName: (context) => DetailPage(
                restaurantId:
                    ModalRoute.of(context)!.settings.arguments as String,
              ),
        },
      ),
    );
  }
}
