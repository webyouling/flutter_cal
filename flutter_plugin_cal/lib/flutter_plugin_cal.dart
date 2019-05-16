import 'dart:async';

import 'package:flutter/services.dart';

class FlutterPluginCal {
  static const MethodChannel _channel =
      const MethodChannel('flutter_plugin_cal');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<String> calData(String info) async {
      final String result =
      await _channel.invokeMethod('calculate', {'infodata': info});
      return result;
    }
}