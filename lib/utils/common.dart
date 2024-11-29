import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class Utils {
  static fieldFocusChange(
    BuildContext context,
    FocusNode current,
    FocusNode next,
  ) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static hiddenKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode());
  }

  static Future<DeviceModel?> getDeviceInfo() async {
    final deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        final android = await deviceInfoPlugin.androidInfo;
        return DeviceModel(
          uuid: android.id,
          model: "Android",
          version: android.version.sdkInt.toString(),
          type: android.model,
        );
      } else if (Platform.isIOS) {
        final IosDeviceInfo ios = await deviceInfoPlugin.iosInfo;
        return DeviceModel(
          uuid: ios.identifierForVendor ?? "",
          name: ios.name,
          model: ios.systemName,
          version: ios.systemVersion,
          type: ios.utsname.machine,
        );
      }
    } catch (e) {
      UtilLogger.log("ERROR", e);
    }
    return null;
  }

  static Future<String?> getDeviceToken() async {
    await FirebaseMessaging.instance.requestPermission();
    return await FirebaseMessaging.instance.getToken();
  }

  static Future<Position?> getLocations() async {
    try {
      LocationPermission? permissionStatus;

      permissionStatus = await Geolocator.checkPermission();
      if (permissionStatus == LocationPermission.denied) {
        permissionStatus = await Geolocator.requestPermission();
        if (permissionStatus == LocationPermission.denied) {
          return null;
        }
      }

      return await Geolocator.getLastKnownPosition();
    } catch (e) {
      AppBloc.messageBloc.add(MessageEvent(message: e.toString()));
      return null;
    }
  }

  ///Singleton factory
  static final Utils _instance = Utils._internal();

  factory Utils() {
    return _instance;
  }

  Utils._internal();
}
