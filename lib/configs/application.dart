import 'package:flutter/foundation.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:package_info_plus/package_info_plus.dart';

class Application {
  static bool debug = kDebugMode;
  static String domain = 'https://nearmi.info';
  static DeviceModel? device;
  static PackageInfo? packageInfo;
  static SettingModel setting = SettingModel.fromDefault();
  static bool storeReview = false;

  ///Singleton factory
  static final Application _instance = Application._internal();

  factory Application() {
    return _instance;
  }

  Application._internal();
}
