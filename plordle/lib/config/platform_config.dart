import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum DeviceType {
  androidEmulator,
  androidPhysical,
  iosSimulator,
  iosPhysical,
  web
}

class PlatformConfig {
  static final PlatformConfig _instance = PlatformConfig._internal();
  factory PlatformConfig() => _instance;
  PlatformConfig._internal();
  late final DeviceType deviceType;

  Future<void> initialize() async {
    if (kIsWeb) {
      deviceType = DeviceType.web;
      return;
    }

    final deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      deviceType = (await deviceInfo.androidInfo).isPhysicalDevice
          ? DeviceType.androidPhysical
          : DeviceType.androidEmulator;
    } else {
      deviceType = (await deviceInfo.iosInfo).isPhysicalDevice
          ? DeviceType.iosPhysical
          : DeviceType.iosSimulator;
    }
  }

  String get baseUrl {
    if (dotenv.env["API_CONNECTION_STRING"] != null) {
      return dotenv.env["API_CONNECTION_STRING"]!;
    } else if (deviceType == DeviceType.iosSimulator ||
        deviceType == DeviceType.web) {
      return "localhost";
    } else {
      return "10.0.2.2";
    }
  }
}
