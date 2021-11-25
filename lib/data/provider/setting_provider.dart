import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/date_time_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  SettingProvider setup() {
    _setup();
    return this;
  }

  void _setup() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    bool _schedule = _pref.getBool('isSchedule') ?? false;
    _isScheduled = _schedule;
    notifyListeners();
  }

  bool get isScheduled => _isScheduled;

  Future<bool> setScheduled(bool value) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    await _pref.setBool('isSchedule', value);
    _isScheduled = value;
    print(_isScheduled);
    notifyListeners();
    if (_isScheduled) {
      print('Notif active');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Notif canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
