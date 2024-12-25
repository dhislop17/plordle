import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

enum DeviceType { androidEmulator, androidPhysical, iosSimulator, iosPhysical }

class PlatformConfig {
  static final PlatformConfig _instance = PlatformConfig._internal();
  factory PlatformConfig() => _instance;
  PlatformConfig._internal();
  late final DeviceType deviceType;

  Future<void> initialize() async {
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
    }

    switch (deviceType) {
      case DeviceType.androidEmulator:
        return '10.0.2.2';
      case DeviceType.iosSimulator:
        return 'localhost';
      case DeviceType.androidPhysical || DeviceType.iosPhysical:
        return dotenv.env["LOCAL_SERVER_IP"] ?? '192.168.1.0';
    }
  }
}
